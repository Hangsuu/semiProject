package com.kh.poketdo.restcontroller;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dao.MessageWithNickDao;
import com.kh.poketdo.dao.ReplyDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.dto.MessageWithNickDto;
import com.kh.poketdo.dto.ReplyDto;
import com.kh.poketdo.service.MessageService;
import com.kh.poketdo.vo.PaginationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/message")
public class MessageRestController {

  @Autowired
  private MessageDao messageDao;

  @Autowired
  private MessageService messageService;

  @Autowired
  private MessageWithNickDao messageWithNickDao;
  // [테스트]
  @Autowired
  private ReplyDao replyDao;

  // 비동기 메세지 보내기(받는사람, 보내는사람, 제목, 내용을 입력받아 새로운 Message 생성)
  @PostMapping("/write")
  public void insert(MessageDto messageDto) {
    messageService.insert(messageDto);
  }

  // S 받은메세지 + 보낸시간List
  @GetMapping("/receive")
  public Map<String, List<? extends Object>> selectReceiveMessageTest(PaginationVO pageVo, HttpSession session) {
    // 멤버아이디 추출
    String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");
    if (memberId == null)
      return null;

    // 페이지네이션 count 세팅
    pageVo.setCount(messageWithNickDao.getReceiveCount(pageVo, memberId));
    List<MessageWithNickDto> list = messageWithNickDao.selectReceiveMessage(pageVo, memberId);
    List<String> sendTimeList = new ArrayList<>();
    List<Object> pageVoList = new ArrayList<>();

    // 보낸 시간 리스트
    for (int i = 0; i < list.size(); i++) {
      SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. HH:mm");
      if (list.get(i).getMessageSendTime() == null) {
        sendTimeList.add(null);
      } else {
        java.util.Date utilSendDate = new java.util.Date(
            list.get(i).getMessageSendTime().getTime());
        String formattedSendDate = format.format(utilSendDate);
        sendTimeList.add(formattedSendDate);
      }
    }

    // 페이지 Vo 리스트
    pageVoList.add(pageVo);

    return Map.of("list", list, "sendTimeList", sendTimeList, "pageVoList", pageVoList);
  }

  // S 보낸메세지 + 보낸, 받은시간List
  @GetMapping("/send")
  public Map<String, List<? extends Object>> selectSendMessage(String memberId) {
    List<MessageDto> list = messageDao.selectSendMessage(memberId);
    List<String> sendTimeList = new ArrayList<>();
    List<String> readTimeList = new ArrayList<>();
    for (int i = 0; i < list.size(); i++) {
      SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. hh:mm");
      if (list.get(i).getMessageSendTime() == null) {
        sendTimeList.add(null);
      } else {
        java.util.Date utilSendDate = new java.util.Date(
            list.get(i).getMessageSendTime().getTime());
        String formattedSendDate = format.format(utilSendDate);
        sendTimeList.add(formattedSendDate);
      }
      if (list.get(i).getMessageReadTime() == null) {
        readTimeList.add(null);
      } else {
        java.util.Date utilReadDate = new java.util.Date(
            list.get(i).getMessageReadTime().getTime());
        String formattedReadDate = format.format(utilReadDate);
        readTimeList.add(formattedReadDate);
      }
    }
    return Map.of("list", list, "sendTimeList", sendTimeList, "readTimeList", readTimeList);
  }

  // [GET] 안 읽은 메세지 개수
  @GetMapping("/receive/notReadCount")
  public int selectNotReadReceiveCnt(@RequestParam String memberId) {
    return messageDao.countNotRead(memberId);
  }

  // 받은 메세지 1개 삭제
  @PutMapping("/receive")
  public void deleteReceive(@RequestParam int messageNo, HttpSession session) {
    String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");
    messageDao.deleteReceiveMessage(messageNo, memberId);
    messageDao.deleteMessage(messageNo);
  }

  // 보낸 메세지 1개 삭제
  @PutMapping("/send")
  public void deleteSend(@RequestParam int messageNo, HttpSession session) {
    String memberId = session.getAttribute("memberId") == null ? null : (String) session.getAttribute("memberId");
    messageDao.deleteSendMessage(messageNo, memberId);
    messageDao.deleteMessage(messageNo);
  }

  // [Delete] 메세지 삭제
  @DeleteMapping("/{messageNo}")
  public boolean deleteMessage(@PathVariable int messageNo, HttpSession session) {
    String memberId = (String) session.getAttribute("memberId") == null ? null
        : (String) session.getAttribute("memberId");
    return messageDao.deleteSendCancle(messageNo, memberId);
  }

  // [테스트]
  @GetMapping("/test")
  public ReplyDto test(@RequestParam int replyNo) {
    return replyDao.selectOne(replyNo);
  }
}
