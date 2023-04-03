package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberSealAttachmentNoDto {
    
    private String memberId;
    private String memberNick;
    private Integer attachmentNo;

    // get
    public String getSealURL(){
        if(attachmentNo==0) return "https://via.placeholder.com/150x150?text=mainImg";
		else return "/attachment/download?attachmentNo="+attachmentNo;
    }
}
