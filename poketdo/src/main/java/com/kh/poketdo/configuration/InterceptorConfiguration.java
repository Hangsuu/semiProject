package com.kh.poketdo.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.poketdo.interceptor.AdminInterceptor;
import com.kh.poketdo.interceptor.AdminNoticeInterceptor;
import com.kh.poketdo.interceptor.BoardManageInterceptor;
import com.kh.poketdo.interceptor.MemberInterceptor;
import com.kh.poketdo.interceptor.PointInterceptor;

/*
	스프링 설정파일
	-스프링의 초기 설정을 수행할 수 있는 파일
	-등록은 @Configuration으로 한다
	-나중에 프로젝트가 실행되면 application.properties와 합쳐져서 설정을 수행
	-프로젝트의 구조를 변경하는 설정이라면 특정 클래스를 상속받아서 자격까지 획득
 */
@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {
	@Autowired
	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private BoardManageInterceptor boardManageInterceptor;
	@Autowired
	private AdminNoticeInterceptor adminNoticeInterceptor;
	@Autowired
	private PointInterceptor pointInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		// 로그인 상태만 접속
		registry.addInterceptor(memberInterceptor).addPathPatterns(
				"/auction/write",
				"/auction/bookmark","/auction/bookmarkDetail",
				"/combination/write","/raid/write","/rest/like","/rest/reply",
				"/member/myseal", "/point/requestPoint", "/point/detail", "/message/**", "/pocketmonTrade/write"
				);

		//관리자만 접속
		registry.addInterceptor(adminInterceptor).addPathPatterns(
				"/admin","/pocketdex/insert","/pocketdex/edit",
				"/pockettype/insert","/pockettype/edit","/pockettype/detail","/pockettype/list",
				"/seal/insert","/seal/edit"
				);
		
		//작성자나 관리자만 접속
		registry.addInterceptor(boardManageInterceptor).addPathPatterns(
				"/auction/edit","/auction/delete","/combination/edit",
				"/combination/delete","/raid/edit","/raid/delete", "/pocketmonTrade/edit", "/pocketmonTrade/delete");
		//포인트 요청 상세 작성자나 관리자만 접속
		registry.addInterceptor(pointInterceptor).addPathPatterns(
				"/point/detail");


		// notice
		// registry.addInterceptor(adminNoticeInterceptor).addPathPatterns("/board/write",
		// "/board/edit");
	}
}