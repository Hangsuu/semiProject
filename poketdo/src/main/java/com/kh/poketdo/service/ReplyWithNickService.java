package com.kh.poketdo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.poketdo.dao.PocketmonTradeDao;
import com.kh.poketdo.dao.ReplyWithNickDao;

@Service
public class ReplyWithNickService {
    
    @Autowired
    private ReplyWithNickDao replyWithNickDao;

    @Autowired
    private PocketmonTradeDao pocketmonTradeDao;
}
