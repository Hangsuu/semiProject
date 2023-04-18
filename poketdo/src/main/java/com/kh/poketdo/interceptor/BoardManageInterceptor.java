package com.kh.poketdo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dao.BoardDao;
import com.kh.poketdo.dao.CombinationDao;
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dao.PointDao;
import com.kh.poketdo.dao.RaidDao;

@Service
public class BoardManageInterceptor implements HandlerInterceptor {
	@Autowired
	private AllboardDao allboardDao;
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private RaidDao raidDao;
	@Autowired
	private PointDao pointDao;
	@Autowired
	private CombinationDao combinationDao;
	@Autowired
	private PocketmonTradeDao pocketmonTradeDao;
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		String memberLevel = (String) session.getAttribute("memberLevel");
		//게시글 작성자 확인 코드
		String temp = (String) request.getParameter("allboardNo");
		int allboardNo = Integer.parseInt(temp);
		
		//해당 게시물의 타입 반환
		String allboardType = allboardDao.selectOne(allboardNo).getAllboardBoardType();
		
		String allboardWriter = "";
		
	    switch (allboardType) {
	      case "auction":
	        allboardWriter = auctionDao.selectOne(allboardNo).getAuctionWriter();
	        break;
	      case "raid":
		    allboardWriter = raidDao.selectOne(allboardNo).getRaidWriter();
	        break;
		  case "combination" : 
			allboardWriter = combinationDao.selectOne(allboardNo).getCombinationWriter();
	        break;
	      case "pocketmon_trade":
		    allboardWriter = pocketmonTradeDao.selectOne(allboardNo).getPocketmonTradeWriter();
	        break;
	      case "board":
		    allboardWriter = boardDao.selectOne(allboardNo).getBoardWriter();
	        break;
	    }
//		boolean pointOwner = memberId.equals(pointBoardWriter);
		boolean isOwner = memberId.equals(allboardWriter);
		boolean isAdmin = memberLevel.equals("관리자");
		//작성자 본인이라는 것은 게시글의 작성자와 현재 세션의 회원아이디가 같음
		//- 게시글 정보를 불러오려면 게시글 번호와 BoardDao가 필요
//		if(isOwner || isAdmin) return true;	//확실히 있을 수밖에 없는걸 왼쪽에 넣으면 오류 안남
//		//if(memberId != null && boardWriter != null & memberId.equals(boardWriter))
//		else {
//			response.sendError(403);
//			return false;
//		}
		if(isAdmin) {
			if(request.getRequestURI().equals("/auction/delete")
					|| request.getRequestURI().equals("/raid/delete")
					|| request.getRequestURI().equals("/combination/delete")
					|| request.getRequestURI().equals("/pocketmon_trade/delete")
					|| request.getRequestURI().equals("/board/delete")) {
				return true;
			}
		}
		if(isOwner) {
			return true;
		}
		
		response.sendError(403);
		return false;
	}
}