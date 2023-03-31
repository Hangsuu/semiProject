package com.kh.poketdo.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RaidDto {
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
	private int raidDislike;
	private int raidRead;
	private int raidType;

	public String getTime() {
		SimpleDateFormat time = new SimpleDateFormat("M/d kk:mm");
		java.util.Date a =  new java.sql.Timestamp(raidStartTime.getTime());
		java.util.Date currentTime = new java.util.Date();
		if(a.getTime()-currentTime.getTime()<0) return "종료";
		else return time.format(a);
	}
	
	public boolean isRaidComplete() {
		java.util.Date a =  new java.sql.Timestamp(raidStartTime.getTime());
		java.util.Date currentTime = new java.util.Date();
		return a.getTime()-currentTime.getTime()<0 || raidCount==4;
	}
}