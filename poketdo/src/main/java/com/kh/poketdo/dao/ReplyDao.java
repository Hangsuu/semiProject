package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.ReplyDto;

@Repository
public class ReplyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<ReplyDto> mapper = (rs, index) -> {
			return ReplyDto.builder()
									 .replyNo(rs.getInt("reply_no"))
									 .replyOrigin(rs.getInt("reply_origin"))
									 .replyWriter(rs.getString("reply_writer"))
									 .replyContent(rs.getString("reply_content"))
									 .replyTime(rs.getDate("reply_time"))
									 .replyGroup(rs.getInt("reply_group"))
									 .build();
	};
	
	//등록
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply("
					+ "reply_no, reply_origin, reply_writer, reply_content, "
					+ "reply_time, reply_group"
					+ ") "
					+ "values(reply_seq.nextval, ?, ?, ?, sysdate, ?)";
		Object[] param = {
				replyDto.getReplyOrigin(), replyDto.getReplyWriter(),
				replyDto.getReplyContent(), replyDto.getReplyGroup()
		};
		jdbcTemplate.update(sql, param);
	}
	
	// 소속 글번호마다 댓글 순번대로 나열
	public List<ReplyDto> selectList(int replyOrigin){
		String sql = "select * from reply "
					+ "where reply_origin = ? "
					+ "order by reply_no asc";
		Object[] param = {replyOrigin};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	// 수정
	public void update(ReplyDto replyDto) {
		String sql = "update reply set reply_content = ? where reply_no = ?";
		Object[] param = {replyDto.getReplyContent(), replyDto.getReplyNo()};
		jdbcTemplate.update(sql, param);
	}
	
	// 삭제
	public void delete(int replyNo) {
		String sql = "delete reply where reply_no = ?";
		Object[] param = {replyNo};
		jdbcTemplate.update(sql, param);
	}
}
