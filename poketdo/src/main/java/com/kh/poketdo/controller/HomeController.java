package com.kh.poketdo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dao.BoardWithNickDao;
import com.kh.poketdo.dao.CombinationWithNickDao;
import com.kh.poketdo.dao.PocketmonTradeMemberDao;
import com.kh.poketdo.dao.RaidWithNickDao;
import com.kh.poketdo.dto.PocketmonTradeMemberDto;
import com.kh.poketdo.vo.PaginationVO;
import com.kh.poketdo.vo.SimulatorVO;

@Controller
public class HomeController {
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private RaidWithNickDao raidWithNickDao;
	@Autowired
	private CombinationWithNickDao combinationWithNickDao;
	@Autowired
	private PocketmonTradeMemberDao pocketmonTradeMemberDao;
	@Autowired
	private BoardWithNickDao boardWithNickDao;

	@GetMapping("/")
	public String home(Model model) {
		
		//------------경매--------------
		PaginationVO auctionPagination = new PaginationVO();
		auctionPagination.setSize(20);
		auctionPagination.setCount(20);
		auctionPagination.setItem("auction_finish_time");
		auctionPagination.setOrder("asc");
		auctionPagination.setSpecial("auction_finish_time>sysdate and (auction_max_price=0 or auction_min_price<auction_max_price)");
		model.addAttribute("auctionList", auctionDao.selectList(auctionPagination));
		//------------경매 끝--------------
		//------------레이드---------------
		PaginationVO raidPagination = new PaginationVO();
		raidPagination.setSize(10);
		raidPagination.setCount(10);
		raidPagination.setItem("raid_start_time");
		raidPagination.setOrder("asc");
		raidPagination.setSpecial("raid_start_time>sysdate and raid_count<4");
		model.addAttribute("raidList", raidWithNickDao.selectList(raidPagination));
		//------------레이드 끝---------------
		//------------공략---------------
		PaginationVO combinationPagination = new PaginationVO();
		combinationPagination.setSize(10);
		combinationPagination.setCount(10);
		model.addAttribute("combinationList", combinationWithNickDao.tagSearchList(combinationPagination));
		//------------공략 끝---------------
		//------------포켓몬교환------------

		PaginationVO pocketmonTradePagination = new PaginationVO();
		pocketmonTradePagination.setSize(6);
		pocketmonTradePagination.setCount(6);
		List<PocketmonTradeMemberDto> pocketmonTradeList = pocketmonTradeMemberDao.selectHomeList(pocketmonTradePagination);
		List<Integer> attachmentNoList = new ArrayList<>();
		for(PocketmonTradeMemberDto dto : pocketmonTradeList){
			String pattern = "/rest/attachment/download/(.*)\"";
			Pattern p = Pattern.compile(pattern); // 패턴 객체 생성
			Matcher m = p.matcher(dto.getPocketmonTradeContent());
			if (m.find()) {
				String found = m.group(1); // 패턴에서 첫 번째 그룹(괄호로 묶인 부분) 추출
				int index = found.indexOf("\""); // "이" 문자열이 나오는 위치를 찾음
				if(index!=-1){
					String attachNoString = found.substring(0, index); 
					Integer attachmentNo = Integer.parseInt(attachNoString);
					attachmentNoList.add(attachmentNo);
				}
			  } else {
				attachmentNoList.add(null);
			}
		}
		model.addAttribute("pocketmonTradeList", pocketmonTradeList);
		model.addAttribute("attachmentNoList", attachmentNoList);


		//------------포켓몬교환 끝------------

		//--------------인기글 시작----------
		PaginationVO boardPagination = new PaginationVO();
		boardPagination.setSize(10);
		boardPagination.setCount(10);
		boardPagination.setItem("board_time");
		boardPagination.setOrder("desc");
		model.addAttribute("boardList", boardWithNickDao.selectHotList(boardPagination));
		//--------------인기글 끝-----------

		System.out.println("function test");
		return "/WEB-INF/views/home.jsp";
	}
	
	@GetMapping("/simulator")
	public String simulator(Model model) {
		List<SimulatorVO> list = new ArrayList<SimulatorVO>();
		for(int i=0; i<10; i++) {
			SimulatorVO vo = new SimulatorVO();
			list.add(vo);
		}
		model.addAttribute("list", list);
		return "/WEB-INF/views/simulator/simulator.jsp";
	}
	
	@GetMapping("/calculator")
	public String calculator() {
		return "/WEB-INF/views/simulator/calc.jsp";
	}

	@GetMapping("/test")
  public String test() {
    return "/WEB-INF/views/sealTest.jsp";
  }

}
