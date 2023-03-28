package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor 
@AllArgsConstructor 
@Builder
public class CardDto {
	private int cardNo;
	private int attachmentNo;
	private String cardNick;
	private String cardNation;
	private String cardServer;
	private int cardSlot1;
	private int cardSlot2;
	private int cardSlot3;
	private int cardSlot4;
	private int cardSlot5;
	private int cardSlot6;
	private String cardComment1;
	private String cardComment2;
	

	

}
