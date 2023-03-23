package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketDexDto;

@Repository
public class PocketDexDao {

	//JdbcTemplate 주입
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//조회를 위한 RowMapper 생성
	private RowMapper<PocketDexDto> mapper = new RowMapper<PocketDexDto>() {
		@Override
		public PocketDexDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketDexDto.builder()
					.monsterNo(rs.getInt("monster_no"))
					.monsterName(rs.getString("monster_name"))
//					.monsterTypeNo(rs.getInt("monster_type_no"))
//					.monsterTypeName(rs.getString("monster_type_name"))
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
	
	//포켓몬스터 정보 입력
	public void insert(PocketDexDto pocketDexDto) {
		String sql = "insert into monster ( "
				+ "monster_no, monster_name, monster_base_hp, "
				+ "monster_base_atk, monster_base_def, monster_base_spd, monster_base_satk, "
				+ "monster_base_sdef, monster_effort_hp, monster_effort_atk, monster_effort_def, "
				+ "monster_effort_spd, monster_effort_satk, monster_effort_sdef"
				+ " ) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		Object[] param = {
										pocketDexDto.getMonsterNo(), 
										pocketDexDto.getMonsterName(),
										pocketDexDto.getMonsterBaseHp(), 
										pocketDexDto.getMonsterBaseAtk(),
										pocketDexDto.getMonsterBaseDef(), 
										pocketDexDto.getMonsterBaseSpd(),
										pocketDexDto.getMonsterBaseSatk(), 
										pocketDexDto.getMonsterBaseSdef(),
										pocketDexDto.getMonsterEffortHp(), 
										pocketDexDto.getMonsterEffortAtk(),
										pocketDexDto.getMonsterEffortDef(), 
										pocketDexDto.getMonsterEffortSpd(),
										pocketDexDto.getMonsterEffortSatk(), 
										pocketDexDto.getMonsterEffortSdef()
									  };
		jdbcTemplate.update(sql, param);
	}
	
	//	포켓몬스터 목록
		public List<PocketDexDto> selectList(){
		String sql ="select * from monster order by monster_no asc";
		return jdbcTemplate.query(sql, mapper);
	}

	//	포켓몬스터 목록
	public List<PocketDexDto> selectListAddType(int monsterNo){
	String sql ="SELECT monster_type_name from monster_with_type where monster_no=?";
	Object[] param = {monsterNo};
	return jdbcTemplate.query(sql, mapper, param);
	}
	
		
	
	//포켓몬스터 데이터 수정
	public boolean edit(PocketDexDto pocketDexDto) {
		String sql = "update monster set monster_name=? "
							+ "monster_base_hp=? monster_base_atk=? "
							+ "monster_base_def=? monster_base_spd=? "
							+ "monster_base_satk=? monster_base_sdef=? "
							+ "monster_effort_hp=? monster_effort_atk=? "
							+ "monster_effort_def=? monster_effort_spd=? "
							+ "monster_effort_satk=? monster_effort_sdef=? "
							+ "where monster_no=?";
		Object[] param = {
										pocketDexDto.getMonsterName(), 
										pocketDexDto.getMonsterBaseHp(), 
										pocketDexDto.getMonsterBaseAtk(),
										pocketDexDto.getMonsterBaseDef(),
										pocketDexDto.getMonsterBaseSpd(),
										pocketDexDto.getMonsterBaseSatk(),
										pocketDexDto.getMonsterBaseSdef(),
										pocketDexDto.getMonsterEffortHp(),
										pocketDexDto.getMonsterEffortAtk(),
										pocketDexDto.getMonsterEffortDef(),
										pocketDexDto.getMonsterEffortSpd(),
										pocketDexDto.getMonsterEffortSatk(),
										pocketDexDto.getMonsterEffortSdef(),
										pocketDexDto.getMonsterNo()
										};
		return jdbcTemplate.update(sql,param)>0;
		}
	
	//포켓몬스터 데이터 삭제
	public boolean delete(int monsterNo) {
		String sql = "delete monster where monster_no=?";
		Object[] param= {monsterNo};
		return jdbcTemplate.update(sql,param)>0;
				
	}
		
		
}
