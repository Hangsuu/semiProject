package com.kh.poketdo.service;

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.PocketmonTradeDto;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PocketmonTradeService {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private AllboardDao allboardDao;

  public int insert(PocketmonTradeDto pocketmonTradeDto, String promise)
    throws ParseException {
    int newAllBoardSeq = allboardDao.sequence();
    pocketmonTradeDto.setAllboardNo(newAllBoardSeq);

    int newPocketmonTradeSeq = pocketmonTradeDao.sequence();
    pocketmonTradeDto.setPocketmonTradeNo(newPocketmonTradeSeq);

    // tradedto에 포켓몬교환 시간 저장
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
    Date parsedDate = dateFormat.parse(promise);
    java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
    pocketmonTradeDto.setPocketmonTradeTradeTime(sqlDate);

    System.out.println("sqlDate: " + sqlDate);

    allboardDao.insert(
      AllboardDto
        .builder()
        .allboardNo(newAllBoardSeq)
        .allboardBoardType("pocketmonTrade")
        .allboardBoardNo(newPocketmonTradeSeq)
        .build()
    );

    pocketmonTradeDao.insert(pocketmonTradeDto);
    return newPocketmonTradeSeq;
  }
}
