package com.kh.poketdo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.MonsterJoinTypeDao;
import com.kh.poketdo.dao.PocketDexDao;
import com.kh.poketdo.dto.PocketDexDto;

@Controller
public class PocketDexController {

	//PocketDexDao 주입
	@Autowired
	private PocketDexDao pocketDexDao;
	
	//MonsterJoinTypeDao 주입
	@Autowired
	private MonsterJoinTypeDao monsterJoinTypeDao;
	
	
	//포켓몬스터 기본 정보 입력 페이지
	@GetMapping("/pocketDataInsert")
	public String pocketDataInsert() {
		return "/WEB-INF/views/pocketdex/pocketDataInsert.jsp";
	}
	
	//포켓몬스터 기본 정보 처리
	@PostMapping("/pocketDataInsertProcess")
	public String pocketDataInsertProcess(
			@ModelAttribute PocketDexDto pocketDexDto,	//포켓몬스터 기본 정보
			@RequestParam List<Integer> typeJoinNo	//포켓몬스터 속성 번호
			) {
		//포켓몬스터 기본 정보 입력
		pocketDexDao.insert(pocketDexDto);
		//포켓몬스터 번호 추출
		int mosterJoinNo = pocketDexDto.getMonsterNo();
		//포켓몬스터 속성 번호 입력
		for(Integer no : typeJoinNo) {
			if(no != null) {
			monsterJoinTypeDao.insert(mosterJoinNo, no);
			}
		}
		return "redirect:/pocketDataInsertFinish";
	}
	
	//포켓몬스터 기본 정보 입력 완료 페이지
	@GetMapping("/pocketDataInsertFinish")
	public String pocketDataInsertFinish() {
		return "/WEB-INF/views/pocketdex/pocketDataInsertFinish.jsp";
	}
	
	//포켓몬스터 목록
	@GetMapping("/pocketDexList")
	public String pocketDexList(
			Model model,
			@ModelAttribute PocketDexDto pocketDexDto
			) {
		model.addAttribute("list", pocketDexDao.selectList());	
		return "/WEB-INF/views/pocketdex/pocketDexList.jsp";
	}
	
	//포켓몬스터 정보 수정
	
	
	//포켓몬스터 정보 삭제
	@GetMapping("/delete")
	public String delete(@RequestParam int monsterNo) {
		pocketDexDao.delete(monsterNo);
		return "redirect:pocketDexList";
	}
}
