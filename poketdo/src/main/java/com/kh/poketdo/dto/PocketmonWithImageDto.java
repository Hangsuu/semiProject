package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PocketmonWithImageDto {

	private String pocketName;
	private int pocketNo, 
	pocketBaseHp, pocketBaseAtk, pocketBaseDef, 
	pocketBaseSpd, pocketBaseSatk, pocketBaseSdef,
	pocketEffortHp, pocketEffortAtk, pocketEffortDef,
	pocketEffortSpd, pocketEffortSatk, pocketEffortSdef;
	private Integer attachmentNo;
	
	//이미지의 URL을 반환하는 메소드
	public String getImageURL() {
		if(attachmentNo==null) return "https://via.placeholder.com/150x150";
		else return "/attachment/download?attachmentNo="+ attachmentNo ;
	}
	
}
