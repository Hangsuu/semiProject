package com.kh.poketdo.controller;

import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.PocketmonDao;
import com.kh.poketdo.dao.PocketmonJoinTypeDao;
import com.kh.poketdo.dao.PocketmonTypeDao;
import com.kh.poketdo.dao.PocketmonTypeWithImageDao;
import com.kh.poketdo.dao.PocketmonWithImageDao;
import com.kh.poketdo.dto.PocketmonDto;
import com.kh.poketdo.dto.PocketmonJoinTypeDto;
import com.kh.poketdo.dto.PocketmonTypeDto;
import com.kh.poketdo.service.PocketmonService;
import com.kh.poketdo.vo.PocketPaginationVO;
import com.kh.poketdo.vo.PocketmonWithTypesVO;

@Controller
@RequestMapping("/pocketdex")
public class PocketmonController {

  @Autowired
  private PocketmonDao pocketmonDao;
  
  @Autowired
  private PocketmonJoinTypeDao pocketmonJoinTypeDao;
  
  @Autowired
  private PocketmonWithImageDao pocketmonWithImageDao;
 
  @Autowired
  private PocketmonTypeDao pocketmonTypeDao;
 
  @Autowired
  private PocketmonService pocketmonService;
  
  @Autowired
  private PocketmonTypeWithImageDao pocketmonTypeWithImageDao;
  
  
  
  //포켓몬스터 기본 정보 입력 페이지
  @GetMapping("/insert")
  public String pocketDataInsert(Model model) {
	List<PocketmonTypeDto> typeList = pocketmonTypeDao.selectList();
	model.addAttribute("typeList", typeList);
    return "/WEB-INF/views/pocketdex/insert.jsp";
  }

  //포켓몬스터 기본 정보 처리
  @PostMapping("/insertProcess")
  public String insertProcess(
    @ModelAttribute PocketmonDto pocketmonDto, //포켓몬스터 기본 정보
    @RequestParam int typeJoinNo, //포켓몬스터 속성 번호1
    @RequestParam int typeJoinNo2, //포켓몬스터 속성 번호2
    @RequestParam int pocketNo,
    @RequestParam MultipartFile attach
  ) throws IllegalStateException, IOException {
    //포켓몬스터 기본 정보 입력
	pocketmonService.pocketmonInsert(pocketmonDto, attach);
    //포켓몬스터 번호 추출
    int pocketJoinNo = pocketmonDto.getPocketNo();
    //포켓몬스터 속성 번호 입력
    pocketmonJoinTypeDao.insert(pocketJoinNo, typeJoinNo);
    pocketmonJoinTypeDao.insert(pocketJoinNo, typeJoinNo2);
    return "redirect:detail?pocketNo="+pocketNo;
    
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
    @ModelAttribute("vo") PocketPaginationVO vo
  ) {
	int totalCount = pocketmonWithImageDao.selectCount(vo);
	vo.setCount(totalCount);
	vo.setSize(12);
	vo.setBlockSize(10);
	List<PocketmonWithTypesVO> list3 = pocketmonService.pocketmonTypeSelect(vo);
    model.addAttribute("list3", list3);
    return "/WEB-INF/views/pocketdex/list.jsp";
  }

  //포켓몬스터 정보 수정
  @GetMapping("/edit")
  public String edit(
		  Model model,
		  @RequestParam int pocketNo
		  ) {
	  List<String> list = pocketmonService.pocketmonTypeSelectOne(pocketNo);
	  List<PocketmonTypeDto> typeList = pocketmonTypeDao.selectList();
	  if(list.size()==1) {
		  model.addAttribute("typeJoinName", list.get(0));
	  }
	  else{
		  model.addAttribute("typeJoinName", list.get(0));
		  model.addAttribute("typeJoinName2", list.get(1));
	  }
		  
	  model.addAttribute(pocketmonDao.selectOne(pocketNo));
	  model.addAttribute("typeList", typeList);
    return "/WEB-INF/views/pocketdex/edit.jsp";
  }

  	@PostMapping("/editProcess")
  	public String editProcess(
  			@ModelAttribute PocketmonDto pocketmonDto,
  			MultipartFile attach,
  		    @RequestParam int typeJoinNo, //포켓몬스터 속성 번호1
  		    @RequestParam int typeJoinNo2, //포켓몬스터 속성 번호2
			@RequestParam int pocketNo,
			RedirectAttributes attr
  			) throws IllegalStateException, IOException {
	  		pocketmonService.pocketmonEdit(pocketmonDto, attach, pocketNo, attr);
	  		List<PocketmonJoinTypeDto> list = pocketmonJoinTypeDao.selectOne(pocketNo);
  			int firstTypeNo = list.get(0).getJoinNo();
  			int secondTypeNo = list.get(1).getJoinNo();
  			pocketmonJoinTypeDao.edit(typeJoinNo, firstTypeNo);
  			pocketmonJoinTypeDao.edit(typeJoinNo2, secondTypeNo);
  			
  			return "redirect:detail?pocketNo="+pocketNo;
  	}

  //포켓몬스터 정보 상세
  @GetMapping("/detail")
  public String detail(
		  Model model, 
		  @RequestParam int pocketNo
		  ) {
	  List<PocketmonWithTypesVO> list = pocketmonService.pocketmonTypeSelect(pocketNo);
	  List<String> list2 = new ArrayList<>();
	  List<PocketmonDto> list3 = pocketmonDao.selectList();
	  for(int i=0; i<list.get(0).getPocketTypeNoes().size(); i++) {
		 list2.add(pocketmonTypeWithImageDao.selectOne(list.get(0).getPocketTypeNoes().get(i)).getImageURL());
	  }
	  model.addAttribute("pocketmonWithImageDto", pocketmonWithImageDao.selectOne(pocketNo));
	  model.addAttribute("prev", pocketmonDao.selectPrevOne(pocketNo));
	  model.addAttribute("next", pocketmonDao.selectNextOne(pocketNo));
	  model.addAttribute("list" , list);
	  model.addAttribute("list2", list2);
	  model.addAttribute("list3", list3);
    
	  return "/WEB-INF/views/pocketdex/detail.jsp";
  }
  
  	
  //포켓몬스터 정보 삭제
  @GetMapping("/delete")
  public String delete(@RequestParam int pocketNo) {
    pocketmonDao.delete(pocketNo);
    return "redirect:list";
  }
  
  //자동 입력
  @GetMapping("/auto")
  public String auto() {
	  return "/WEB-INF/views/pocketdex/autoInsert.jsp";
  }
}
