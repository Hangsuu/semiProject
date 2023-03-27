package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PocketmonTypeWithImageDto {

		private String pocketTypeName;
		private int pocketTypeNo;
		private Integer attachmentNo;
		
		//이미지의 URL을 반환하는 메소드
		public String getImageURL() {
			if(attachmentNo==null) return "https://via.placeholder.com/150x150";
			else return "download?attachmentNo="+ attachmentNo ;
		}
}
