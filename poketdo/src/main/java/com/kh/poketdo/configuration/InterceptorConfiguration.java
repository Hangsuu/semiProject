package com.kh.poketdo.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.poketdo.interceptor.AdminInterceptor;
import com.kh.poketdo.interceptor.AdminNoticeInterceptor;
import com.kh.poketdo.interceptor.BoardManageInterceptor;
import com.kh.poketdo.interceptor.MemberInterceptor;

/*
	스프링 설정파일
	-스프링의 초기 설정을 수행할 수 있는 파일
	-등록은 @Configuration으로 한다
	-나중에 프로젝트가 실행되면 application.properties와 합쳐져서 설정을 수행
	-프로젝트의 구조를 변경하는 설정이라면 특정 클래스를 상속받아서 자격까지 획득
 */
@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	@Autowired
	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private BoardManageInterceptor boardManageInterceptor;
	@Autowired
	private AdminNoticeInterceptor adminNoticeInterceptor;
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(memberInterceptor).addPathPatterns("/member/**", "/admin/**", "/board/**")
//			.excludePathPatterns("/member/join", "/board/list", "/board/detail", 
//					"/member/joinFinish", "/member/login", "/member/find", "/member/exitFinish");
//		registry.addInterceptor(adminInterceptor).addPathPatterns("/admin/**","/board/deleteAll");
//		registry.addInterceptor(boardManageInterceptor).addPathPatterns("/board/delete", "/board/edit");
//		registry.addInterceptor(adminNoticeInterceptor).addPathPatterns("/board/write", "/board/edit");
	}
}