package com.kh.poketdo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping
public class CardController {

	
	
    
    @GetMapping("/cardGenerator")
    public String cardGenerator() {
    	return "/WEB-INF/views/member/cardGenerator.jsp";
    }
}
