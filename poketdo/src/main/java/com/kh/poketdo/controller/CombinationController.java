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

import com.kh.poketdo.dao.CombinationDao;
import com.kh.poketdo.dto.CombinationDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/combination")
public class CombinationController {
	@Autowired
	private CombinationDao combinationDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/combination/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute CombinationDto combinationDto, RedirectAttributes attr) {
		int sequence = combinationDao.sequence();
		combinationDto.setAllboardNo(sequence);
		combinationDao.insert(combinationDto);
		attr.addAttribute("page", 1);
		attr.addAttribute("allboardNo", sequence);
		return "redirect:detail";
	}
	@GetMapping("/list")
	public String list(Model model,
			@ModelAttribute("vo") PaginationVO vo) {
		vo.setCount(combinationDao.selectCount(vo));
		model.addAttribute("list", combinationDao.selectList(vo));
		return "/WEB-INF/views/combination/list.jsp";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam int allboardNo, Model model,
			HttpSession session) {
		CombinationDto combinationDto = combinationDao.selectOne(allboardNo);
		String memberId = (String)session.getAttribute("memberId");
		String combinationWriter = combinationDto.getCombinationWriter();
		boolean owner = combinationWriter!=null && combinationWriter.equals(memberId);
		if(!owner) {
			Set<Integer> memory = (Set<Integer>)session.getAttribute("memory");
			if(memory==null) memory = new HashSet<Integer>();
			if(!memory.contains(allboardNo)) {
				combinationDao.readCount(allboardNo);
				memory.add(allboardNo);
			}
			session.setAttribute("memory", memory);
		}
		model.addAttribute("combinationDto", combinationDao.selectOne(allboardNo));
		return "/WEB-INF/views/combination/detail.jsp";
	}
	@GetMapping("/delete")
	public String delete(RedirectAttributes attr,
			@RequestParam int allboardNo, @RequestParam(defaultValue="1") int page,
			HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		if(memberId.equals(combinationDao.selectOne(allboardNo).getCombinationWriter())) {
			combinationDao.delete(allboardNo);
			attr.addAttribute("page", page);
			return "redirect:list";
		}
		else {
			attr.addAttribute("page", page);
			attr.addAttribute("seqNo", allboardNo);
			return "redirect:detail";
		}
	}
}