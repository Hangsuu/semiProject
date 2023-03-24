package com.kh.poketdo.restcontroller;


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
}