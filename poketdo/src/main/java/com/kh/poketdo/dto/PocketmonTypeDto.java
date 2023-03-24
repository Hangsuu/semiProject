package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
// 몬스터타입Dto
public class PocketmonTypeDto {

  private int monsterTypeNo;
  private String monsterTypeName;
}
