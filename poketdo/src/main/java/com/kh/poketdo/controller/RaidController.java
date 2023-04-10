package com.kh.poketdo.controller;

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

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.RaidDao;
import com.kh.poketdo.dao.RaidJoinDao;
import com.kh.poketdo.dao.RaidWithNickDao;
import com.kh.poketdo.dto.AuctionDto;
import com.kh.poketdo.dto.RaidDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/raid")
public class RaidController {
	@Autowired
	private RaidDao raidDao;
	@Autowired
	private RaidJoinDao raidJoinDao;
	@Autowired
	private AllboardDao allboardDao;
	@Autowired
	private RaidWithNickDao raidWithNickDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/raid/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute RaidDto raidDto, RedirectAttributes attr) {
		int sequence = raidDao.sequence();
		raidDto.setAllboardNo(sequence);
		raidDao.insert(raidDto);
		attr.addAttribute("page", 1);
		attr.addAttribute("allboardNo", sequence);
		return "redirect:detail";
	}
	@GetMapping("/list")
	public String list(Model model,
			@ModelAttribute("vo") PaginationVO vo) {
		vo.setCount(raidWithNickDao.selectCount(vo));
		model.addAttribute("list", raidWithNickDao.selectList(vo));
		return "/WEB-INF/views/raid/list.jsp";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam int allboardNo, Model model,
			HttpSession session) {
		RaidDto raidDto = raidDao.selectOne(allboardNo);
		String memberId = (String)session.getAttribute("memberId");
		String raidWriter = raidDto.getRaidWriter();
		boolean owner = raidWriter!=null && raidWriter.equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
			if(memory==null) memory = new HashSet<Integer>();
			if(!memory.contains(allboardNo)) {
				raidDao.readCount(allboardNo);
				memory.add(allboardNo);
			}
			session.setAttribute("memory", memory);
		}
		model.addAttribute("raidDto", raidWithNickDao.selectOne(allboardNo));
		model.addAttribute("count", raidJoinDao.count(allboardNo));
		return "/WEB-INF/views/raid/detail.jsp";
	}
	@GetMapping("/delete")
	public String delete(RedirectAttributes attr,
			@RequestParam int allboardNo, @RequestParam(defaultValue="1") int page,
			HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		String sessionLevel = (String)session.getAttribute("memberLevel");
		if(memberId.equals(raidDao.selectOne(allboardNo).getRaidWriter()) || sessionLevel.equals("관리자")) {
			allboardDao.delete(allboardNo);
			attr.addAttribute("page", page);
			return "redirect:list";
		}
		else {
			attr.addAttribute("page", page);
			attr.addAttribute("seqNo", allboardNo);
			return "redirect:detail";
		}
	}
	
	@GetMapping("/edit")
	public String edit(@ModelAttribute PaginationVO vo, @RequestParam int allboardNo, Model model) {
		model.addAttribute("vo", vo.getParameter());
		model.addAttribute("raidDto", raidWithNickDao.selectOne(allboardNo));
		return "/WEB-INF/views/raid/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute PaginationVO vo, @ModelAttribute RaidDto raidDto,
			RedirectAttributes attr) {
		raidDao.edit(raidDto);
		attr.addAttribute("allboardNo", raidDto.getAllboardNo());
		attr.addAttribute("page",vo.getPage());
		return "redirect:detail";
	}
}