package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class TypeTestDto {
	
	
	//포켓몬스터 속성 데이터
	private String monsterTypeName;
}
