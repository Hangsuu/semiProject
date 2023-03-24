package com.kh.poketdo.vo;

import java.util.Random;

import lombok.Data;

@Data
public class SimulatorVO {
	private Random r = new Random();
	private int hp = r.nextInt(32);
	private int atk = r.nextInt(32);
	private int def = r.nextInt(32);
	private int speed = r.nextInt(32);
	private int spDef = r.nextInt(32);
	private int spAtk = r.nextInt(32);
	private int sum = hp+atk+def+speed+spDef+spAtk;
	private String evaluation = evaluationMent();
	private String hpMent = valueMent(hp);
	private String atkMent = valueMent(atk);
	private String defMent = valueMent(def);
	private String speedMent = valueMent(speed);
	private String spDefMent = valueMent(spDef);
	private String spAtkMent = valueMent(spAtk);
	
	private String evaluationMent() {
		if(sum>=151) return "훌륭한 능력을 가지고 있다";
		else if(sum>=121) return "상당히 우수한 능력을 가지고 있다";
		else if(sum>=90) return "평균 이상의 힘을 가지고 있다";
		else return "그럭저럭 힘을 가지고 있다";
	}
	
	
	private String valueMent(int num) {
		if(num==31) return "(V)";
		else if(num==30) return "(U)";
		else if(num==0) return "(Z)";
		else return "";
	}
}
