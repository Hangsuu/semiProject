package com.kh.poketdo.controller;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/message")
public class MessageController {

  @Autowired
  private MessageDao messageDao;

  // 받은메세지 리스트
  @GetMapping("/receive")
  public String receiveList(
    @RequestParam(required = false, defaultValue = "") String mode
  ) {
    return "/WEB-INF/views/message/messageReceive.jsp";
  }

  // 보낸메세지 리스트
  @GetMapping("/send")
  public String sendList(HttpSession session, Model model) {
    String memberId = (String) session.getAttribute("memberId");
    List<MessageDto> lists = messageDao.selectSendMessage(memberId);
    model.addAttribute("lists", lists);
    return "/WEB-INF/views/message/messageSend.jsp";
  }

  // 메세지 쓰기
  @GetMapping("/write")
  public String messageWrite(
    @RequestParam(required = false, defaultValue = "") String recipient
  ) {
    return "/WEB-INF/views/message/messageWrite.jsp";
  }

  // 받은메세지 상세
  @GetMapping("/receive/detail")
  public String receiveDetail(
    @RequestParam int messageNo,
    HttpSession session,
    Model model
  ) {
    String memberId = (String) session.getAttribute("memberId");

    // 처음 읽었을 때 시간 기록
    messageDao.updateReceiveTime(messageNo, memberId);

    // 받은 메세지 1개 가져오기
    MessageDto messageDto = messageDao.selectReceiveOne(messageNo, memberId);
    model.addAttribute("messageDto", messageDto);
    return "/WEB-INF/views/message/messageReceiveDetail.jsp";
  }

  // 보낸메세지 상세
  @GetMapping("/send/detail")
  public String sendDetail(
    @RequestParam int messageNo,
    HttpSession session,
    Model model
  ) {
    String memberId = (String) session.getAttribute("memberId");
    MessageDto messageDto = messageDao.selectSendOne(messageNo, memberId);
    model.addAttribute("messageDto", messageDto);
    return "/WEB-INF/views/message/messageSendDetail.jsp";
  }

  // 받은메세지 삭제
  @GetMapping("/receive/delete")
  public String receiveDelete(
    @RequestParam int messageNo,
    HttpSession session
  ) {
    String memberId = (String) session.getAttribute("memberId");
    // 받은메세지 삭제(column값 0으로 변경)
    messageDao.deleteReceiveMessage(messageNo, memberId);
    // 보낸메세지에서도 없을 시 message table에서 삭제
    messageDao.deleteMessage(messageNo);
    return "redirect:/message/receive";
  }
}
