package com.kh.poketdo.vo;

import java.util.List;

import com.kh.poketdo.dto.AuctionWithNickDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BookmarkVO {
	private PaginationVO vo;
	private List<AuctionWithNickDto> list;
}
