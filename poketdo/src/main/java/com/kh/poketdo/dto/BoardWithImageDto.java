package com.kh.poketdo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class BoardWithImageDto {
	private int boardNo;
	private int allboardNo;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private Date boardTime;
	private String boardHead;
	private int boardRead;
	private int boardLike;
	private int boardReply;
	
	public String getBoardTimeAuto() {
		//현재 시각을 java.sql.Date 형태로 구한다
		java.util.Date now = new java.util.Date();
		java.util.Date write = new java.util.Date(boardTime.getTime());
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		String nowStr = f.format(now);//형식이 변환된 현재시각
		String writeStr = f.format(write);//형식이 변환된 작성시각
		
		if(nowStr.substring(0, 10).equals(writeStr.substring(0, 10))) {//현재일자 == 작성일자
			return writeStr.substring(11);//"HH:mm"
		}
		else {
			return writeStr.substring(0, 10);//"yyyy-MM-dd"
		}
	}
}
