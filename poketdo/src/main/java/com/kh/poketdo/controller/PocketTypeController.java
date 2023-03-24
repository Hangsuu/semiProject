package com.kh.poketdo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dto.PocketmonTypeDto;

@Controller
@RequestMapping("/pocketType")
public class PocketTypeController {
	@Autowired
	private PocketmonTypeDao pocketmonTypeDao;

	//포켓몬스터 속성 정보 입력 페이지
	@GetMapping("/insert")
	public String pokcetmonTypeDataInsert() {
		return "/WEB-INF/views/pocketType/insert.jsp";
	}
	//포켓몬스터 속성 정보 입력 처리
	@PostMapping("/insertProcess")
	public String insertProcess(
			@ModelAttribute PocketmonTypeDto pocketmonTypeDto
			) {
		pocketmonTypeDao.insert(pocketmonTypeDto);
		return "redirect:insertFinish";
	}
	//포켓몬스터 속성 정보 입력 완료 페이지
	@GetMapping("insertFinish")
	public String pocketmonTypeDataInsertFinish() {
		return "/WEB-INF/views/pocketType/insertFinish.jsp";
	}
	
	//포켓몬스터 속성 정보 목록
	@GetMapping("/list")
	public String pocketTypeList(
			Model model,
			@ModelAttribute PocketmonTypeDto pocketmonTypeDto
			) {
		model.addAttribute("list", pocketmonTypeDao.selectList());
		return "/WEB-INF/views/pocketType/list.jsp";
	}
	
	  //포켓몬스터 타입 정보 수정
	@GetMapping("/edit")  
	public String edit(
			  Model model,
			  @RequestParam int pocketTypeNo
			  ) {
		model.addAttribute("PocketmonTypeDto", pocketmonTypeDao.selectOne(pocketTypeNo));
		
		  return "/WEB-INF/views/pocketType/edit.jsp";
	  }
	@PostMapping("/editProcess")
	public String editProcess(
			@ModelAttribute PocketmonTypeDto pocketmonTypeDto
			) {
		pocketmonTypeDao.edit(pocketmonTypeDto);
		return "redirect:list";
	}
	
	//포켓몬스터 속성 정보 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int pocketTypeNo) {
		pocketmonTypeDao.delete(pocketTypeNo);
		return "redirect:list";
	}
	
}
