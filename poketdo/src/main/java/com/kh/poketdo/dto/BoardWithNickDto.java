package com.kh.poketdo.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardWithNickDto {
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
    private Integer boardMainImg;
    private String memberNick;
    private Integer attachmentNo;
	
	public String getImageURL() {
		if(boardMainImg == null) return "https://via.placeholder.com/150x150?text=mainImg";
		else return "/attachment/download?attachmentNo="+boardMainImg;
	}
	
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "/static/image/noimage.png";
		}
	}
}