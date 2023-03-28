package com.kh.poketdo.vo;

import java.util.List;

import com.kh.poketdo.dto.CombinationDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CombinationVO {
	private String tagName;
	private int tagCount;
	private List<CombinationDto> list;
	private PaginationVO vo;
}
