package com.kh.poketdo.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberSealWithImageDao;
import com.kh.poketdo.dao.SealDao;
import com.kh.poketdo.dao.SealImageDao;
import com.kh.poketdo.dao.SealWithImageDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.SealDto;
import com.kh.poketdo.dto.SealImageDto;

@Service
public class SealService {

	@Autowired
	private FileUploadProperties fileUploadProperties;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private SealDao sealDao;
	@Autowired
	private SealImageDao sealImageDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MemberSealWithImageDao memberSealWithImageDao;
	@Autowired
	private SealWithImageDao sealWithImageDao;
	
	
	private File dir;
	
	@PostConstruct	//최초 1번만 실행되는 메소드
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	public void sealInsert(
			SealDto sealDto,
			MultipartFile attach
			) throws IllegalStateException, IOException {
		//1. 인장 정보 등록
		sealDao.insert(sealDto);
		
		//2. 첨부한 파일이 있을경우
		if(!attach.isEmpty()) {
			//2-1.첨부 파일 저장 및 등록
			int attachmentNo = attachmentDao.sequence();
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target); //저장
			
			attachmentDao.insert(AttachmentDto.builder()
										.attachmentNo(attachmentNo)
										.attachmentName(attach.getOriginalFilename())
										.attachmentType(attach.getContentType())
										.attachmentSize(attach.getSize())
									.build());
			//2-2 인장정보테이블과 첨부파일 정보 연결
			sealImageDao.insert(SealImageDto.builder()
												.sealNo(sealDto.getSealNo())
												.attachmentNo(attachmentNo)
											.build());
		}
	}
	
	public void sealEdit(
			SealDto sealDto,
			MultipartFile attach,
			@RequestParam int sealNo,
			RedirectAttributes attr
			) throws IllegalStateException, IOException {
		//1. 인장 정보 수정
		sealDao.edit(sealDto);
		
		//2. 첨부한 파일이 있을경우
		if(!attach.isEmpty()) {
			sealImageDao.imageDelete(sealNo);
			//2-1.첨부 파일 저장 및 등록
			int attachmentNo = attachmentDao.sequence();
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target); //저장
			
			attachmentDao.insert(AttachmentDto.builder()
										.attachmentNo(attachmentNo)
										.attachmentName(attach.getOriginalFilename())
										.attachmentType(attach.getContentType())
										.attachmentSize(attach.getSize())
									.build());
			//2-2 포켓몬정보테이블과 첨부파일 정보 연결
			sealImageDao.insert(SealImageDto.builder()
												.sealNo(sealDto.getSealNo())
												.attachmentNo(attachmentNo)
											.build());
		}
		attr.addAttribute("sealNo", sealDto.getSealNo());
	}
	
	//내 인장 이미지 주소 검색
	public String mySeal(HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		String memberSealNo = memberDao.selectMemberSealNo(memberId);

		if(memberSealNo.equals("0")) {
			String basicSealNo = sealWithImageDao.selectBasicAttachNo();
			return "/attachment/download?attachmentNo="+ basicSealNo;
		}else {
			String selectAttachNo = memberSealWithImageDao.selectAttachNo(memberId, memberSealNo);
    		return "/attachment/download?attachmentNo="+ selectAttachNo;
		}
	}
	
}
