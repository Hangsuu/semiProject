package com.kh.poketdo.restcontroller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.ReplyDao;
import com.kh.poketdo.dao.ReplyLikeDao;
import com.kh.poketdo.dao.ReplyWithNickDao;
import com.kh.poketdo.dto.ReplyDto;
import com.kh.poketdo.dto.ReplyLikeDto;
import com.kh.poketdo.dto.ReplyWithNickDto;
import com.kh.poketdo.vo.ReplyVO;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

  @Autowired
  private ReplyDao replyDao;
  @Autowired
  private ReplyLikeDao replyLikeDao;
  @Autowired
  private ReplyWithNickDao replyWithNickDao;
  
  @GetMapping("/{allboardNo}")
  public ReplyVO selectList(@PathVariable int allboardNo, HttpSession session) {
	  String memberId = (String)session.getAttribute("memberId");
	  List<ReplyWithNickDto> list = replyWithNickDao.selectList(allboardNo);
	  List<ReplyWithNickDto> likeList = replyWithNickDao.selectLikeList(allboardNo);
	  List<Integer> likeCount = new ArrayList<>();
	  for(ReplyWithNickDto dto: list) {
		  ReplyLikeDto replyLikeDto = new ReplyLikeDto();
		  replyLikeDto.setMemberId(memberId);
		  replyLikeDto.setReplyNo(dto.getReplyNo());
		  if(replyLikeDao.isLike(replyLikeDto)) {
			  likeCount.add(1);
		  }
		  else likeCount.add(0);
	  }
	  return ReplyVO.builder().replyDto(list).replyLike(likeList).likeCount(likeCount).build();
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
  
  @PostMapping("/like")
  public boolean like(@ModelAttribute ReplyLikeDto replyLikeDto) {
	    boolean isLike = replyLikeDao.insert(replyLikeDto);
	    replyLikeDao.likeInsert(replyLikeDto.getReplyNo());
	    return isLike;
	  }
  @GetMapping("/like/count")
  public int likeCnt(@RequestParam int replyNo) {
    return replyLikeDao.likeCount(replyNo);
  }
  // 댓글의 계층 구하기 
  @GetMapping("/level/{replyNo}")
  public int getLevel(@PathVariable int replyNo){
    return replyDao.getLevel(replyNo);
  }


}
