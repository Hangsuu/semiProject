package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionBidDto {
	private int auctionBidNo;
	private int auctionBidOrigin;
	private String auctionBidMember;
	private int auctionBidPrice;
	private Date auctionBidTime;
}
