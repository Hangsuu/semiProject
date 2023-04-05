package com.kh.poketdo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.poketdo.advice.RequirePermissionException;
import com.kh.poketdo.dao.PointDao;

@Service
public class PointInterceptor implements HandlerInterceptor{
	
	@Autowired
	private PointDao pointDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		String memberLevel = (String)session.getAttribute("memberLevel");
		
				
			
			//(주의) 없는 경우(null)를 반드시 먼저 검사해야 한다
		
		
			if(memberLevel==null || !(memberLevel.equals("관리자"))) {
				throw new RequirePermissionException("관리자만 이용 가능합니다");
			}

			
				
				String memberId = (String) session.getAttribute("memberId");
				String pointTemp = (String) request.getParameter("pointBoardNo");
				int pointboardNo = Integer.parseInt(pointTemp);
				String pointBoardWriter = pointDao.selectOne(pointboardNo).getPointBoardWriter();
				boolean pointOwner = memberId.equals(pointBoardWriter);
				if(pointOwner) {
					throw new RequirePermissionException("관리자만 이용 가능합니다");
					
				}else {
					return true;
				}
		}
		
		
	
}