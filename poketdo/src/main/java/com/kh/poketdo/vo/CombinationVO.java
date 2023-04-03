package com.kh.poketdo.vo;

import java.util.List;

import com.kh.poketdo.dto.CombinationWithNickDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CombinationVO {
	private String tagName;
	private int tagCount;
	private List<CombinationWithNickDto> list;
	private PaginationVO vo;
}
