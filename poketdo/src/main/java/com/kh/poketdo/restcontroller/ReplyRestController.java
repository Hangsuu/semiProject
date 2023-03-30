package com.kh.poketdo.restcontroller;

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

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dao.CombinationDao;
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dao.RaidDao;
import com.kh.poketdo.dao.ReplyDao;
import com.kh.poketdo.dto.ReplyDto;

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

}
