package com.kh.poketdo.controller;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.poketdo.configuration.FileUploadProperties;
import com.kh.poketdo.dao.AttachmentDao;
import com.kh.poketdo.dto.AttachmentDto;

@RestController
@RequestMapping("/attachment")
public class AttachmentController {

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

  @GetMapping("/download")
  public ResponseEntity<ByteArrayResource> download(
    @RequestParam int attachmentNo
  ) throws IOException {
    //DB조회
    AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
    if (attachmentDto == null) {
      return ResponseEntity.notFound().build();
    }

    //파일찾기
    File target = new File(dir, String.valueOf(attachmentNo));

    //보낼 데이터 생성
    byte[] data = FileUtils.readFileToByteArray(target);
    ByteArrayResource resource = new ByteArrayResource(data);

    return ResponseEntity
      .ok()
      .contentType(MediaType.APPLICATION_OCTET_STREAM)
      .contentLength(attachmentDto.getAttachmentSize())
      .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
      .header(
        HttpHeaders.CONTENT_DISPOSITION,
        ContentDisposition
          .attachment()
          .filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
          .build()
          .toString()
      )
      .body(resource);
  }

  @PostMapping("/upload")
  public AttachmentDto upload(@RequestParam MultipartFile attach)
    throws IllegalStateException, IOException {
    if (!attach.isEmpty()) { //파일이 있을 경우
      //번호 생성
      int attachmentNo = attachmentDao.sequence();

      //파일 저장(저장 위치는 임시로 생성)
      File target = new File(dir, String.valueOf(attachmentNo)); //파일명=시퀀스
      attach.transferTo(target);

      //DB 저장
      attachmentDao.insert(
        AttachmentDto
          .builder()
          .attachmentNo(attachmentNo)
          .attachmentName(attach.getOriginalFilename())
          .attachmentType(attach.getContentType())
          .attachmentSize(attach.getSize())
          .build()
      );

      return attachmentDao.selectOne(attachmentNo); //DTO를 반환
    }

    return null; //또는 예외 발생
  }
}
