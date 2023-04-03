package com.kh.poketdo.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.LikeTableDao;
import com.kh.poketdo.dto.LikeTableDto;

@RestController
@RequestMapping("/rest/like")
public class LikeRestController {

  @Autowired
  private LikeTableDao likeTableDao;

  @PostMapping("/")
  public boolean like(@ModelAttribute LikeTableDto likeTableDto) {
    boolean isLike = likeTableDao.insert(likeTableDto);
    likeTableDao.likeInsert(likeTableDto.getAllboardNo());
    return isLike;
  }

  @PostMapping("/check")
  public boolean check(@ModelAttribute LikeTableDto likeTableDto) {
    return likeTableDao.isLike(likeTableDto);
  }

  @GetMapping("/count")
  public int likeCnt(@RequestParam int allboardNo) {
    return likeTableDao.likeCount(allboardNo);
  }

}