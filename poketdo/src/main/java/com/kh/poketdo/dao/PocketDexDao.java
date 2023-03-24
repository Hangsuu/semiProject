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
					.pocketNo(rs.getInt("pocket_no"))
					.pocketName(rs.getString("pocket_name"))
					.pocketBaseHp(rs.getInt("pocket_base_hp"))
					.pocketBaseAtk(rs.getInt("pocket_base_atk"))
					.pocketBaseDef(rs.getInt("pocket_base_def"))
					.pocketBaseSpd(rs.getInt("pocket_base_spd"))
					.pocketBaseSatk(rs.getInt("pocket_base_satk"))
					.pocketBaseSdef(rs.getInt("pocket_base_sdef"))
					.pocketEffortHp(rs.getInt("pocket_effort_hp"))
					.pocketEffortAtk(rs.getInt("pocket_effort_atk"))
					.pocketEffortDef(rs.getInt("pocket_effort_def"))
					.pocketEffortSpd(rs.getInt("pocket_effort_spd"))
					.pocketEffortSatk(rs.getInt("pocket_effort_satk"))
					.pocketEffortSdef(rs.getInt("pocket_effort_sdef"))
					.build();
		}
	}; 
	
	//포켓몬스터 정보 입력
	public void insert(PocketDexDto pocketDexDto) {
		String sql = "insert into pocketmon ( "
				+ "pocket_no, pocket_name, pocket_base_hp, "
				+ "pocket_base_atk, pocket_base_def, pocket_base_spd, pocket_base_satk, "
				+ "pocket_base_sdef, pocket_effort_hp, pocket_effort_atk, pocket_effort_def, "
				+ "pocket_effort_spd, pocket_effort_satk, pocket_effort_sdef"
				+ " ) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		Object[] param = {
										pocketDexDto.getPocketNo(), 
										pocketDexDto.getPocketName(),
										pocketDexDto.getPocketBaseHp(), 
										pocketDexDto.getPocketBaseAtk(),
										pocketDexDto.getPocketBaseDef(), 
										pocketDexDto.getPocketBaseSpd(),
										pocketDexDto.getPocketBaseSatk(), 
										pocketDexDto.getPocketBaseSdef(),
										pocketDexDto.getPocketEffortHp(), 
										pocketDexDto.getPocketEffortAtk(),
										pocketDexDto.getPocketEffortDef(), 
										pocketDexDto.getPocketEffortSpd(),
										pocketDexDto.getPocketEffortSatk(), 
										pocketDexDto.getPocketEffortSdef()
									  };
		jdbcTemplate.update(sql, param);
	}
	
	//	포켓몬스터 목록
		public List<PocketDexDto> selectList(){
		String sql ="select * from pocketmon order by pocket_no asc";
		return jdbcTemplate.query(sql, mapper);
	}

	//	포켓몬스터 타입 이름 검색
	public List<PocketDexDto> selectListAddType(int pocketNo){
	String sql ="select pocket_type_name from pocketmon_with_type where pocket_no=?";
	Object[] param = {pocketNo};
	return jdbcTemplate.query(sql, mapper, param);
	}
	
	
	//포켓몬스터 정보 수정
	public boolean edit(PocketDexDto pocketDexDto) {
		String sql = "update pocketmon set pocket_name=?, "
							+ "pocket_base_hp=?, pocket_base_atk=?, "
							+ "pocket_base_def=?, pocket_base_spd=?, "
							+ "pocket_base_satk=?, pocket_base_sdef=?, "
							+ "pocket_effort_hp=?, pocket_effort_atk=?, "
							+ "pocket_effort_def=?, pocket_effort_spd=?, "
							+ "pocket_effort_satk=?, pocket_effort_sdef=? "
							+ "where pocket_no=?";
		Object[] param = {
										pocketDexDto.getPocketName(), 
										pocketDexDto.getPocketBaseHp(), 
										pocketDexDto.getPocketBaseAtk(),
										pocketDexDto.getPocketBaseDef(),
										pocketDexDto.getPocketBaseSpd(),
										pocketDexDto.getPocketBaseSatk(),
										pocketDexDto.getPocketBaseSdef(),
										pocketDexDto.getPocketEffortHp(),
										pocketDexDto.getPocketEffortAtk(),
										pocketDexDto.getPocketEffortDef(),
										pocketDexDto.getPocketEffortSpd(),
										pocketDexDto.getPocketEffortSatk(),
										pocketDexDto.getPocketEffortSdef(),
										pocketDexDto.getPocketNo()
										};
		return jdbcTemplate.update(sql,param)>0;
		}
	
	//포켓몬스터 정보 상세조회
	public PocketDexDto selectOne(int pocketNo) {
		String sql = "select * from pocketmon where pocket_no=? ";
		Object [] param = {pocketNo};
		List<PocketDexDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//포켓몬스터 정보 삭제
	public boolean delete(int pocketNo) {
		String sql = "delete pocketmon where pocket_no=?";
		Object[] param= {pocketNo};
		return jdbcTemplate.update(sql,param)>0;
	}
		
		
}
