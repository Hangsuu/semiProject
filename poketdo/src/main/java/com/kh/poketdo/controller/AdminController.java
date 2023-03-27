package com.kh.poketdo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberStatDao;
import com.kh.poketdo.dto.MemberDto;

@Controller @RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberStatDao memberStatDao;
	
	@GetMapping("/adminCheck")
	public String adminCheck() {
	    return "/WEB-INF/views/admin/adminCheck.jsp";
	}

	@PostMapping("/adminCheck")
	public String adminCheck(
	        @RequestParam("memberPw") String memberPw,
	        RedirectAttributes attr, HttpSession session) {
	    // memberId는 세션에서 가져온다고 가정
	    String memberId = (String) session.getAttribute("memberId");
	    //단일 조회 후 비밀번호 일치 비교한다.
	    MemberDto findDto = memberDao.selectOne(memberId);

	    // 비밀번호가 일치하지 않는다면 -> 오류 처리
	    if(!memberPw.equals(findDto.getMemberPw())) {
	        attr.addAttribute("mode", "error");
	    }

	    return "redirect:/admin/memberStat";
	}
	
	@GetMapping("/memberStat")
	public String memberStat(Model model,
			@RequestParam(required = false, defaultValue = "member_level asc") String sort) {
		model.addAttribute("list", memberStatDao.selectList(sort));
		return "/WEB-INF/views/admin/memberStat.jsp";
	}
	
	@GetMapping("/member/memberManage")
	public String memberStat(Model model, 
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int size) {
		model.addAttribute("page", page);
		model.addAttribute("page", size);
		
		int totalCount = memberDao.selectCount();
		model.addAttribute("totalCount", totalCount);
		
		int totalPage = (totalCount + size - 1) / size;
		model.addAttribute("totalPage", totalPage);
		
		List<MemberDto> list = memberDao.selectListPaging(page,size);
		model.addAttribute("list", list);
		
		return "/WEB-INF/views/admin/member/memberManage.jsp";
	}

	
	
}
