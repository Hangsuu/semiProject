package com.kh.poketdo.controller;

import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.MemberJoinSealDao;
import com.kh.poketdo.dao.PointDao;
import com.kh.poketdo.dao.SealDao;
import com.kh.poketdo.dao.SealWithImageDao;
import com.kh.poketdo.dto.SealDto;
import com.kh.poketdo.dto.SealWithImageDto;
import com.kh.poketdo.service.SealService;

@Controller
@RequestMapping("/seal")
public class SealController {
	@Autowired 
	private SealDao sealDao;
	@Autowired
	private SealService sealService;
	@Autowired
	private SealWithImageDao sealWithImageDao;
	@Autowired
	private PointDao pointDao;
	@Autowired
	private MemberJoinSealDao memberJoinSealDao;
	
	
	//인장 정보 입력 페이지
	@GetMapping("/insert")
	public String sealDataInsert() {
		return "/WEB-INF/views/seal/insert.jsp";
	}
	
	//인장 정보 입력 처리 
	@PostMapping("/insertProcess")
	public String insertProcess(
			@ModelAttribute SealDto sealDto,
			@RequestParam MultipartFile attach
			) throws IllegalStateException, IOException {
		sealService.sealInsert(sealDto, attach);
		return "redirect:insertFinish";
	}
	
	//인장 정보 입력 완료 페이지
	@GetMapping("/insertFinish")
	public String sealDataInsertFinish() {
		return "/WEB-INF/views/seal/insertFinish.jsp";
	}
	
	//인장 정보 목록
	@GetMapping("/list")
	public String sealList(Model model) {
		List<SealWithImageDto> list = sealWithImageDao.selectList();
		model.addAttribute("list" , list);
		return "/WEB-INF/views/seal/list.jsp";
	}
	
	//인장 정보 수정페이지
	@GetMapping("/edit")
	public String edit(
			Model model,
			@RequestParam int sealNo
			) {
		model.addAttribute("sealDto", sealDao.selectOne(sealNo));
		return "/WEB-INF/views/seal/edit.jsp";
	}
	
	//인장 정보 수정 처리
	@PostMapping("/editProcess")
	public String editProcess(
			@ModelAttribute SealDto sealDto,
			MultipartFile attach,
			@RequestParam int sealNo,
			RedirectAttributes attr
			) throws IllegalStateException, IOException {
		sealService.sealEdit(sealDto, attach, sealNo, attr);
		return "redirect:detail";
	}
	
  //인장 정보 상세
  @GetMapping("/detail")
  public String detail(Model model, @RequestParam int sealNo) {
	  model.addAttribute("sealWithImageDto", 
		  sealWithImageDao.selectOne(sealNo));
  return "/WEB-INF/views/seal/detail.jsp";
  }
	
	//인장 정보 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int sealNo) {
		sealDao.delete(sealNo);
		return "redirect:list";
	}
	
	//인장 구매 처리
	@PostMapping("/purchase")
	public String purchase(
			@RequestParam int point,
			@RequestParam int sealNo,
			HttpSession session
			) {
		String memberId = (String) session.getAttribute("memberId");
		pointDao.subPoint(point, memberId);
		memberJoinSealDao.insert(memberId, sealNo);
		
		return "redirect:list";
	}
	
	
}
