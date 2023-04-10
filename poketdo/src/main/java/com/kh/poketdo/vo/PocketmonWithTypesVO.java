package com.kh.poketdo.vo;

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
public class PocketmonWithTypesVO {

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
  private List<String> pocketTypes;
  private List<Integer> pocketTypeNoes;
  private String imageURL;
}
