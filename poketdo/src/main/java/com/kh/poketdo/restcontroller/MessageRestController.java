package com.kh.poketdo.restcontroller;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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

  @PostMapping("/write")
  public void insert(MessageDto messageDto) {
    System.out.println(messageDto);
    messageService.insert(messageDto);
    // messageDao.insert(messageDto);
  }
}
