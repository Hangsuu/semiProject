package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionDto {
	private int allboardNo;
	private int auctionNo;
	private String auctionWriter;
	private String auctionTitle;
	private String auctionContent;
	private Date auctionTime;
	private Date auctionFinishTime;
	private int auctionMinPrice;
	private int auctionMaxPrice;
	private int auctionLike;
	private int auctionDislike;
	private int auctionReply;
	private int auctionRead;
	private int attachmentNo;
}
