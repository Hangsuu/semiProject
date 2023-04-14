package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RaidJoinWithNickDto {
	private int raidJoinNo;
	private int raidJoinOrigin;
	private String raidJoinMember;
	private String raidJoinContent;
	private int raidJoinConfirm;
	private String memberNick;
	private Integer attachmentNo;
	
	public String getUrlLink() {
		if(attachmentNo>0) {
			return "/attachment/download?attachmentNo="+attachmentNo;
		}
		else {
			return "/static/image/noimage.png";
		}
	}
}
