package com.kh.poketdo.controller;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.service.PocketmonTradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/trade")
public class TradeController {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private PocketmonTradeService pocketmonTradeService;

  @GetMapping("")
  public String list() {
    return "/WEB-INF/views/trade/list.jsp";
  }

  @GetMapping("/write")
  public String write() {
    return "/WEB-INF/views/trade/write.jsp";
  }

  @PostMapping("/write")
  public String write(@ModelAttribute PocketmonTradeDto pocketmonTradeDto) {
    int newAllBoardSeq = pocketmonTradeService.insert(pocketmonTradeDto);
    return "redirect:" + newAllBoardSeq;
  }

  @GetMapping("/{pocketmonTradeNo}")
  public String detail(@PathVariable int pocketmonTradeNo, Model model) {
    PocketmonTradeDto pocketmonTradeDto = pocketmonTradeDao.selectOne(
      pocketmonTradeNo
    );
    model.addAttribute("pocketmonTradeDto", pocketmonTradeDto);
    return "/WEB-INF/views/trade/detail.jsp";
  }
}
