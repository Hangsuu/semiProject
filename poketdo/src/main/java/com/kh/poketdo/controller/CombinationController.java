package com.kh.poketdo.controller;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
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
import com.kh.poketdo.dao.CombinationDao;
import com.kh.poketdo.dao.CombinationWithNickDao;
import com.kh.poketdo.dao.TagDao;
import com.kh.poketdo.dto.CombinationDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/combination")
public class CombinationController {
	@Autowired
	private CombinationDao combinationDao;
	@Autowired
	private TagDao tagDao;
	@Autowired
	private AllboardDao allboardDao;
	@Autowired
	private CombinationWithNickDao combinationWithNickDao;
	
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/combination/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute CombinationDto combinationDto, RedirectAttributes attr, 
			HttpServletRequest request) {
		int sequence = combinationDao.sequence();
		combinationDto.setAllboardNo(sequence);
		combinationDao.insert(combinationDto);
		
		//tagList 문자열을 배열로 반환
		String value = request.getParameter("tagList");
		if(value.length()>0) {
			String[] values = value.split(",");
		//입력받은 태그를 db에 입력
			tagDao.insertTags(sequence, values);
		}
		attr.addAttribute("page", 1);
		attr.addAttribute("allboardNo", sequence);
		return "redirect:detail";
	}
	@GetMapping("/list")
	public String list(Model model,
			@ModelAttribute("vo") PaginationVO vo) {
//		if(vo.getColumn().equals("tag")) {
//			vo.setCount(combinationDao.tagListCount(vo));
//			model.addAttribute("list", combinationDao.tagSearchList(vo));
//			return "/WEB-INF/views/combination/list.jsp";
//		}
//		else {
//			vo.setCount(combinationDao.selectCount(vo));
//			model.addAttribute("list", combinationDao.selectList(vo));
//		}
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
		model.addAttribute("combinationDto", combinationWithNickDao.selectOne(allboardNo));
		model.addAttribute("tagDto", tagDao.selectList(allboardNo));
		return "/WEB-INF/views/combination/detail.jsp";
	}
	@GetMapping("/delete")
	public String delete(RedirectAttributes attr,
			@RequestParam int allboardNo, @RequestParam(defaultValue="1") int page,
			HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		if(memberId.equals(combinationDao.selectOne(allboardNo).getCombinationWriter())) {
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
	
//	@GetMapping("/simulator")
//	public String simulator() {
//		return "/WEB-INF/views/combination/simulator.jsp";
//	}
}