package com.kh.poketdo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.vo.PaginationVO;
import com.kh.poketdo.vo.SimulatorVO;

@Controller
public class HomeController {
	@Autowired
	private AuctionDao auctionDao;
	
	@GetMapping("/")
	public String home(Model model) {
		
		//------------경매--------------
		PaginationVO auctionPagination = new PaginationVO();
		auctionPagination.setSize(20);
		auctionPagination.setCount(20);
		auctionPagination.setItem("auction_finish_time");
		auctionPagination.setOrder("asc");
		auctionPagination.setSpecial("auction_finish_time>sysdate and auction_min_price<auction_max_price");
		model.addAttribute("auctionList", auctionDao.selectList(auctionPagination));
		//------------경매 끝--------------
		return "/WEB-INF/views/home.jsp";
	}
	@GetMapping("/sample")
	public String sample() {
	    return "/WEB-INF/views/sample.jsp";
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
    return "/WEB-INF/views/test.jsp";
  }

}
