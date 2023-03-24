package com.kh.poketdo.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

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
	
	public String getTime() {
		java.util.Date currentTime = new java.util.Date();
		long timeDif = auctionFinishTime.getTime() - currentTime.getTime();
		if(timeDif/1000/60/60/24>=1) {
			return timeDif/1000/60/60/24+"일";
		}
		else if(timeDif/1000/60/60>=1) {
			return timeDif/1000/60/60+"시간";
		}
		else if(timeDif>0) {
			SimpleDateFormat f = new SimpleDateFormat("mm:ss");
			return f.format(timeDif);
		}
		else {
			return "종료";
		}
	}
	
	public long getFinishTime() {
		return auctionFinishTime.getTime();
	}
	
	public boolean isFinish() {
		java.util.Date date = new java.util.Date();
		long currentTime = date.getTime();
		long finishTime = this.auctionFinishTime.getTime();
		boolean timeOver = finishTime-currentTime<=0;
		
		int minPrice = this.auctionMinPrice;
		int maxPrice = this.auctionMaxPrice;
		boolean bidComplete = maxPrice!=0 && minPrice==maxPrice;
		return timeOver||bidComplete;
	}
}
