package com.kh.poketdo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.poketdo.vo.SimulatorVO;

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
	
	@GetMapping("/simulator")
	public String simulator(Model model) {
		List<SimulatorVO> list = new ArrayList<SimulatorVO>();
		for(int i=0; i<10; i++) {
			SimulatorVO vo = new SimulatorVO();
			list.add(vo);
		}
		model.addAttribute("list", list);
		return "/WEB-INF/views/simulator/simulator.jsp";
	}
	
	@GetMapping("/calculator")
	public String calculator() {
		return "/WEB-INF/views/simulator/calc.jsp";
	}
}
