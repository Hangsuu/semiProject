package com.kh.poketdo.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.BoardWithImageDao;
import com.kh.poketdo.dao.LikeTableDao;
import com.kh.poketdo.dto.LikeTableDto;
import com.kh.poketdo.vo.BoardLikeVO;

@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private LikeTableDao liketableDao;
	
	@Autowired
	private BoardWithImageDao boardWithImageDao; 
	
	
	@PostMapping("/")
	public BoardLikeVO like(HttpSession session,
			@ModelAttribute LikeTableDto liketableDto) {
		String memberId = (String)session.getAttribute("memberId");
		liketableDto.setMemberId(memberId);
		
		boolean current = liketableDao.check(liketableDto);
		if(current) {
			liketableDao.delete(liketableDto);
		}
		else {
			int boardNo = liketableDto.getAllboardNo();
			liketableDao.insert(LikeTableDto.builder().memberId(memberId).allboardNo(boardNo).build());
	    }
		
		//좋아요 개수
		int count = liketableDao.likeCount(liketableDto.getAllboardNo());
		
		// 게시글의 좋아요 개수를 업데이트
		boardWithImageDao.likeSet(liketableDto.getAllboardNo(), count);
		
		return BoardLikeVO.builder().result(!current).count(count).build();
	}
	
	@PostMapping("/check")
	public boolean check(HttpSession session,
			@ModelAttribute LikeTableDto liketableDto) {
		String memberId = (String)session.getAttribute("memberId");
		liketableDto.setMemberId(memberId);
		
		return liketableDao.check(liketableDto);
	}
	
	@GetMapping("/count")
	  public int likeCnt(@RequestParam int allboardNo) {
	    return liketableDao.likeCount(allboardNo);
	  }
}
