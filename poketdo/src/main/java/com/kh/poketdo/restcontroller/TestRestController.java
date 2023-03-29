package com.kh.poketdo.restcontroller;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequestMapping("/restTest")
public class TestRestController {
    
    @GetMapping("/test")
    public String test(@RequestParam int param1, @RequestParam int param2){
        System.out.println(param1);
        System.out.println(param2);
        return "안녕하새우";
    }

    @GetMapping("/test2")
    public String test2(@RequestParam("param1") List<Integer> param1){
        System.out.println(param1);
        return "안녕하새우";
    }

    @GetMapping("/test3")
    public String test3(@RequestParam("param") List<Integer> param){
        System.out.println(param);
        return "안녕하새우";
    }
}
