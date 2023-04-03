package com.kh.poketdo.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MemberWithImageDto {
	 	private String memberId;
	    private String memberPw;
	    private String memberNick;
	    private String memberEmail;
	    private String memberLevel;
	    private int memberPoint;
	    private Date memberJoin;
	    private Date memberLogin;
	    private int memberLoginCnt;
	    private Date memberDeadline;
	    private String memberBirth;
	    private int memberSealNo;
	    private Integer attachmentNo;
	    
	  //이미지의 URL을 반환하는 메소드
		public String getImageURL() {
			if(attachmentNo==null) return "https://via.placeholder.com/150x150";
			else return "/attachment/download?attachmentNo="+ attachmentNo ;
		}
}
