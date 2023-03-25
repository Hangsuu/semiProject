package com.kh.poketdo.restcontroller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.AuctionBidDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dto.AuctionBidDto;
import com.kh.poketdo.dto.AuctionDto;
import com.kh.poketdo.vo.BookmarkVO;
import com.kh.poketdo.vo.PaginationVO;

@RestController
@RequestMapping("/rest/auction")
public class AuctionRestController {
	@Autowired
	private AuctionBidDao auctionBidDao;
	@Autowired
	private AuctionDao auctionDao;
	
	@PostMapping("/")
	public void insert(@ModelAttribute AuctionBidDto auctionBidDto) {
		String memberId = auctionBidDto.getAuctionBidMember();
		String auctionWriter = auctionDao.selectOne(auctionBidDto.getAuctionBidOrigin()).getAuctionWriter();
		if(!memberId.equals(auctionWriter)) {
			auctionBidDao.insert(auctionBidDto);
			auctionDao.changeMinPrice(auctionBidDto.getAuctionBidPrice(), auctionBidDto.getAuctionBidOrigin());
		}
	}
	
	@GetMapping("/min/{allboardNo}")
	public int getMin(@PathVariable int allboardNo) {
		return auctionDao.getMinPrice(allboardNo);
	}
	@GetMapping("/max/{allboardNo}")
	public int getMax(@PathVariable int allboardNo) {
		return auctionDao.getMaxPrice(allboardNo);
	}
	@GetMapping("/complete/{allboardNo}")
	public boolean isFinish(@PathVariable int allboardNo) {
		return auctionDao.selectOne(allboardNo).isFinish();
	}
	@PostMapping("/list")
	public BookmarkVO list(@ModelAttribute PaginationVO vo, HttpSession session){
		String memberId = (String)session.getAttribute("memberId");
		vo.setCount(auctionDao.bookmarkCount(vo, memberId));
		return BookmarkVO.builder().vo(vo).list(auctionDao.bookmarkList(vo, memberId)).build();
	}
}