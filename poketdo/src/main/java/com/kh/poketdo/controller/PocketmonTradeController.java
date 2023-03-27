package com.kh.poketdo.controller;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.service.PocketmonTradeService;
import com.kh.poketdo.vo.PaginationVO;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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

@Controller
@RequestMapping("/pocketmonTrade")
public class PocketmonTradeController {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private PocketmonTradeService pocketmonTradeService;

  // 포켓몬 교환 리스트
  @GetMapping("")
  public String list(
      @ModelAttribute("pageVo") PaginationVO pageVo,
      Model model) {
    List<PocketmonTradeDto> pockmonTradelists = pocketmonTradeService.getPocketmonTradeList(
        pageVo);
    List<PocketmonTradeDto> pocketmonTradeNotices = pocketmonTradeDao.selectNotice();
    model.addAttribute("trades", pockmonTradelists);
    model.addAttribute("notices", pocketmonTradeNotices);
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
      @RequestParam String promise) throws ParseException {
    // 통합 테이블과 포켓몬교환 테이블에 insert
    int newPocketmonTradeSeq = pocketmonTradeService.insert(
        pocketmonTradeDto,
        promise);
    System.out.println(pocketmonTradeDto.getPocketmonTradeWriter());
    // insert 후 상세페이지로 redirect
    return "redirect:" + newPocketmonTradeSeq;
  }

  // 포켓몬 교환 상세
  @GetMapping("/{pocketmonTradeNo}")
  public String detail(@PathVariable int pocketmonTradeNo, Model model) {
    // 포켓몬 교환 no로 selectOne해서 model로 jsp파일에 전달
    PocketmonTradeDto pocketmonTradeDto = pocketmonTradeDao.selectOne(
        pocketmonTradeNo);
    model.addAttribute("pocketmonTradeDto", pocketmonTradeDto);
    return "/WEB-INF/views/pocketmonTrade/detail.jsp";
  }

  // 포켓몬 교환 수정
  @GetMapping("/{pocketmonTradeNo}/edit")
  public String edit(@PathVariable int pocketmonTradeNo, Model model) {
    PocketmonTradeDto pocketmonTradeDto = pocketmonTradeDao.selectOne(
        pocketmonTradeNo);
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    String formattedDate = formatter.format(
        pocketmonTradeDto.getPocketmonTradeTradeTime());
    model.addAttribute("pocketmonTradeDto", pocketmonTradeDto);
    model.addAttribute("formattedDate", formattedDate);
    return "/WEB-INF/views/pocketmonTrade/edit.jsp";
  }

  @PostMapping("/{pocketmonTradeNo}/edit")
  public String edit(
      @PathVariable int pocketmonTradeNo,
      @ModelAttribute PocketmonTradeDto pocketmonTradeDto,
      @RequestParam String promise) throws ParseException {
    pocketmonTradeService.update(pocketmonTradeDto, promise);
    return "redirect:/pocketmonTrade/" + pocketmonTradeNo;
  }

  @GetMapping("/delete/{pocketmonTradeNo}")
  public String delete(
      @PathVariable int pocketmonTradeNo,
      HttpSession session) {
    return pocketmonTradeService.delete(pocketmonTradeNo, session);
  }

  @GetMapping("/test")
  public String test() {
    return "/WEB-INF/views/pocketmonTrade/test.jsp";
  }
}
