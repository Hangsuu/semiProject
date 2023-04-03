package com.kh.poketdo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.poketdo.dao.MemberDao;
import com.kh.poketdo.dto.MemberDto;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	

	public void join(MemberDto memberDto){
		memberDao.insert(memberDto);
		}
	

}
