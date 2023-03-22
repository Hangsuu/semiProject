package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MonsterJoinTypeDto;

@Repository
public class MonsterJoinTypeDao {

	//JdbcTemplate 주입
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//포켓몬스터 번호 + 속성 번호 입력
	public void insert(int mosterJoinNo , int typeJoinNo) {
		String sql = "insert into monster_join_type (monster_join_no, type_join_no) values(?, ?)";
		Object [] param = {mosterJoinNo, typeJoinNo};
		jdbcTemplate.update(sql, param);
	}
	
}
