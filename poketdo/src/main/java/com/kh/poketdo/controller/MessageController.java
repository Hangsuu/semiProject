package com.kh.poketdo.controller;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/message")
public class MessageController {

  @Autowired
  private MessageDao messageDao;

  @GetMapping("/receive")
  public String receiveList(HttpSession session, Model model) {
    String receiverId = (String) session.getAttribute("memberId");
    List<MessageDto> lists = messageDao.selectList(receiverId);
    model.addAttribute("lists", lists);
    return "/WEB-INF/views/message/messageReceive.jsp";
  }

  @GetMapping("/write")
  public String messageWrite() {
    return "/WEB-INF/views/message/messageWrite.jsp";
  }
}
