package com.kh.poketdo.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.SealDao;

@RestController
@RequestMapping("/rest/seal")
public class SealRestController {
	
	@Autowired
	private SealDao sealDao;

	//포켓몬스터 번호 중복검사
	@GetMapping("/sealNo/{sealNo}")
	public String findPocketNo (@PathVariable int sealNo) {
		return sealDao.selectOne(sealNo)==null?"Y":"N";
	}
	//포켓몬스터 이름 중복검사
	@GetMapping("/sealName/{sealName}")
	public String findPocketName (@PathVariable String sealName) {
		return sealDao.selectNameOne(sealName)==null?"Y":"N";
	}
	
}
