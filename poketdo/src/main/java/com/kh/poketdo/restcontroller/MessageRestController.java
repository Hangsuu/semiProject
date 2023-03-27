package com.kh.poketdo.restcontroller;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.service.MessageService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequestMapping("/rest/message")
public class MessageRestController {

  @Autowired
  private MessageDao messageDao;

  @Autowired
  private MessageService messageService;

  // 비동기 메세지 보내기(받는사람, 보내는사람, 제목, 내용을 입력받아 새로운 Message 생성)
  @PostMapping("/write")
  public void insert(MessageDto messageDto) {
    messageService.insert(messageDto);
  }

  // 비동기 메세지 확인(받는사람 입력받아 받은 모든 메세지 출력)
  @GetMapping("/receive")
  public List<MessageDto> select(String memberId) {
    return messageDao.selectList(memberId);
  }
}
