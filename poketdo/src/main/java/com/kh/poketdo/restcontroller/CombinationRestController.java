package com.kh.poketdo.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.CombinationDao;
import com.kh.poketdo.dao.CombinationVODao;
import com.kh.poketdo.dto.CombinationDto;
import com.kh.poketdo.vo.CombinationVO;
import com.kh.poketdo.vo.PaginationVO;

@RestController
@RequestMapping("/rest/combination")
public class CombinationRestController {
	@Autowired
	private CombinationVODao combinationVODao;
	@Autowired
	private CombinationDao combinationDao;
	
	@GetMapping("/{tagList}")
	public List<CombinationVO> searchTag(@PathVariable String tagList){
		List<CombinationVO> list = combinationVODao.recommandTag(tagList);
		return list;
	}
	@PostMapping("/")
	public CombinationVO serchList(@ModelAttribute PaginationVO vo){
		vo.setCount(combinationDao.tagListCount(vo));
		List<CombinationDto> list = combinationDao.tagSearchList(vo);
		return CombinationVO.builder().vo(vo).list(list).build();
	}
}