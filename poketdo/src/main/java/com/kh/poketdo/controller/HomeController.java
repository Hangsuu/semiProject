package com.kh.poketdo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

  @GetMapping("/")
  public String test() {
    return "/WEB-INF/views/home.jsp";
  }

<<<<<<< HEAD
    @GetMapping("/sample")
    public String sample() {
        return "/WEB-INF/views/sample.jsp";
    }
=======
  @GetMapping("/sample")
  public String sample() {
    return "/WEB-INF/views/sample.jsp";
  }
>>>>>>> c93375140659598808c897941c73855818835336
}
