package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionBidWithNickDto {
	private int auctionBidNo;
	private int auctionBidOrigin;
	private String auctionBidMember;
	private int auctionBidPrice;
	private Date auctionBidTime;
	private String memberNick;
	private Integer attachmentNo;
	
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "${pageContext.request.contextPath}/static/image/noimage.png";
		}
	}
}
