package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//포켓몬스터 기본 정보 테이블 DTO

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PocketWithTypeDto {

  private int pocketNo;
  private String pocketName;
  private int pocketBaseHp;
  private int pocketBaseAtk;
  private int pocketBaseDef;
  private int pocketBaseSpd;
  private int pocketBaseSatk;
  private int pocketBaseSdef;
  private int pocketEffortHp;
  private int pocketEffortAtk;
  private int pocketEffortDef;
  private int pocketEffortSpd;
  private int pocketEffortSatk;
  private int pocketEffortSdef;

  //포켓몬스터 속성 데이터
  private int pocketTypeNo;
  private String pocketTypeName;

  //포켓몬 속성 연결 데이터
  private int joinNo;
  private int pocketJoinNo;
  private int typeJoinNo;
}
