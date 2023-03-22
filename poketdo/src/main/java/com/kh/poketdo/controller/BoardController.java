package com.kh.poketdo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.BoardDao;
import com.kh.poketdo.dto.BoardDto;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	// 게시판 사이트 구현
	@GetMapping("/list")
	public String list(Model model) {
		List<BoardDto> list = boardDao.selectList();
		model.addAttribute("list", list);
		return "/WEB-INF/views/board/list.jsp";
	}
	
	// 인기게시판 구현(추천 30이상)
	@GetMapping("/hot")
	public String hot(Model model) {
		List<BoardDto> list = boardDao.HotselectList();
		model.addAttribute("list", list);
		return "/WEB-INF/views/board/hot.jsp";
	}

	
	// 게시글 작성 페이지 구현[GET]
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/board/write.jsp";
	}
	
	
	// 게시글 작성 페이지 구현[POST]
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto,
			@RequestParam List<Integer> attachmentNo,
			HttpSession session, RedirectAttributes attr) {
		//현재 로그인한 사용자의 memberId를 boardDto의 boardWriter에 설정
		String memberId = (String)session.getAttribute("memberId");
		boardDto.setBoardWriter(memberId);
		
		return "redirect:detail";
	}
	
	
	// 게시글 수정 페이지 구현[GET]
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		model.addAttribute("boardDto", boardDao.selectOne(boardNo));
		
		return "WEB-INF/views/board/edit.jsp";
	}
	
	
	// 게시글 수정 페이지 구현[POST]
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto,
			RedirectAttributes attr) {
		boardDao.update(boardDto);
		attr.addAttribute("boardNo", boardDto.getBoardNo());
		
		return "redirect:detail";
	}
	
	// 게시글 삭제 페이지 구현[GET]
	@GetMapping("/delete")
	public String delete(@RequestParam int boardNo) {
		boardDao.delete(boardNo);
		return "redirect:list";//상대경로
		//return "redirect:/board/list";//절대경로
	}
	
	
	// 게시글 상세 정보[GET]
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo,
			Model model, HttpSession session) {
		//사용자가 작성자인지 판정한다.
		BoardDto boardDto = boardDao.selectOne(boardNo);
		
		return "/WEB-INF/views/board/detail.jsp";
	}
}
