package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyWithNickDto {
	private int replyNo;
	private int replyOrigin;
	private String replyWriter;
	private String replyContent;
	private Date replyTime;
	private int replyGroup;
	private int replyLike;
	private String memberNick;
	private Integer attachmentNo;
	
	public long getTime() {
		return replyTime.getTime();
	};
	
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "/static/image/noimage.png";
		}
	}
}