package com.kh.poketdo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.BoardDao;
import com.kh.poketdo.dao.DislikeBoardDao;
import com.kh.poketdo.dao.LikeBoardDao;
import com.kh.poketdo.dto.DislikeBoardDto;
import com.kh.poketdo.dto.LikeBoardDto;
import com.kh.poketdo.vo.BoardDisLikeVO;
import com.kh.poketdo.vo.BoardLikeVO;

@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private LikeBoardDao likeboardDao;
	
	@Autowired
	private DislikeBoardDao dislikeboardDao;
	
	@Autowired
	private BoardDao boardDao; 
	
	@PostMapping("/like")
	public BoardLikeVO like(HttpSession session,
			@ModelAttribute LikeBoardDto likeboardDto) {
		String memberId = (String)session.getAttribute("memberId");
		likeboardDto.setMemberId(memberId);
		
		boolean current = likeboardDao.check(likeboardDto);
		if(current) {
			likeboardDao.delete(likeboardDto);
		}
		else {
			likeboardDao.insert(likeboardDto);
		}
		
		//좋아요 개수
		int count = likeboardDao.count(likeboardDto.getAllboardNo());
		
		// 게시글의 좋아요 개수를 업데이트
		boardDao.updateLikecount(likeboardDto.getAllboardNo(), count);
		
		return BoardLikeVO.builder().result(!current).count(count).build();
	}
	
	@PostMapping("/check")
	public boolean check(HttpSession session,
			@ModelAttribute LikeBoardDto likeboardDto) {
		String memberId = (String)session.getAttribute("memberId");
		likeboardDto.setMemberId(memberId);
		
		return likeboardDao.check(likeboardDto);
	}
	
	@PostMapping("/dislike")
	public BoardDisLikeVO dislike(HttpSession session,
			@ModelAttribute DislikeBoardDto dislikeboardDto) {
		String memberId = (String)session.getAttribute("memberId");
		dislikeboardDto.setMemberId(memberId);
		
		boolean current = dislikeboardDao.check(dislikeboardDto);
		if(current) {
			dislikeboardDao.delete(dislikeboardDto);
		}
		else {
			dislikeboardDao.insert(dislikeboardDto);
		}
		
		//좋아요 개수
		int count = dislikeboardDao.count(dislikeboardDto.getAllboardNo());
		
		// 게시글의 좋아요 개수를 업데이트
		boardDao.updateLikecount(dislikeboardDto.getAllboardNo(), count);
		
		return BoardDisLikeVO.builder().result(!current).count(count).build();
	}
	
	@PostMapping("/check2")
	public boolean check2(HttpSession session,
			@ModelAttribute DislikeBoardDto dislikeboardDto) {
		String memberId = (String)session.getAttribute("memberId");
		dislikeboardDto.setMemberId(memberId);
		
		return dislikeboardDao.check(dislikeboardDto);
	}
}
