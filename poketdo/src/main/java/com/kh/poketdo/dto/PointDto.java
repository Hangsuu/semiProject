package com.kh.poketdo.dto;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PointDto {

	String pointBoardWriter, writerName;
	int pointBoardNo, requestPoint, pointBoardHead;
	Date pointBoardTime;
	
	
}
