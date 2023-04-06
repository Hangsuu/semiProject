package com.kh.poketdo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dao.MessageWithNickDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.dto.MessageWithNickDto;

@Controller
@RequestMapping("/message")
public class MessageController {

  @Autowired
  private MessageDao messageDao;

  @Autowired
  private MessageWithNickDao messageWithNickDao;

  // 받은메세지 리스트
  @GetMapping("/receive")
  public String receiveList() {
    return "/WEB-INF/views/message/messageReceive.jsp";
  }
  // 보낸메세지 리스트
  @GetMapping("/send")
  public String sendList() {
    return "/WEB-INF/views/message/messageSend.jsp";
  }
  // 메세지 쓰기
  @GetMapping("/write")
  public String messageWrite(
      @RequestParam(required = false, defaultValue = "") String recipient) {
    return "/WEB-INF/views/message/messageWrite.jsp";
  }
  // 받은메세지 상세
  @GetMapping("/receive/detail")
  public String receiveDetail(
      @RequestParam int messageNo,
      HttpSession session,
      Model model) {
    String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");
    // 처음 읽었을 때 시간 기록
    messageDao.updateReceiveTime(messageNo, memberId);

    // 받은 메세지 1개 가져오기
    MessageWithNickDto messageWithNickDto = messageWithNickDao.selectReceiveMessage(messageNo, memberId);
    model.addAttribute("messageWithNickDto", messageWithNickDto);

    return "/WEB-INF/views/message/messageReceiveDetail.jsp";
  }
  // 보낸메세지 상세
  @GetMapping("/send/detail")
  public String sendDetail(
      @RequestParam int messageNo,
      HttpSession session,
      Model model) {
        String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");

    MessageWithNickDto messageWithNickDto = messageWithNickDao.selectSendMessage(messageNo, memberId);
    model.addAttribute("messageWithNickDto", messageWithNickDto);
    return "/WEB-INF/views/message/messageSendDetail.jsp";
  }

}
