package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberStatDto;

@Repository
public class MemberStatDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	
	private RowMapper<MemberStatDto> mapper = new RowMapper<MemberStatDto>() {
		@Override
		public MemberStatDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberStatDto dto = new MemberStatDto();
			dto.setMemberLevel(rs.getString("member_level"));
			dto.setTotal(rs.getInt("total"));
			dto.setCnt(rs.getInt("cnt"));
			dto.setAverage(rs.getFloat("average"));
			dto.setMax(rs.getInt("max"));
			dto.setMin(rs.getInt("min"));
			return dto;
		}
	};
	
	public List<MemberStatDto> selectList(){
		String sql = "select * from member_stat order by member_level asc";
		return jdbcTemplate.query(sql, mapper);
	}
}
