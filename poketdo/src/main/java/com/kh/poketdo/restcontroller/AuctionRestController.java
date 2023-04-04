package com.kh.poketdo.restcontroller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.AuctionBidDao;
import com.kh.poketdo.dao.AuctionBidWithNickDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dao.PointDao;
import com.kh.poketdo.dto.AuctionBidDto;
import com.kh.poketdo.dto.AuctionBidWithNickDto;
import com.kh.poketdo.vo.BookmarkVO;
import com.kh.poketdo.vo.PaginationVO;

@RestController
@RequestMapping("/rest/auction")
public class AuctionRestController {
	@Autowired
	private AuctionBidDao auctionBidDao;
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private AuctionBidWithNickDao auctionBidWithNickDao;
	@Autowired
	private PointDao pointDao;
	
	@PostMapping("/")
	public AuctionBidWithNickDto insert(@ModelAttribute AuctionBidDto auctionBidDto) {
		String memberId = auctionBidDto.getAuctionBidMember();
		String auctionWriter = auctionDao.selectOne(auctionBidDto.getAuctionBidOrigin()).getAuctionWriter();
		//마지막 입찰자의 정보
		AuctionBidWithNickDto lastDto = auctionBidWithNickDao.lastBid(auctionBidDto.getAuctionBidOrigin());
		//입찰자에게 돈 돌려줌
		if(lastDto!=null) {
			pointDao.addPoint(lastDto.getAuctionBidPrice(), lastDto.getAuctionBidMember());
		}
		
		int auctionBidNo = auctionBidDao.sequence();
		if(!memberId.equals(auctionWriter)) {
			auctionBidDto.setAuctionBidNo(auctionBidNo);
			auctionBidDao.insert(auctionBidDto);
			auctionDao.changeMinPrice(auctionBidDto.getAuctionBidPrice(), auctionBidDto.getAuctionBidOrigin());
			pointDao.subPoint(auctionBidDto.getAuctionBidPrice(), memberId);
		}
		return auctionBidWithNickDao.selectOne(auctionBidNo);
	}
	
	@GetMapping("/min/{allboardNo}")
	public AuctionBidWithNickDto getMin(@PathVariable int allboardNo) {
		return auctionBidWithNickDao.lastBid(allboardNo);
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
	@GetMapping("/finish/{allboardNo}")
	public void finish(@PathVariable int allboardNo) {
		auctionDao.changeFinish(allboardNo);
		//마지막 입찰자의 정보
		AuctionBidWithNickDto lastDto = auctionBidWithNickDao.lastBid(allboardNo);
		//작성자에게 돈 줌
		pointDao.addPoint(lastDto.getAuctionBidPrice(), auctionDao.selectOne(allboardNo).getAuctionWriter());
	}
}