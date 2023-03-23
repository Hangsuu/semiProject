package com.kh.poketdo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardDto {
	private int boardNo;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private Date boardTime;
	private String boardHead;
	private int boardRead;
	private int boardLike;
	private int boardDislike;
	private int boardReply;
	
	
	//시간 반환
	public String getBoardTimeAuto() {
		java.util.Date now = new java.util.Date();
		java.util.Date write = new java.util.Date(boardTime.getTime());
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd0-HH:mm");
		
		String nowStr = f.format(now); // 형식이 반환될 현재시각
		String writeStr = f.format(write); // 형식이 변한될 작성시간
		
		if(nowStr.substring(0,10).equals(writeStr.substring(0,10))) {
			return writeStr.substring(11);// "HH:mm"
		}
		else {
			return writeStr.substring(0,10); // "yyyy-MM-dd"
		}
	}
}
