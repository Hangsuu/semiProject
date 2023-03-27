package com.kh.poketdo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
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

import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dao.MemberProfileDao;
import com.kh.poketdo.dto.MemberDto;
import com.kh.poketdo.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	

    
    

    @Autowired
    private MemberDao memberDao;
    
    @Autowired
    private MemberService memberService;
    
    @Autowired
    private MemberProfileDao memberProfileDao;

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
    
    @PostMapping("/join")
    public String join(@ModelAttribute MemberDto memberDto,
    		@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
    		memberService.join(memberDto, attach);
    	
    	return "redirect:joinFinish";
    }
        
    @GetMapping("/joinFinish")
    public String joinFinish() {
    	return "/WEB-INF/views/member/joinFinish.jsp";
    }
    
    
    //마이페이지
    
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
    	String memberId = (String) session.getAttribute("memberId");
    	MemberDto memberDto = memberDao.selectOne(memberId);
    	model.addAttribute("memberDto", memberDto);
    	model.addAttribute("profile", memberProfileDao.selectOne(memberId));
    	return "/WEB-INF/views/member/mypage.jsp";
    }
    
    
   //개인정보수정 
    @GetMapping("/edit")
	public String edit(
			HttpSession session,
			Model model
			) {
		String memberId = (String)session.getAttribute("memberId");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return ("/WEB-INF/views/member/edit.jsp");
    		
    }
    			
    
    @PostMapping("/edit")
	public String edit(
			@ModelAttribute MemberDto memberDto,
			HttpSession session,
			RedirectAttributes attr
			) {
		String memberId = (String)session.getAttribute("memberId");
		MemberDto findDto = memberDao.selectOne(memberId);
		
		//비밀번호가 일치하지 않는다면 에러 표시 후 이전 페이지로 돌아감
		if(!findDto.getMemberPw().equals(memberDto.getMemberPw())) {
			attr.addAttribute("mode","error");
			return "redirect:edit";
		}
		
		//비밀번호가 일치하면 비밀번호 변경 및 완료 페이지로 리다이렉트
		memberDto.setMemberId(memberId);
		memberDao.changeInformation(memberDto);
		return "redirect:editFinish";
	}

    		
    		
    //회원 탈퇴
    
    @GetMapping("/exit")
    public String exit(HttpSession session) {
    	return ("/WEB-INF/views/member/exit.jsp");

    }
    
    @PostMapping("/exit")
    public String exit(
    		HttpSession session,
    		@RequestParam String memberPw,
    		RedirectAttributes attr
    		) {
    	String memberId = (String)session.getAttribute("memberId");
    	MemberDto memberDto = memberDao.selectOne(memberId);
    	
    	if(!memberDto.getMemberPw().equals(memberPw)) {
    		attr.addAttribute("mode","error");
    		return "redirect:exit";
    	}
    	
    	//비밀번호가 일치하면다면 -> 회원탈퇴+로그아웃
    	memberDao.delete(memberId);
    	
    	session.removeAttribute("memberId");
    	session.removeAttribute("memberLevel");
    	
    	return "redirect:exitFinish";
    }
    
    
}
