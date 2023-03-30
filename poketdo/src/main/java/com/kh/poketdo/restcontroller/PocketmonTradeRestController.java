package com.kh.poketdo.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.vo.PaginationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/pocketmonTrade")
public class PocketmonTradeRestController {

    @Autowired
    private PocketmonTradeDao pocketmonTradeDao;

    @GetMapping("/list")
    public List<PocketmonTradeDto> selectList(PaginationVO pageVo) {
        pageVo.setCount(pocketmonTradeDao.getCount(pageVo));
        return pocketmonTradeDao.selectList(pageVo);
    }
}
