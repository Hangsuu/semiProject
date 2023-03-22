package com.kh.poketdo.dto;

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
	private int boardGroup;
}
