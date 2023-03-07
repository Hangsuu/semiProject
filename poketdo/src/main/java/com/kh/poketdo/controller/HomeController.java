package com.kh.poketdo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home() {
        return "/WEB-INF/views/home.jsp";
    }

    @GetMapping("/sample")
    public String sample() {
        return "/WEB-INF/views/sample.jsp";
    }
}
