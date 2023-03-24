package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MonsterJoinTypeDto {

	//포켓몬스터 기본 정보 + 타입 연결 테이블 DTO
	
	private int monsterJoinNo;
	private int type_join_no;
	
	
}
