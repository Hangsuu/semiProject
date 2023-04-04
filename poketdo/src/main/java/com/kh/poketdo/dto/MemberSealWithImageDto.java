package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberSealWithImageDto {

	private String memberJoinId;
	private String sealName;
	private int sealNo, mySealNo, sealPrice, sealJoinNo;
	private Integer attachmentNo;
	
	//이미지의 URL을 반환하는 메소드
			public String getImageURL() {
				if(attachmentNo==null) return "https://via.placeholder.com/96x96";
				else return "/attachment/download?attachmentNo="+ attachmentNo ;
			}
	//인장 판매 가격 조정 메소드
			public int getSellPrice() {
				double doublePrice = (double) sealPrice; // int형 변수를 double형으로 형변환합니다.
				double result = Math.ceil(doublePrice * 0.7 / 100) * 100;
				int sellPrice = (int)result;
				return sellPrice;
			}
}
