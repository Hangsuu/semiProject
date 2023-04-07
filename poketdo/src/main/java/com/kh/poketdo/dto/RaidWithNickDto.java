package com.kh.poketdo.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RaidWithNickDto {
	private int allboardNo;
	private int raidNo;
	private String raidWriter;
	private String raidTitle;
	private String raidContent;
	private String raidMonster;
	private Date raidTime;
	private Timestamp raidStartTime;
	private String raidCode;
	private int raidCount;
	private int raidReply;
	private int raidLike;
	private int raidRead;
	private int raidType;
	private String memberNick;
	private Integer attachmentNo;
	

	public String getTime() {
		SimpleDateFormat time = new SimpleDateFormat("M/d kk:mm");
		java.util.Date a =  new java.sql.Timestamp(raidStartTime.getTime());
		java.util.Date currentTime = new java.util.Date();
		if(a.getTime()-currentTime.getTime()<0) return "종료";
		else return time.format(a);
	}
	public String getBoardTime() {
		java.util.Date currentTime = new java.util.Date();
		long timeDif = currentTime.getTime()-raidTime.getTime();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-M-d");
		if(timeDif/1000/60/60/24>=1) {
			return f.format(raidTime); 
		}
		else if(timeDif/1000/60/60>=1) {
			return timeDif/1000/60/60+"시간 전";
		}
		else {
			return timeDif/1000/60+"분 전";
		}
	}
	
	public boolean isRaidComplete() {
		java.util.Date a =  new java.sql.Timestamp(raidStartTime.getTime());
		java.util.Date currentTime = new java.util.Date();
		return a.getTime()-currentTime.getTime()<0 || raidCount==4;
	}
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "${pageContext.request.contextPath}/static/image/noimage.png";
		}
	}
}
