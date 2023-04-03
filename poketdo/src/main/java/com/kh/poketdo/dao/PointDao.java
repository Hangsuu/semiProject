package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PointDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	public boolean addPoint(String memberId, int point) {
		String sql="update member set member_point = member_point + ? where member_id = ?";
		Object [] param = {point, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	public boolean subPoint( int point, String memberId) {
		String sql="update member set member_point = member_point - ? where member_id = ?";
		Object [] param = {point, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	
	
}
