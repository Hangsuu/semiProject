package com.kh.poketdo.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberProfileDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.MemberProfileDto;




@Controller
public class CardController {



	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	
    @GetMapping("/cardGenerator")
    public String cardGenerator() {
    	return "/WEB-INF/views/member/cardGenerator.jsp";

    }
    
    @ResponseBody
    @PostMapping("/cardGenerator")
    public String profile(HttpSession session,
    			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
    
    	System.out.println(attach.getSize());
    	System.out.println(attach.getOriginalFilename());
    	System.out.println(attach.getContentType());
		
    	return "hello";
    	
//		//첨부파일 여부에 따라 프로필 등록
//		if(!attach.isEmpty()) {
//			int attachmentNo = attachmentDao.sequence(); 
//			
//			File dir = new File("D:/upload");
//			dir.mkdirs();
//			File target = new File(dir, String.valueOf(attachmentNo));
//			attach.transferTo(target);
//			
//			//데이터베이스 등록
//			attachmentDao.insert(AttachmentDto.builder()
//					.attachmentNo(attachmentNo)
//					.attachmentName(attach.getOriginalFilename())
//					.attachmentType(attach.getContentType())
//					.attachmentSize(attach.getSize())
//				.build());
//			
//			//연결정보 등록
//			memberProfileDao.insert(MemberProfileDto.builder()
//						.memberId(memberProfileDto.getMemberId())
//						.attachmentNo(attachmentNo)
//					.build());
		
		
//    	return "/WEB-INF/views/member/mypage.jsp";
    }
    



}