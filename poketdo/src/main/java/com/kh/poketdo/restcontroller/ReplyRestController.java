package com.kh.poketdo.restcontroller;

import com.kh.poketdo.dao.ReplyDao;
import com.kh.poketdo.dto.ReplyDto;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

  @Autowired
  private ReplyDao replyDao;

  @GetMapping("/{allboardNo}")
  public List<ReplyDto> selectList(@PathVariable int allboardNo) {
    return replyDao.selectList(allboardNo);
  }

  @PostMapping("/")
  public void write(@ModelAttribute ReplyDto replyDto) {
    replyDao.insert(replyDto);
  }

  @DeleteMapping("/{replyNo}")
  public void delete(@PathVariable int replyNo) {
    replyDao.delete(replyNo);
  }

  @PutMapping("/")
  public void edit(@ModelAttribute ReplyDto replyDto) {
    replyDao.update(replyDto);
  }

  @PostMapping("/test")
  public String test(@ModelAttribute ReplyDto replyDto) {
    System.out.println(replyDto);
    return "통신 성공";
  }
}
