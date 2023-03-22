package com.kh.poketdo.controller;

import java.util.HashSet;
import java.util.List;
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

import com.kh.poketdo.dao.RaidDao;
import com.kh.poketdo.dao.RaidJoinDao;
import com.kh.poketdo.dto.RaidDto;
import com.kh.poketdo.dto.RaidJoinDto;

@Controller
@RequestMapping("/raid")
public class RaidController {
	@Autowired
	private RaidDao raidDao;
	@Autowired
	private RaidJoinDao raidJoinDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/raid/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute RaidDto raidDto, RedirectAttributes attr) {
		int sequence = raidDao.sequence();
		raidDto.setSeqNo(sequence);
		raidDao.insert(raidDto);
		attr.addAttribute("page", 1);
		attr.addAttribute("seqNo", sequence);
		return "redirect:detail";
	}
	@GetMapping("/list")
	public String list(Model model) {
		List<RaidDto> list = raidDao.selectList();
		model.addAttribute("list", list);
		return "/WEB-INF/views/raid/list.jsp";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam int seqNo, Model model,
			HttpSession session) {
		RaidDto raidDto = raidDao.selectOne(seqNo);
		String memberId = (String)session.getAttribute("memberId");
		String raidWriter = raidDto.getRaidWriter();
		boolean owner = raidWriter!=null && raidWriter.equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
			if(memory==null) memory = new HashSet<Integer>();
			if(!memory.contains(seqNo)) {
				raidDao.readCount(seqNo);
				memory.add(seqNo);
			}
		}
		model.addAttribute("raidDto", raidDao.selectOne(seqNo));
		model.addAttribute("count", raidJoinDao.count(seqNo));
		return "/WEB-INF/views/raid/detail.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute RaidJoinDto raidJoinDto, 
			@RequestParam int seqNo, RedirectAttributes attr) {
		raidJoinDao.insert(raidJoinDto);
		attr.addAttribute("seqNo", seqNo);
		return "redirect:detail";
	}
	@GetMapping("/delete")
	public String delete(RedirectAttributes attr,
			@RequestParam int seqNo, @RequestParam(defaultValue="1") int page,
			HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		if(memberId.equals(raidDao.selectOne(seqNo).getRaidWriter())) {
			raidDao.delete(seqNo);
			attr.addAttribute("page", page);
			return "redirect:list";
		}
		else {
			attr.addAttribute("page", page);
			attr.addAttribute("seqNo", seqNo);
			return "redirect:detail";
		}
	}
}