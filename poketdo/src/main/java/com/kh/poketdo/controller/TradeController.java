package com.kh.poketdo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.poketdo.dto.TradeDto;

@Controller
@RequestMapping("/trade")
public class TradeController {
    
    @GetMapping("")
    public String list(){
        return "/WEB-INF/views/trade/list.jsp";
    }

    @GetMapping("/write")
    public String write(){
        return "/WEB-INF/views/trade/write.jsp";
    }
    @PostMapping("/write")
    public String write(@ModelAttribute TradeDto tradeDto){
        return "redirect:";
    }
    @GetMapping("/{tradeNo}")
    public String detail(@PathVariable int tradeNo, Model model){
        return "";
    }
}
