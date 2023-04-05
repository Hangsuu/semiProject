package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PointNameImageDto {

	String pointBoardWriter, writerName, memberNick;
	int pointBoardNo, requestPoint, pointBoardHead, attachmentNo;
	Date pointBoardTime;
	
}
