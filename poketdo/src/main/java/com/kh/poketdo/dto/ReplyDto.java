package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyDto {
	private int replyNo;
	private int replyOrigin;
	private String replyWriter;
	private String replyContent;
	private Date replyTime;
	private int replyGroup;
	private int replyLike;
	
	public long getTime() {
		return replyTime.getTime();
	};
}