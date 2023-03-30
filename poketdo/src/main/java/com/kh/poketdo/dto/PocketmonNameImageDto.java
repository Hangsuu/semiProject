package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PocketmonNameImageDto {

	private int pocketNo, attachmentNo;
	private String pocketName;
}
