package com.kh.poketdo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.PointDao;

@Controller
@RequestMapping("/member")
public class PointController {

	@Autowired
	private PointDao pointDao;
	
//	
//	//멤버 리스트
//	@GetMapping("/list")
//	public String memberList(
//			@ModelAttribute("vo") PaginationVO vo,
//			Model model,
//			@RequestParam(required = false, defaultValue = "1") int page, 
//			@RequestParam(required = false, defaultValue = "10") int size
//			) {
//		int totalCount = memberProfileDao.selectConut(vo);
//	}
	
	
	
	
	
	
	
}
