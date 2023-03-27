package com.kh.poketdo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/message")
public class MessageController {

  @GetMapping("")
  public String receiveList(HttpSession session, Model model) {
    session.getAttribute(null)
    return "/WEB-INF/views/message/receiveList.jsp";
  }

  @GetMapping("/write")
  public String messageWrite() {
    return "/WEB-INF/views/message/messageWrite.jsp";
  }
}
