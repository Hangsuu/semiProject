package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonWithImageDto;

@Repository
public class PocketmonWithImageDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<PocketmonWithImageDto> mapper = new RowMapper<PocketmonWithImageDto>() {

		@Override
		public PocketmonWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketmonWithImageDto.builder()
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
								.attachmentNo(rs.getObject("attachment_no")==null ?
																												null : rs.getInt("attachment_no")
									)
								.build();
		}
		
	};
	
	//전체 목록
	public List<PocketmonWithImageDto> selectList(){
		String sql ="select * from pocketmon_with_image order by pocket_no asc";
		return jdbcTemplate.query(sql, mapper);
	}
	//조회
	public List<PocketmonWithImageDto> selectList(String column, String keyword){
		String sql = "select * from pocketmon_with_image where instr(#1,?)>0 "
				+ "order by #1 asc";
		sql = sql.replace("#1", column);
		Object[] param = {keyword};
		return jdbcTemplate.query(sql,  mapper, param);
	}
	
	//상세
	public PocketmonWithImageDto selectOne(int pocketNo) {
		String sql ="select * from pocketmon_with_image where pocket_no=?";
		Object [] param = {pocketNo};
		List<PocketmonWithImageDto> list = jdbcTemplate.query(sql,  mapper, param);
		return list.isEmpty() ? null : list.get(0); 
	}
	
	
	
}
