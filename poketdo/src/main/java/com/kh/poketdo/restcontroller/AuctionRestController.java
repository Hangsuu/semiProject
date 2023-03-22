package com.kh.poketdo.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public void insert(HttpSession session, @ModelAttribute AuctionBidDto auctionBidDto) {
		String memberId = (String)session.getAttribute("memberId");
		auctionBidDto.setAuctionBidMember(memberId);
		auctionBidDao.insert(auctionBidDto);
	}
	
	@GetMapping("/min/{seqNo}")
	public int getMin(@PathVariable int seqNo) {
		return auctionDao.getMinPrice(seqNo);
	}
	@GetMapping("/max/{seqNo}")
	public int getMax(@PathVariable int seqNo) {
		return auctionDao.getMaxPrice(seqNo);
	}
	@GetMapping("/min")
	public void changeMinPrice(@RequestParam int bidPrice, @RequestParam int seqNo) {
		auctionDao.changeMinPrice(bidPrice, seqNo);
	}
}