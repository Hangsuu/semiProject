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
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dao.ReplyDao;
import com.kh.poketdo.dto.ReplyDto;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

  @Autowired
  private ReplyDao replyDao;

  @Autowired
  private AllboardDao allboardDao;

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @GetMapping("/{allboardNo}")
  public List<ReplyDto> selectList(@PathVariable int allboardNo) {
    return replyDao.selectList(allboardNo);
  }

  @PostMapping("/")
  public void write(@ModelAttribute ReplyDto replyDto) {
    replyDao.insert(replyDto);

    // 댓글의 원본 글 번호
    int replyOrigin = replyDto.getReplyOrigin();

    // 원본 글 번호의 좋아요 갯수
    int replyCount = replyDao.replyCount(replyOrigin);

    // 원본 글 번호의 테이블
    String table = allboardDao.selectOne(replyOrigin).getAllboardBoardType();

    switch (table) {
      case "pocketmon_trade":
        pocketmonTradeDao.replySet(replyOrigin, replyCount);
        break;
    }
  }

  @DeleteMapping("/{replyNo}")
  public void delete(@PathVariable int replyNo) {
    replyDao.delete(replyNo);

    // 댓글의 원본 글 번호
    int replyOrigin = replyDao.selectOne(replyNo).getReplyOrigin();

    // 원본 글 번호의 좋아요 갯수
    int replyCount = replyDao.replyCount(replyOrigin);

    // 원본 글 번호의 테이블
    String table = allboardDao.selectOne(replyOrigin).getAllboardBoardType();

    switch (table) {
      case "pocketmon_trade":
        pocketmonTradeDao.replySet(replyOrigin, replyCount);
        break;
    }
  }

  @PutMapping("/")
  public void edit(@ModelAttribute ReplyDto replyDto) {
    replyDao.update(replyDto);
  }

}
