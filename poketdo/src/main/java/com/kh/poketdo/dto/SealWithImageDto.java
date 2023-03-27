package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SealWithImageDto {

	private String sealName;
	private int sealNo;
	private Integer attachmentNo;
	private int sealPrice;
	
	//이미지의 URL을 반환하는 메소드
	public String getImageURL() {
		if(attachmentNo==null) return "https://via.placeholder.com/96x96";
		else return "download?attachmentNo="+ attachmentNo ;
	}
}
