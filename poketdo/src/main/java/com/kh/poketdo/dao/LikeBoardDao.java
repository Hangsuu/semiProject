package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.LikeBoardDto;

@Repository
public class LikeBoardDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//등록
	public void insert(LikeBoardDto likeboardDto) {
		String sql = "insert into like_table(allboard_no, member_id) values(?, ?)";
		Object[] param = {likeboardDto.getAllboardNo(),
						  likeboardDto.getMemberId()};
		jdbcTemplate.update(sql, param);
	}
	
	//삭제
	public void delete(LikeBoardDto likeboardDto) {
		String sql = "delete like_table where allboard_no = ? and member_id = ?";
		Object[] param = {likeboardDto.getAllboardNo(),
						  likeboardDto.getMemberId()};
		jdbcTemplate.update(sql, param);
	}
	//확인 - count
	public boolean check(LikeBoardDto likeboardDto) {
		String sql = "select count(*) from like_table where allboard_no = ? and member_id = ?";
		Object[] param = {likeboardDto.getAllboardNo(),
						  likeboardDto.getMemberId()};
		int count = jdbcTemplate.queryForObject(sql, int.class, param);
		return count == 1;
	}
	//글에 대한 좋아요 개수
	public int count(int allboardNo) {
		String sql = "select count(*) from like_table where allboard_no = ?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
}
