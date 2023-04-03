package com.kh.poketdo.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RaidJoinVO {
	private boolean isJoiner;
	private String raidJoinContent;
	private boolean isConfirmed;
	private String raidCode;
}
