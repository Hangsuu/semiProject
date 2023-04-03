package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberProfileDto {
	private String memberId;
	private Integer attachmentNo;
	
	  //이미지의 URL을 반환하는 메소드
    public String getImageURL() {
		if(attachmentNo == null) return "";
		else return "download?attachmentNo="+attachmentNo;
	}
}
