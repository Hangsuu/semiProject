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

import com.kh.poketdo.dao.PointDao;
import com.kh.poketdo.dao.PointNameImageDao;
import com.kh.poketdo.dto.PointDto;
import com.kh.poketdo.dto.PointNameImageDto;
import com.kh.poketdo.vo.PocketPaginationVO;

@Controller
@RequestMapping("/point")
public class PointController {

	@Autowired
	private PointDao pointDao;
	
	@Autowired
	private PointNameImageDao pointNameImageDao;
	
	
	//포인트 요청 게시판
	@GetMapping("/requestPoint")
	public String pointWrite(
			HttpSession session,
			Model model
			) {
		String memberLevel = (String) session.getAttribute("memberLevel");
		boolean admin = memberLevel != null && memberLevel.equals("관리자");
		model.addAttribute("admin", admin);
		return "/WEB-INF/views/point/requestPoint.jsp";
	}
	
	
	//포인트 요청 처리
	@PostMapping("/requestPoint")
	public String writeProcess(
			PointDto pointDto,
			HttpSession session,
			RedirectAttributes attr
			) {
		int boardNo = pointDao.sequence();
		String memberId = (String)session.getAttribute("memberId");
		pointDto.setPointBoardWriter(memberId);
		pointDto.setPointBoardNo(boardNo);
		pointDao.requestPointWrite(pointDto);
		return "redirect:list";
	}
	
	//글 목록
	@GetMapping("/list")
	public String pointRequsetList(
			Model model,
			@ModelAttribute("vo") PocketPaginationVO vo
			) {
		int totalCount = pointNameImageDao.selectCount(vo);
		vo.setCount(totalCount);
		vo.setSize(15);
		vo.setBlockSize(10);
		
		List<PointNameImageDto> list = pointNameImageDao.selectList(vo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/point/list.jsp";
	}
	
	//글 상세
	@GetMapping("/detail")
	public String pointDetail(
			Model model,
			@RequestParam int pointBoardNo,
			HttpSession session
			) {
		PointDto pointDto = pointDao.selectOne(pointBoardNo);
		String memberId = (String) session.getAttribute("memberId");
		boolean owner = pointDto.getPointBoardWriter()!=null 
				&& pointDto.getPointBoardWriter().equals(memberId);
		model.addAttribute("owner", owner);
		model.addAttribute("pointDto", pointDto);
		return "/WEB-INF/views/point/detail.jsp";
	}
	

	//글 삭제
	@GetMapping("/delete")
	public String boardDelete(@RequestParam int pointBoardNo) {
		pointDao.delete(pointBoardNo);
		return "redirect:list";
	}
	
	@PostMapping("/pointProcess")
	public String pointProcess(
			@RequestParam String pointBoardWriter,
			@RequestParam int requestPoint,
			@RequestParam int pointBoardNo
			) {
		pointDao.addPoint(requestPoint, pointBoardWriter);
		pointDao.check(pointBoardNo);
		return "redirect:list";
	}
	
	
	
	
	
	
	
	
	
}
