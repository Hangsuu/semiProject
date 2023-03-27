package com.kh.poketdo.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dao.PocketmonTypeImageDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.PocketmonTypeDto;
import com.kh.poketdo.dto.PocketmonTypeImageDto;
@Service
public class PocketmonTypeService {

	@Autowired
	private FileUploadProperties fileUploadProperties;
	@Autowired
	private AttachmentDao attachmentDao;
	@Autowired
	private PocketmonTypeDao pocketmonTypeDao;
	@Autowired
	private PocketmonTypeImageDao pocketmonTypeImageDao;
	

	private File dir;
	
	@PostConstruct	//최초 1번만 실행되는 메소드
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	public void pocketmonTypeInsert(
			PocketmonTypeDto pocketmonTypeDto,
			MultipartFile attach
			) throws IllegalStateException, IOException {
		//1. 포켓몬 정보 등록
		pocketmonTypeDao.insert(pocketmonTypeDto);
		
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
			//2-2 포켓몬정보테이블과 첨부파일 정보 연결
			pocketmonTypeImageDao.insert(PocketmonTypeImageDto.builder()
												.pocketTypeNo(pocketmonTypeDto.getPocketTypeNo())
												.attachmentNo(attachmentNo)
											.build());
		}
	}
	
	public void pocketmonEdit(
			PocketmonTypeDto pocketmonTypeDto,
			MultipartFile attach,
			@RequestParam int pocketTypeNo,
			RedirectAttributes attr
			) throws IllegalStateException, IOException {
		//1. 포켓몬 정보 수정
		pocketmonTypeDao.edit(pocketmonTypeDto);
		
		//2. 첨부한 파일이 있을경우
		if(!attach.isEmpty()) {
			pocketmonTypeImageDao.imageDelete(pocketTypeNo);
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
			pocketmonTypeImageDao.insert(PocketmonTypeImageDto.builder()
												.pocketTypeNo(pocketmonTypeDto.getPocketTypeNo())
												.attachmentNo(attachmentNo)
											.build());
		}
		attr.addAttribute("pocketTypeNo", pocketmonTypeDto.getPocketTypeNo());
	}
	
	
}
