package com.kh.poketdo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.poketdo.dao.BoardDao;
import com.kh.poketdo.dto.BoardDto;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	//게시글 등록 서비스 컨트롤러에게서 게시글 정보를 받은 후 컨트롤러에게 등록된 게시글 번호를 반환한다.
	public int write(BoardDto boardDto, List<Integer> attachmentNo) {
		int boardNo = boardDao.sequence();
		boardDto.setBoardNo(boardNo);
		
		//등록
		boardDao.insert(boardDto);
		
		//글에 사용된 첨부파일번호(attachmentNo)와 글 번호(boardNo)를 연결한다
		if(attachmentNo != null) {
			for(int no : attachmentNo) {
				boardDao.connect(boardNo, no);
			}
		}
		
		return boardNo;
	}
}
