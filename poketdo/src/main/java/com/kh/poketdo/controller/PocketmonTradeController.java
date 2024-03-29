package com.kh.poketdo.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dao.PocketmonTradeMemberDao;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.dto.PocketmonTradeMemberDto;
import com.kh.poketdo.service.PocketmonTradeService;
import com.kh.poketdo.vo.PocketmonTradePageVO;

@Controller
@RequestMapping("/pocketmonTrade")
public class PocketmonTradeController {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private PocketmonTradeMemberDao pocketmonTradeMemberDao;
  
  @Autowired
  private PocketmonTradeService pocketmonTradeService;

  // 포켓몬 교환 리스트
  @GetMapping("")
  public String list(
      @ModelAttribute("pageVo") PocketmonTradePageVO pageVo, Model model) {
    List<PocketmonTradeMemberDto> pockmonTradeMemberlists = pocketmonTradeService.getPocketmonTradeList(
        pageVo);
    List<PocketmonTradeMemberDto> pocketmonTradeMemberNotices = pocketmonTradeMemberDao.selectNotice();
    model.addAttribute("trades", pockmonTradeMemberlists);
    model.addAttribute("notices", pocketmonTradeMemberNotices);
    long now = new Date().getTime();
    model.addAttribute("now", now);
    return "/WEB-INF/views/pocketmonTrade/list.jsp";
  }

  // 포켓몬 교환 쓰기
  @GetMapping("/write")
  public String write() {
    return "/WEB-INF/views/pocketmonTrade/write.jsp";
  }

  @PostMapping("/write")
  public String write(
      @ModelAttribute PocketmonTradeDto pocketmonTradeDto,
      @RequestParam(required = false, defaultValue = "") String promise) throws ParseException {
    // 통합 테이블과 포켓몬교환 테이블에 insert
    int newPocketmonTradeSeq = pocketmonTradeService.insert(
        pocketmonTradeDto,
        promise);
    // insert 후 상세페이지로 redirect
    return "redirect:" + newPocketmonTradeSeq;
  }

  // 포켓몬 교환 상세
  @GetMapping("/{pocketmonTradeNo}")
  public String detail(@PathVariable int pocketmonTradeNo, Model model, HttpSession session) {
    // 포켓몬 교환 no로 selectOne해서 model로 jsp파일에 전달
    PocketmonTradeMemberDto pocketmonTradeMemberDto = pocketmonTradeMemberDao.selectOne(
        pocketmonTradeNo);

    Set<Integer> readList = (Set<Integer>) session.getAttribute("readList") == null ? new HashSet<>()
        : (Set<Integer>) session.getAttribute("readList");
    boolean notWriter = !pocketmonTradeMemberDto.getPocketmonTradeWriter().equals((String) session.getAttribute("memberId"));
    boolean noRead = !readList.contains(pocketmonTradeNo);
    if (notWriter && noRead) {
      readList.add(pocketmonTradeNo);
      session.setAttribute("readList", readList);
      pocketmonTradeDao.readSet(pocketmonTradeNo);
      pocketmonTradeMemberDto.setPocketmonTradeRead(pocketmonTradeMemberDto.getPocketmonTradeRead() + 1);
    }

    model.addAttribute("pocketmonTradeMemberDto", pocketmonTradeMemberDto);
    return "/WEB-INF/views/pocketmonTrade/detail.jsp";
  }

  // 포켓몬 교환 수정
  @GetMapping("/{pocketmonTradeNo}/edit")
  public String edit(@PathVariable int pocketmonTradeNo, Model model) {
    PocketmonTradeDto pocketmonTradeDto = pocketmonTradeDao.selectOne(
        pocketmonTradeNo);
    if(pocketmonTradeDto.getPocketmonTradeTradeTime() != null){
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
      String formattedDate = formatter.format(
        pocketmonTradeDto.getPocketmonTradeTradeTime());
        model.addAttribute("formattedDate", formattedDate);
    }
    model.addAttribute("pocketmonTradeDto", pocketmonTradeDto);
    return "/WEB-INF/views/pocketmonTrade/edit.jsp";
  }

  @PostMapping("/{pocketmonTradeNo}/edit")
  public String edit(
      @PathVariable int pocketmonTradeNo,
      @ModelAttribute PocketmonTradeDto pocketmonTradeDto,
      @RequestParam(required = false, defaultValue = "") String promise) throws ParseException {
    pocketmonTradeService.update(pocketmonTradeDto, promise);
    return "redirect:/pocketmonTrade/" + pocketmonTradeNo;
  }

  @GetMapping("/delete/{pocketmonTradeNo}")
  public String delete(
      @PathVariable int pocketmonTradeNo,
      HttpSession session) {
    return pocketmonTradeService.delete(pocketmonTradeNo, session);
  }

}
