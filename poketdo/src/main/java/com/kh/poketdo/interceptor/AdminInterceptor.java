package com.kh.poketdo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.poketdo.advice.RequirePermissionException;

@Service
public class AdminInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberLevel = (String)session.getAttribute("memberLevel");
		
		//(주의) 없는 경우(null)를 반드시 먼저 검사해야 한다
		if(memberLevel==null || !(memberLevel.equals("관리자"))) {
//			response.sendError(403);
			//403 : HttpStatus.FORBIDDEN.value()  상수 제공
//			return false;
			throw new RequirePermissionException("권한이 없습니다.");
		}
		else {
			return true;
		}
	}
}