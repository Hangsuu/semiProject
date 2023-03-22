package com.kh.poketdo.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyDto {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Date replyTime;
	private int replyGroup;
}
