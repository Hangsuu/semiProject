package com.kh.poketdo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dto.MemberDto;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberDao memberDao;

    @GetMapping("/login")
    public String login() {
        return "/WEB-INF/views/member/login.jsp";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDto memberDto, HttpSession session, RedirectAttributes attr,
            @RequestParam String prevPage) {
        MemberDto selectDto = memberDao.selectOne(memberDto.getMemberId());
        if (selectDto != null && selectDto.getMemberPw().equals(memberDto.getMemberPw())) {
            session.setAttribute("memberId", selectDto.getMemberId());
            session.setAttribute("memberLevel", selectDto.getMemberLevel());
            return "redirect:" + prevPage;
        } else {
            attr.addFlashAttribute("memberId", memberDto.getMemberId());
            attr.addFlashAttribute("valid", "no");
            return "redirect:login?prevPage=" + prevPage;
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request) {
        session.removeAttribute("memberId");
        session.removeAttribute("memberLevel");
        return "redirect:" + request.getHeader("Referer");
    }
        
    @GetMapping("/join")
    public String join() {
    	return "/WEB-INF/views/member/join.jsp";
    }
    
//    @PostMapping("/join")
//    public String join(@ModelAttribute MemberDto memberDto,
//    		@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//    	memberService.join(memberDto, attach);
//    	
//    	return "redirect:joinFinish";
//    }
        
    @GetMapping("/joinFinish")
    public String joinFinish() {
    	return "/WEB-INF/views/member/joinFinish.jsp";
    }
}
