package com.kh.poketdo.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.BookmarkDao;
import com.kh.poketdo.dto.BookmarkDto;
import com.kh.poketdo.dto.LikeTableDto;

@RestController
@RequestMapping("/rest/bookmark")
public class BookmarkRestController {
	@Autowired
	private BookmarkDao bookmarkDao;
	
	@PostMapping("/")
	public boolean bookmark(@ModelAttribute BookmarkDto bookmarkDto) {
		boolean isBookmark = bookmarkDao.insert(bookmarkDto);
		return isBookmark; 
	}
	@PostMapping("/check")
	public boolean check(@ModelAttribute BookmarkDto bookmarkDto) {
		return bookmarkDao.isBookmark(bookmarkDto);
	}
}