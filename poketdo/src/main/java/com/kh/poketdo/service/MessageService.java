package com.kh.poketdo.service;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService {

  @Autowired
  private MessageDao messageDao;

  public void insert(MessageDto messageDto) {
    int newMessageSeq = messageDao.sequence();
    messageDto.setMessageNo(newMessageSeq);
    messageDao.insert(messageDto);
  }
}
