package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.DislikeBoardDto;

@Repository
public class DislikeBoardDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//등록
	public void insert(DislikeBoardDto dislikeboardDto) {
		String sql = "insert into dislike_table(member_id, allboard_no) values(?,?)";
		System.out.println("sql: " + sql);
		Object[] param = {dislikeboardDto.getMemberId(),
						  dislikeboardDto.getAllboardNo()};
		jdbcTemplate.update(sql, param);
	}
	
	//삭제
	public void delete(DislikeBoardDto dislikeboardDto) {
		String sql = "delete dislike_table where allboard_no = ? and member_id = ?";
		Object[] param = {dislikeboardDto.getAllboardNo(),
						  dislikeboardDto.getMemberId()};
		jdbcTemplate.update(sql, param);
	}
	//확인 - count
	public boolean check(DislikeBoardDto dislikeboardDto) {
		String sql = "select count(*) from dislike_table where allboard_no = ? and member_id = ?";
		Object[] param = {dislikeboardDto.getAllboardNo(),
						  dislikeboardDto.getMemberId()};
		int count = jdbcTemplate.queryForObject(sql, int.class, param);
		return count == 1;
	}
	//글에 대한 좋아요 개수
	public int count(int allboardNo) {
		String sql = "select count(*) from dislike_table where allboard_no = ?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
}
