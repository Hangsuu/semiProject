package com.kh.poketdo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.PocketNameImageDao;


@CrossOrigin(origins= {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/pocketmon")
public class PocketmonRestController {


		@Autowired
		private PocketNameImageDao pocketNameImageDao;
		
		
		@GetMapping("/pocketName/{pocketName}")
		public String findId(@PathVariable String pocketName) {
			return pocketNameImageDao.selectOne(pocketName) == null ? "Y" : "N";
		}

}
