package com.kh.poketdo.vo;

import java.util.List;

import com.kh.poketdo.dto.ReplyDto;
import com.kh.poketdo.dto.ReplyWithNickDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyVO {
	private List<ReplyWithNickDto> replyDto;
	private List<ReplyWithNickDto> replyLike;
	private List<Integer> likeCount;
	private int replyCount;
}
