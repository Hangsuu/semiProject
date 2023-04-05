package com.kh.poketdo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kh.poketdo.dao.MemberSealAttachmentNoDao;
import com.kh.poketdo.dao.MemberStatDao;
import com.kh.poketdo.dao.MemberWithImageDao;
import com.kh.poketdo.dto.MemberWithImageDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller @RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MemberWithImageDao memberWithImageDao;
	
	@Autowired
	private MemberStatDao memberStatDao;
	
	@Autowired
	private MemberSealAttachmentNoDao memberSealAttachmentNoDao;
	
	
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
	    MemberWithImageDto findDto = memberWithImageDao.selectOne(memberId);

	    // 비밀번호가 일치하지 않는다면 -> 오류 처리
	    if(!memberPw.equals(findDto.getMemberPw())) {
	        attr.addAttribute("mode", "error");
	    }

	    return "redirect:memberStat";
	}
	
	@GetMapping("/memberStat")
	public String memberStat(Model model,
			@RequestParam(required = false, defaultValue = "member_level asc") String sort) {
		model.addAttribute("list", memberStatDao.selectList(sort));
		return "/WEB-INF/views/admin/memberStat.jsp";
	}
	
	@GetMapping("/member/memberManage")
	public String memberManage(@ModelAttribute("vo") PaginationVO vo, Model model) {
	    int totalCount = memberWithImageDao.selectCount();
	    vo.setCount(totalCount);


	    List<MemberWithImageDto> list = memberWithImageDao.selectAll();
	    List<String> urlList = new ArrayList<>();
		for(MemberWithImageDto dto : list){
			urlList.add(memberSealAttachmentNoDao.getSealUrl(dto.getMemberId()));
		}
	    model.addAttribute("list", list);
	    model.addAttribute("urlList", urlList);

	    return "/WEB-INF/views/admin/member/memberManage.jsp";
	}



	@GetMapping("/member/memberDetail")
	public String memberDetail(Model model,
			@RequestParam String memberId) {
		model.addAttribute("memberWithImageDto", memberWithImageDao.selectOne(memberId));
		return "/WEB-INF/views/admin/member/memberDetail.jsp"; 
	}
	
	//회원 삭제
	@GetMapping("/member/memberDelete")
	public String memberDelete(@RequestParam String memberId, @RequestParam(required = false, defaultValue = "1") int page, RedirectAttributes attr) {
	    memberWithImageDao.delete(memberId);

	    attr.addAttribute("page", page);
	    return "redirect:/admin/member/memberManage?page=" + page;
	}


	
	//회원 정보 변경
	@GetMapping("/member/memberEdit")
	public String memberEdit(@RequestParam String memberId,
			Model model) {
		MemberWithImageDto memberWithImageDto = memberWithImageDao.selectOne(memberId);
		model.addAttribute("memberWithImageDto", memberWithImageDto);
		return "/WEB-INF/views/admin/member/memberEdit.jsp";
	}
	
	@PostMapping("/member/memberEdit")
	public String memberEdit(@ModelAttribute MemberWithImageDto memberWithImageDto,
			@RequestParam String memberId,
			RedirectAttributes attr) {
		//정보 변경
		memberWithImageDto.setMemberId(memberId);
		memberWithImageDao.changeInformationByAdmin(memberWithImageDto);
		attr.addAttribute("memberId", memberWithImageDto.getMemberId());
		
		return "redirect:memberDetail";
	}
	
}
