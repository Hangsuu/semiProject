package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CombinationDto {
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
}