package com.kh.poketdo.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.MemberProfileDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.MemberProfileDto;

@Controller
public class CardController {

	@Autowired
	private MemberProfileDao memberProfileDao;

	@Autowired
	private AttachmentDao attachmentDao;

	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(props.getPath());
		dir.mkdirs();
	}

	@GetMapping("/cardGenerator")
	public String cardGenerator() {
		return "/WEB-INF/views/member/cardGenerator.jsp";

	}

	// 1.아이디를 알아낸다
	// 2.파일을 저장한다
	// 3.아이디랑 파일을 연결한다

	@ResponseBody
	@PostMapping("/cardGenerator")
	public void cardGenerator(HttpSession session, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException {

		String memberId = (String) session.getAttribute("memberId");

		
		
		// 기존 파일 삭제
		MemberProfileDto memberProfileDto = memberProfileDao.selectOne(memberId);
		if (memberProfileDto != null) {
		    int attachmentNo = memberProfileDto.getAttachmentNo();
		    AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		    if (attachmentDto != null) {
		        File existingFile = new File(dir, String.valueOf(attachmentNo));
		        if (existingFile.exists()) {
		            existingFile.delete();
		        }
		        attachmentDao.delete(attachmentNo);
		    }
		    
		    File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);		
			
			attachmentDao.insert(
					AttachmentDto.builder().attachmentNo(attachmentNo).attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType()).attachmentSize(attach.getSize()).build());

			// 연결정보 등록
			memberProfileDao.insert(MemberProfileDto.builder().memberId(memberId).attachmentNo(attachmentNo).build());
			
		}
			
			if (!attach.isEmpty()) {
				int attachmentNo = attachmentDao.sequence();
			
			
		    // 새로운 파일 업로드
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);		
			
			attachmentDao.insert(
					AttachmentDto.builder().attachmentNo(attachmentNo).attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType()).attachmentSize(attach.getSize()).build());

			// 연결정보 등록
			memberProfileDao.insert(MemberProfileDto.builder().memberId(memberId).attachmentNo(attachmentNo).build());
			
			
		}

		
	}
}
