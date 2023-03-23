package com.kh.poketdo.dto;

import java.sql.Date;

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
	private Date raidStartTime;
	private int raidParticipant;
	private int raidComplete;
	private int raidReply;
	private int raidLike;
	private int raidDislike;
	private int raidRead;
	private int raidType;
}