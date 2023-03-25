package com.kh.poketdo.restcontroller;

import com.kh.poketdo.dao.LikeTableDao;
import com.kh.poketdo.dto.LikeTableDto;
import com.kh.poketdo.dto.TestDto;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/like")
public class LikeRestController {

  @Autowired
  private LikeTableDao likeTableDao;

  @PostMapping("/")
  public boolean like(@ModelAttribute LikeTableDto likeTableDto) {
    boolean isLike = likeTableDao.insert(likeTableDto);
    int likeCnt = likeTableDao.likeInsert(likeTableDto.getAllboardNo());
    return isLike;
  }

  @PostMapping("/check")
  public boolean check(@ModelAttribute LikeTableDto likeTableDto) {
    return likeTableDao.isLike(likeTableDto);
  }

  @PostMapping("/count")
  public Map<String, Object> likeCnt(
    @ModelAttribute LikeTableDto likeTableDto
  ) {
    boolean isLike = likeTableDao.insert(likeTableDto);
    int likeCnt = likeTableDao.likeInsert(likeTableDto.getAllboardNo());
    return Map.of("isLike", isLike, "likeCnt", likeCnt);
  }
}
