package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberJoinSealDto;

@Repository
public class MemberJoinSealDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	

	
	//memberId, sealNo 입력
	public void insert (String memberId, int sealNo) {
		String sql ="insert into member_join_seal (my_seal_no , member_join_id, seal_join_no) values (member_join_seal_seq.nextval,?,?)";
		Object [] param = {memberId, sealNo};
		jdbcTemplate.update(sql, param);
	}
	


	
}
