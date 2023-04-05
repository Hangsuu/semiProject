package com.kh.poketdo.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.vo.PocketmonTradePageVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/pocketmonTrade")
public class PocketmonTradeRestController {

    @Autowired
    private PocketmonTradeDao pocketmonTradeDao;

    @GetMapping("/list")
    public List<PocketmonTradeDto> selectList(PocketmonTradePageVO pageVo) {
        pageVo.setCount(pocketmonTradeDao.getCount(pageVo));
        return pocketmonTradeDao.selectList(pageVo);
    }
    @PutMapping("/complete")
    public void updateComplete(int allboardNo){
        pocketmonTradeDao.updateComplete(allboardNo);
    }
}
