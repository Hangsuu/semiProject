package com.kh.poketdo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/test")
public class TestController {
    
    @GetMapping("")
    public String test(){
        return "/WEB-INF/views/test.jsp";
    }
}
