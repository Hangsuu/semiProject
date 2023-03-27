package com.kh.poketdo.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberProfileDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.MemberDto;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private FileUploadProperties fileUploadProperties;
	
	private File dir;

	
	
	
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	public void join(MemberDto memberDto, MultipartFile attach) throws IllegalStateException, IOException {
		memberDao.insert(memberDto);
		
		if(!attach.isEmpty()) {
			int attachmentNo = attachmentDao.sequence();
			
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);
			
			attachmentDao.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize())
				.build());
		}
	}
	
	
	
}
