package com.kh.poketdo.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CombinationWithNickDto {
	private int allboardNo;
	private String combinationWriter;
	private int combinationNo;
	private String combinationTitle;
	private String combinationType;
	private String combinationContent;
	private Date combinationTime;
	private int combinationLike;
	private int combinationReply;
	private int combinationRead;
	private String memberNick;
	private Integer attachmentNo;
	
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "/static/image/noimage.png";
		}
	}
	public String getBoardTime() {
		java.util.Date currentTime = new java.util.Date();
		long timeDif = currentTime.getTime()-combinationTime.getTime();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-M-d");
		if(timeDif/1000/60/60/24>=1) {
			return f.format(combinationTime); 
		}
		else if(timeDif/1000/60/60>=1) {
			return timeDif/1000/60/60+"시간 전";
		}
		else {
			return timeDif/1000/60+"분 전";
		}
	}
}