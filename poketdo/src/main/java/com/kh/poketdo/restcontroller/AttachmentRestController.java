package com.kh.poketdo.restcontroller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dto.AttachmentDto;

@CrossOrigin(origins= {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/attachment")
public class AttachmentRestController {
	//준비물
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
	
	//업로드
	@PostMapping("/upload")
	public AttachmentDto upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		
		if(!attach.isEmpty()) {	//파일이 있을 경우
			//번호생성
			int attachmentNo = attachmentDao.sequence();
			
			File dir = new File("D:/upload");	//파일 저장 위치
			dir.mkdirs(); 		//폴더 생성 명령
			File target = new File(dir, String.valueOf(attachmentNo));		//파일명은 int로 안들어감
			attach.transferTo(target);
			
			//DB 저장
			attachmentDao.insert(AttachmentDto.builder()	//빌더패턴을 이용한 DTO 입력
					.attachmentNo(attachmentNo)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize()).build()
					);
			return attachmentDao.selectOne(attachmentNo);
		}
		return null;
	}
	//다운로드
	
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(	//byte 배열을 포장한 클래스(이거 쓰라고 정해져있음)
			@PathVariable int attachmentNo) throws IOException {
		//DB 조회
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto==null) return ResponseEntity.notFound().build();
		
		//파일찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);	//ByteArrayResource 형태로 포장해줘야됨
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//헤더와 바디를 설정하며 ResponseEntity를 만들어 반환
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachmentDto.getAttachmentSize())	//제공되는 메소드로 헤더를 설정
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())	//제공되는 메소드 없음. 상수로 쓰는 방법
				.header(
					HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment().
						filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
						.build().toString()
				)
				.body(resource);
	}
}