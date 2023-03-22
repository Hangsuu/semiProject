package com.kh.poketdo.controller;

import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.AuctionBidDao;
import com.kh.poketdo.dao.AuctionDao;
import com.kh.poketdo.dto.AuctionBidDto;
import com.kh.poketdo.dto.AuctionDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/auction")
public class AuctionController {
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private AuctionBidDao auctionBidDao;
	
	@GetMapping("/list")
	public String list(Model model, 
			@ModelAttribute("vo") PaginationVO vo) {
		//목록의 숫자 계산 후 VO count에 입력
		vo.setCount(auctionDao.selectCount(vo));
		
		model.addAttribute("list", auctionDao.selectList(vo));
		return "/WEB-INF/views/auction/list.jsp";
	}
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/auction/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute AuctionDto dto, RedirectAttributes attr,
			@RequestParam int lastDay) {
		int seq = auctionDao.sequence();
		dto.setSeqNo(seq);
		
		java.util.Date currentTime = new java.util.Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currentTime);
		calendar.add(Calendar.DATE, lastDay);
		java.sql.Date newTime = new java.sql.Date(calendar.getTime().getTime());
		dto.setAuctionFinishTime(newTime);
		
		auctionDao.insert(dto);
		attr.addAttribute("page", "1");
		attr.addAttribute("seqNo", seq);
		return "redirect:detail";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int seqNo, Model model, HttpSession session) {
		AuctionDto auctionDto = auctionDao.selectOne(seqNo);
		String auctionWriter = auctionDto.getAuctionWriter();
		String memberId = (String) session.getAttribute("memberId");
		boolean owner = auctionWriter!=null && auctionWriter.equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
			if(memory==null) memory = new HashSet<Integer>();
			if(!memory.contains(seqNo)) {
				auctionDao.readCount(seqNo);
				memory.add(seqNo);
			}
			session.setAttribute("memory", memory);
		}
		model.addAttribute("auctionDto", auctionDao.selectOne(seqNo));
		return "/WEB-INF/views/auction/detail.jsp";
	}
	
	@PostMapping("/bid")
	public String detail(@ModelAttribute AuctionBidDto dto, RedirectAttributes attr,
			@RequestParam int seqNo) {
		AuctionDto auctionDto = auctionDao.selectOne(seqNo);
		java.util.Date currentTime = new java.util.Date();
		java.util.Date auctionDate = new java.util.Date(auctionDto.getAuctionFinishTime().getTime());
		boolean overTime = auctionDate.getTime()<=currentTime.getTime();
		boolean isTenMin = (auctionDate.getTime()-currentTime.getTime())/1000/60<=10;
		attr.addAttribute("seqNo", seqNo);
		if(!overTime && !isTenMin) {
			auctionBidDao.insert(dto);
		}
		else if(!overTime && isTenMin) {
			auctionBidDao.insert(dto);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(currentTime);
			calendar.add(Calendar.MINUTE, 10);
			java.sql.Date newTime = new java.sql.Date(calendar.getTime().getTime());
			auctionDao.changeFinishTime(newTime, seqNo);
		}

		return "redirect:detail";
	}
	@GetMapping("/delete")
	public String delete(@RequestParam int seqNo, 
			@RequestParam(required=false, defaultValue="1") int page,
			RedirectAttributes attr,
			HttpSession session) {
		String memberId = auctionDao.selectOne(seqNo).getAuctionWriter();
		String sessionId = (String)session.getAttribute("memberId");
		if(memberId.equals(sessionId)) {
			auctionDao.delete(seqNo);
			attr.addAttribute("page", page);
			return "redirect:list";
		}
		else {
			attr.addAttribute("seqNo", seqNo);
			attr.addAttribute("page", page);
			return "redirect:detail";
		}
	}
}
