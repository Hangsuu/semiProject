package com.kh.poketdo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.poketdo.advice.RequireLoginException;

@Service
public class MemberInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {	//request에 session 정보가 들어있다
		HttpSession session = request.getSession();	//HttpSession 을 수동으로 직접 불러와서 꺼내야됨
		String memberId = (String)session.getAttribute("memberId");
		if(memberId!=null) {//로그인 상태(회원이라면) : session에 있는 memberId가 null이 아닌 경우
			return true;
		}
		else {//비회원이라면 - 로그인 페이지로 이동시키면서 차단
			//리다이렉트 코드
//			response.sendRedirect("/member/login");//return "redirect:/member/login"; 역할을 하는 코드
//			response.sendError(401);
//			return false;
			throw new RequireLoginException("로그인 후 이용 가능합니다", request.getRequestURL());
		}
	}

}