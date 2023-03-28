package com.kh.poketdo.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dto.AttachmentDto;
import com.kh.poketdo.dto.AuctionDto;

@Service
public class AuctionService {
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private FileUploadProperties fileUploadProperties;
	private File dir;
	//최초 1회만 실행되는 메소드
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	public void join(AuctionDto auctionDto, MultipartFile attach) throws IllegalStateException, IOException {
		if(!attach.isEmpty()) {
			int attachmentNo = attachmentDao.sequence();
			
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);
			
			attachmentDao.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize()).build());
			
			auctionDao.insertImg(auctionDto.getAllboardNo(), attachmentNo);
		}
	}
}