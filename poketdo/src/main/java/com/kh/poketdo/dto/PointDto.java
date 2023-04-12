package com.kh.poketdo.dto;


import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PointDto {

	String pointBoardWriter, writerName;
	int pointBoardNo, requestPoint, pointBoardHead;
	Date pointBoardTime;
	

// 1. 날짜가 같으면 시간과 분을 반환(HH:mm)
// 2. 날짜가 다르면 연/월/일을 반환(yyyy-MM-dd)
public String getPointTimeAuto() {
	//현재 시각을 java.sql.Date 형태로 구한다
	java.util.Date now = new java.util.Date();
	java.util.Date write = new java.util.Date(pointBoardTime.getTime());
	SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String nowStr = f.format(now); //형식이 변환된 현재시각
	String writeStr = f.format(write); 	//형식이 변환된 작성시각
	
//	if(현재날짜.equals(작성일자))
	
	if(nowStr.substring(0,10).equals(writeStr.substring(0,10))) { //현재일자 = 
		return writeStr.substring(11);	// "HH:mm"
	}
	else {
		return writeStr.substring(0,10); // "yyyy-MM-dd"
	}
	
}
}

