package com.kh.poketdo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.PocketDexDao;
import com.kh.poketdo.dao.PocketWithTypeDao;
import com.kh.poketdo.dao.PocketmonJoinTypeDao;
import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dto.PocketDexDto;
import com.kh.poketdo.dto.PocketWithTypeDto;
import com.kh.poketdo.dto.PocketmonJoinTypeDto;
import com.kh.poketdo.dto.PocketmonWithTypes;

@Controller
@RequestMapping("/pocketDex")
public class PocketDexController {

  @Autowired
  private PocketDexDao pocketDexDao;
  
  @Autowired
  private PocketmonJoinTypeDao pocketmonJoinTypeDao;
  
  @Autowired
  private PocketWithTypeDao pocketWithTypeDao;
  
  @Autowired
  private PocketmonTypeDao pocketmonTypeDao;

  //포켓몬스터 기본 정보 입력 페이지
  @GetMapping("/insert")
  public String pocketDataInsert() {
    return "/WEB-INF/views/pocketdex/insert.jsp";
  }

  //포켓몬스터 기본 정보 처리
  @PostMapping("/insertProcess")
  public String insertProcess(
    @ModelAttribute PocketDexDto pocketDexDto, //포켓몬스터 기본 정보
    @RequestParam List<Integer> typeJoinNo //포켓몬스터 속성 번호
  ) {
    //포켓몬스터 기본 정보 입력
    pocketDexDao.insert(pocketDexDto);
    //포켓몬스터 번호 추출
    int pocketJoinNo = pocketDexDto.getPocketNo();
    //포켓몬스터 속성 번호 입력
    for (Integer no : typeJoinNo) {
      if (no != null) {
    	 pocketmonJoinTypeDao.insert(pocketJoinNo, no);
      }
    }
    return "redirect:insertFinish";
  }

  //포켓몬스터 기본 정보 입력 완료 페이지
  @GetMapping("/insertFinish")
  public String pocketDataInsertFinish() {
    return "/WEB-INF/views/pocketdex/insertFinish.jsp";
  }

  //포켓몬스터 목록
  @GetMapping("/list")
  public String pocketDexList(
    Model model,
    @ModelAttribute PocketDexDto pocketDexDto,
    @ModelAttribute PocketWithTypeDto pocketWithTypeDto
  ) {
    // 포켓몬들이 전부 들어있는 list
    List<PocketDexDto> list = pocketDexDao.selectList();

    // 타입이 포함된 pocketmonWithType들이 담긴 list(model에 첨부)
    List<PocketmonWithTypes> list3 = new ArrayList<>();
    for (PocketDexDto dto : list) {
      // 해당 포켓몬이 가진 속성들을 저장한 속성list (정규화)
      List<PocketmonJoinTypeDto> list2 = 
    		  pocketmonJoinTypeDao.selectOne(dto.getPocketNo());

      List<String> typeList = new ArrayList<>();
      for (PocketmonJoinTypeDto joinDto : list2) {
        typeList.add(pocketmonTypeDao.selectOneForTypeName(joinDto.getTypeJoinNo()));
      }
      System.out.println(typeList);
      // jsp파일에 보내질 list3에 PocketmonWithTypes를 build하여 추가
      list3.add(
        PocketmonWithTypes
          .builder()
          .pocketNo(dto.getPocketNo())
          .pocketName(dto.getPocketName())
          .pocketBaseHp(dto.getPocketEffortHp())
          .pocketBaseAtk(dto.getPocketBaseAtk())
          .pocketBaseDef(dto.getPocketBaseDef())
          .pocketBaseSpd(dto.getPocketBaseSpd())
          .pocketBaseSatk(dto.getPocketBaseSatk())
          .pocketEffortHp(dto.getPocketEffortHp())
          .pocketEffortAtk(dto.getPocketEffortAtk())
          .pocketEffortDef(dto.getPocketEffortDef())
          .pocketEffortSpd(dto.getPocketEffortSpd())
          .pocketEffortSatk(dto.getPocketEffortSatk())
          .pocketBaseSdef(dto.getPocketEffortSdef())
          .pocketTypes(typeList)
          .build()
      );
    }

    model.addAttribute("list3", list3);

    return "/WEB-INF/views/pocketdex/list.jsp";
  }

  //포켓몬스터 정보 수정
  @GetMapping("/edit")
  public String edit(
		  Model model,
		  @RequestParam int monsterNo,
		  @ModelAttribute PocketDexDto pocketDexDto
		  ) {
	  model.addAttribute(pocketDexDao.selectOne(monsterNo));
	  
    return "/WEB-INF/views/pocketdex/edit.jsp";
  }

  	@PostMapping("/editProcess")
  	public String editProcess(
  				Model model,
  			  @ModelAttribute PocketDexDto pocketDexDto
  			) {
  		
  		pocketDexDao.edit(pocketDexDto);
  		return "redirect:list";
  	}

  //포켓몬스터 정보 삭제
  @GetMapping("/delete")
  public String delete(@RequestParam int monsterNo) {
    pocketDexDao.delete(monsterNo);
    return "redirect:list";
  }
}
