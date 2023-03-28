package com.kh.poketdo.restcontroller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.MessageDao;
import com.kh.poketdo.dto.MessageDto;
import com.kh.poketdo.service.MessageService;

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
  // @GetMapping("/receive")
  // public List<MessageDto> selectReceiveMessage(String memberId) {
  //   List<MessageDto> list = messageDao.selectReceiveMessage(memberId);
  //   for (int i = 0; i < list.size(); i++) {
  //     java.util.Date utilDate = new java.util.Date(
  //       list.get(i).getMessageSendTime().getTime()
  //     );
  //     SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. hh:mm");
  //     String formattedDate = format.format(utilDate);
  //     System.out.println(formattedDate);
  //   }
  //   return list;
  // }
  // 비동기 메세지 List와, template에 format Date를 찍기 위한 timeList
  @GetMapping("/receive")
  public Map<String, List<? extends Object>> selectReceiveMessage(String memberId) {
    List<MessageDto> list = messageDao.selectReceiveMessage(memberId);
    List<String> sendTimeList = new ArrayList<>();
    List<String> readTimeList = new ArrayList<>();
    for (int i = 0; i < list.size(); i++) {
      SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. hh:mm");
      if(list.get(i).getMessageSendTime() == null) {
        sendTimeList.add(null);
      } else {
        java.util.Date utilSendDate = new java.util.Date(
          list.get(i).getMessageSendTime().getTime()
          );
        String formattedSendDate = format.format(utilSendDate);
        sendTimeList.add(formattedSendDate);
      }
      if(list.get(i).getMessageReadTime() == null){
        readTimeList.add(null);
      } else {
        java.util.Date utilReadDate = new java.util.Date(
          list.get(i).getMessageReadTime().getTime()
        );
        String formattedReadDate = format.format(utilReadDate);
        readTimeList.add(formattedReadDate);
      }
    }
    return Map.of("list", list, "sendTimeList", sendTimeList, "readTimeList", readTimeList);
  }

  // @PutMapping("/rest/message")
  // public List<Integer> update

  @GetMapping("/send")
  public List<MessageDto> selectSendMessage(String memberId) {
    return messageDao.selectSendMessage(memberId);
  }

 
}
