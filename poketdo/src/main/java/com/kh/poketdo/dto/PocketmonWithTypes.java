package com.kh.poketdo.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
// 기존 monster정보 + 타입들(monsterTypes)
public class PocketmonWithTypes {

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
  private List<String> monsterTypes;
}
