package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RaidJoinDto {
	private int raidJoinNo;
	private int raidJoinRaid;
	private String raidJoinParticipant;
	private String raidJoinContent;
	private int raidJoinConfirm;
}