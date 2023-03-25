package com.kh.poketdo.service;

import com.kh.poketdo.dao.ReplyDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

  @Autowired
  private ReplyDao replyDao;
}
