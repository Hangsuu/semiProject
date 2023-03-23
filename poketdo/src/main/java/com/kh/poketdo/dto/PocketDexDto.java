package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//포켓몬스터 기본 정보 테이블 DTO

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class PocketDexDto {
	private int monsterNo;
	private String monsterName;
	private int monsterBaseHp;
	private int monsterBaseAtk;
	private int monsterBaseDef;
	private int monsterBaseSpd;
	private int monsterBaseSatk;
	private int monsterBaseSdef;
	private int monsterEffortHp;
	private int monsterEffortAtk;
	private int monsterEffortDef;
	private int monsterEffortSpd;
	private int monsterEffortSatk;
	private int monsterEffortSdef;
	
	//포켓몬스터 속성 데이터
	private String monsterTypeName;
}
