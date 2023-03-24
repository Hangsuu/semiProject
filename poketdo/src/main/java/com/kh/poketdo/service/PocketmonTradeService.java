package com.kh.poketdo.service;

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.vo.PaginationVO;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class PocketmonTradeService {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private AllboardDao allboardDao;

  // 포켓몬교환 게시물 쓰기
  public int insert(PocketmonTradeDto pocketmonTradeDto, String promise)
    throws ParseException {
    // 통합, 포켓몬교환 sequence 생성
    int newAllBoardSeq = allboardDao.sequence();
    int newPocketmonTradeSeq = pocketmonTradeDao.sequence();

    // 포켓몬교환 dto에 pocketmonTradeNo와 allboardNo set
    pocketmonTradeDto.setAllboardNo(newAllBoardSeq);
    pocketmonTradeDto.setPocketmonTradeNo(newPocketmonTradeSeq);

    // 포켓몬교환 dto에 datetime-local로 받은 String을 java.sql.Date로 바꿔 set
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
    Date parsedDate = dateFormat.parse(promise);
    java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
    pocketmonTradeDto.setPocketmonTradeTradeTime(sqlDate);

    // 통합 테이블에 insert
    allboardDao.insert(
      AllboardDto
        .builder()
        .allboardNo(newAllBoardSeq)
        .allboardBoardType("pocketmonTrade")
        .allboardBoardNo(newPocketmonTradeSeq)
        .build()
    );

    // pocketmonTrade 테이블에 insert
    pocketmonTradeDao.insert(pocketmonTradeDto);

    // write 후 바로 detail page로 이동시키기 위해 pocketmonTradeNo 반환
    return newPocketmonTradeSeq;
  }

  // 포켓몬교환 공지글, 게시물 리스트
  public List<PocketmonTradeDto> getPocketmonTradeList(PaginationVO pageVo) {
    pageVo.setCount(pocketmonTradeDao.getCount(pageVo));
    List<PocketmonTradeDto> lists = pocketmonTradeDao.selectList(pageVo);
    return lists;
  }

  // 포켓몬 교환 게시물 업데이트
  public boolean update(PocketmonTradeDto pocketmonTradeDto, String promise)
    throws ParseException {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
    Date parsedDate = dateFormat.parse(promise);
    java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
    pocketmonTradeDto.setPocketmonTradeTradeTime(sqlDate);
    return pocketmonTradeDao.update(pocketmonTradeDto);
  }
}
