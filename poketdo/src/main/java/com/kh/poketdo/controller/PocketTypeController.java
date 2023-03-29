package com.kh.poketdo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dao.PocketmonTypeWithImageDao;
import com.kh.poketdo.dto.PocketmonTypeDto;
import com.kh.poketdo.dto.PocketmonTypeWithImageDto;
import com.kh.poketdo.service.PocketmonTypeService;

@Controller
@RequestMapping("/pockettype")
public class PocketTypeController {
	@Autowired
	private PocketmonTypeDao pocketmonTypeDao;
	@Autowired
	private PocketmonTypeService pocketmonTypeService;
	@Autowired
	private PocketmonTypeWithImageDao pocketmonTypeWithImageDao;

	//포켓몬스터 속성 정보 입력 페이지
	@GetMapping("/insert")
	public String pokcetmonTypeDataInsert() {
		return "/WEB-INF/views/pocketType/insert.jsp";
	}
	//포켓몬스터 속성 정보 입력 처리
	@PostMapping("/insertProcess")
	public String insertProcess(
			@ModelAttribute PocketmonTypeDto pocketmonTypeDto,
			@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		pocketmonTypeService.pocketmonTypeInsert(pocketmonTypeDto, attach);
		
		return "redirect:insertFinish";
	}
	//포켓몬스터 속성 정보 입력 완료 페이지
	@GetMapping("/insertFinish")
	public String pocketmonTypeDataInsertFinish() {
		return "/WEB-INF/views/pocketType/insertFinish.jsp";
	}
	
	//포켓몬스터 속성 정보 목록
	@GetMapping("/list")
	public String pocketTypeList(
			Model model
			) {
		List<PocketmonTypeWithImageDto> list = pocketmonTypeWithImageDao.selectList();
		model.addAttribute("list", list);
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
			@ModelAttribute PocketmonTypeDto pocketmonTypeDto,
			MultipartFile attach,
			@RequestParam int pocketTypeNo,
			RedirectAttributes attr
			) throws IllegalStateException, IOException {
		pocketmonTypeService.pocketmonEdit(pocketmonTypeDto, attach, pocketTypeNo, attr );
		return "redirect:detail";
	}
	
	  //포켓몬스터 속성 정보 상세
	  @GetMapping("/detail")
	  public String detail(Model model, @RequestParam int pocketTypeNo) {
		  model.addAttribute("pocketmonTypeWithImageDto", 
				  pocketmonTypeWithImageDao.selectOne(pocketTypeNo));
		  return "/WEB-INF/views/pocketType/detail.jsp";
	  }
	
	//포켓몬스터 속성 정보 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int pocketTypeNo) {
		pocketmonTypeDao.delete(pocketTypeNo);
		return "redirect:list";
	}
	
}
