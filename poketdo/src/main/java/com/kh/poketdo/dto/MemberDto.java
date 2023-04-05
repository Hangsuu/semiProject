package com.kh.poketdo.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
    private String memberId;
    private String memberPw;
    private String memberNick;
    private String memberBirth;
    private String memberEmail;
    private String memberLevel;
    private int memberPoint;
    private Date memberJoin;
    private Date memberLogin;
    private int memberLoginCnt;
    private int memberSealNo;
    
    
    
}

