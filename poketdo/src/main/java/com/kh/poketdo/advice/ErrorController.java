package com.kh.poketdo.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice//프로젝트 전체에 대한 catch블록
public class ErrorController {
//	
//	//404 에러 익셉션
//	@ExceptionHandler(NoHandlerFoundException.class)
//	public String notFound(Exception ex) {	//model을 설정해서 쓸 수 있다
//		return "/WEB-INF/views/error/404.jsp";
//	}
//	
//	//403 에러 익셉션
//	@ExceptionHandler(RequirePermissionException.class)
//	public String forbidden(Exception ex) {
//		return "/WEB-INF/views/error/403.jsp";
//	}
//	//401번은? 우리가 만든 RequiredLoginException으로 대체하여 처리
//	//-사용자가 봐야 하는 페이지는 로그인 페이지이다
//	@ExceptionHandler(RequireLoginException.class)
//	public String unAuthorized(Exception ex) {
//		return "/WEB-INF/views/member/login.jsp";	//주소는 유지하고 화면만 변경
//	}
//	
}