package com.kh.poketdo.restcontroller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.PocketmonDao;
import com.kh.poketdo.dao.PocketmonJoinTypeDao;
import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dao.PocketmonWithImageDao;
import com.kh.poketdo.dto.PocketmonDto;
import com.kh.poketdo.dto.PocketmonWithImageDto;

@RestController
@RequestMapping("/rest/pocketmon")
public class PocketmonRestController {

	  @Autowired
	  private PocketmonDao pocketmonDao;
	  @Autowired
	  private PocketmonJoinTypeDao pocketmonJoinTypeDao;
	  
	  @Autowired
	  private PocketmonWithImageDao pocketmonWithImageDao;
	  
	  @Autowired
	  private PocketmonTypeDao pocketmonTypeDao;
	  
	  //포켓몬스터 기본 정보 처리
	  @PostMapping("/")
	  public String insertProcess(
	    @ModelAttribute PocketmonDto pocketmonDto, //포켓몬스터 기본 정보
	    @RequestParam int typeJoinNo1,
	    @RequestParam(required=false, defaultValue="0") int typeJoinNo2//포켓몬스터 속성 번호
	  ) throws IllegalStateException, IOException {
	    //포켓몬스터 기본 정보 입력
//		pocketmonService.pocketmonInsert(pocketmonDto, attach);
	    pocketmonDao.statEdit(pocketmonDto);
	    //포켓몬스터 번호 추출
	    int pocketJoinNo = pocketmonDto.getPocketNo();
	    //포켓몬스터 속성 번호 입력
	    pocketmonJoinTypeDao.insert(pocketJoinNo, typeJoinNo1);
	    if(typeJoinNo2!=0) {
		    pocketmonJoinTypeDao.insert(pocketJoinNo, typeJoinNo2);
	    }
	    return "redirect:insertFinish";
	  }
	  
	  
	  //포켓몬스터 능력치
	  @GetMapping("/stats/{pocketmonName}")
	  public PocketmonWithImageDto selectOne(@PathVariable String pocketmonName) {
		  return pocketmonWithImageDao.selectName(pocketmonName);
	  };

	//포켓몬스터 번호 중복검사
	@GetMapping("/pocketNo/{pocketNo}")
	public String findPocketNo (@PathVariable int pocketNo) {
		return pocketmonDao.selectOne(pocketNo)==null?"Y":"N";
	}
	//포켓몬스터 이름 중복검사
	@GetMapping("/pocketName/{pocketName}")
	public String findPocketName (@PathVariable String pocketName) {
		return pocketmonDao.selectNameOne(pocketName)==null?"Y":"N";
	}
	//포켓몬스터 타입 번호 중복검사
	@GetMapping("/pocketTypeNo/{pocketTypeNo}")
	public String findPocketTypeNo (@PathVariable int pocketTypeNo) {
		return pocketmonTypeDao.selectOne(pocketTypeNo)==null?"Y":"N";
	}
	//포켓몬스터 타입 이름 중복검사
	@GetMapping("/pocketTypeName/{pocketTypeName}")
	public String findPocketTypeName (@PathVariable String pocketTypeName) {
		return pocketmonTypeDao.selectNameOne(pocketTypeName)==null?"Y":"N";
	}

}
