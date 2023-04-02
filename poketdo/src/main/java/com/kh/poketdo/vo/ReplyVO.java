package com.kh.poketdo.vo;

import java.util.List;

import com.kh.poketdo.dto.ReplyDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyVO {
	private List<ReplyDto> replyDto;
	private List<ReplyDto> replyLike;
	private List<Integer> likeCount;
}
