package com.kh.poketdo.restcontroller;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.service.MessageService;
import java.text.SimpleDateFormat;
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

  // 비동기 메세지 확인(받는사람 입력, 받은 모든 메세지 출력)
  @GetMapping("/receive")
  public List<MessageDto> selectReceiveMessage(String memberId) {
    List<MessageDto> list = messageDao.selectReceiveMessage(memberId);
    for (int i = 0; i < list.size(); i++) {
      java.util.Date utilDate = new java.util.Date(
        list.get(i).getMessageSendTime().getTime()
      );
      SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. hh:mm");
      String formattedDate = format.format(utilDate);
      System.out.println(formattedDate);
    }
    return list;
  }

  @GetMapping("/send")
  public List<MessageDto> selectSendMessage(String memberId) {
    return messageDao.selectSendMessage(memberId);
  }
}
