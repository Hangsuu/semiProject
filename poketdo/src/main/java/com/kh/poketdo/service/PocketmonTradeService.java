package com.kh.poketdo.service;

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.PocketmonTradeDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PocketmonTradeService {

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private AllboardDao allboardDao;

  public int insert(PocketmonTradeDto pocketmonTradeDto) {
    int newAllBoardSeq = allboardDao.sequence();
    pocketmonTradeDto.setAllboardNo(newAllBoardSeq);

    int newPocketmonTradeSeq = pocketmonTradeDao.sequence();
    pocketmonTradeDto.setPocketmonTradeNo(newPocketmonTradeSeq);

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
