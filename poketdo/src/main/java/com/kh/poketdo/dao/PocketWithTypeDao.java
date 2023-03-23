package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketWithTypeDto;

@Repository
public class PocketWithTypeDao {

	//JdbcTemplate 주입
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//조회를 위한 RowMapper 생성
	private RowMapper<PocketWithTypeDto> mapper = new RowMapper<PocketWithTypeDto>() {
		@Override
		public PocketWithTypeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketWithTypeDto.builder()
					.monsterNo(rs.getInt("monster_no"))
					.monsterName(rs.getString("monster_name"))
					.monsterTypeNo(rs.getInt("monster_type_no"))
					.monsterTypeName(rs.getString("monster_type_name"))
					.monsterJoinNo(rs.getInt("monster_join_no"))
					.typeJoinNo(rs.getInt("type_join_no"))
					.monsterBaseHp(rs.getInt("monster_base_hp"))
					.monsterBaseAtk(rs.getInt("monster_base_atk"))
					.monsterBaseDef(rs.getInt("monster_base_def"))
					.monsterBaseSpd(rs.getInt("monster_base_spd"))
					.monsterBaseSatk(rs.getInt("monster_base_satk"))
					.monsterBaseSdef(rs.getInt("monster_base_sdef"))
					.monsterEffortHp(rs.getInt("monster_effort_hp"))
					.monsterEffortAtk(rs.getInt("monster_effort_atk"))
					.monsterEffortDef(rs.getInt("monster_effort_def"))
					.monsterEffortSpd(rs.getInt("monster_effort_spd"))
					.monsterEffortSatk(rs.getInt("monster_effort_satk"))
					.monsterEffortSdef(rs.getInt("monster_effort_sdef"))
					.build();
		}
	}; 
	
	private RowMapper<PocketWithTypeDto> mapper2 = new RowMapper<PocketWithTypeDto>() {
		@Override
		public PocketWithTypeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketWithTypeDto.builder()
					.monsterTypeName(rs.getString("monster_type_name"))
					.build();
		}
	}; 


	//	포켓몬스터 목록
	public List<PocketWithTypeDto> selectListAddType(int monsterNo){
	String sql ="select monster_type_name from monster_with_type where monster_no=?";
	Object[] param = {monsterNo};
	return jdbcTemplate.query(sql, mapper2, param);
	}
	
		
	
		
		
}
