package com.kh.poketdo.vo;

import com.kh.poketdo.dto.AuctionBidWithNickDto;
import com.kh.poketdo.dto.AuctionWithNickDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AuctionVO {
	private AuctionWithNickDto auctionWithNickDto;
	private AuctionBidWithNickDto auctionBidWithNickDto;
}
