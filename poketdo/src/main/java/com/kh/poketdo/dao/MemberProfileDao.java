package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberProfileDto;

@Repository
public class MemberProfileDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<MemberProfileDto> mapper = new RowMapper<MemberProfileDto>() {
		@Override
		public MemberProfileDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return MemberProfileDto.builder()
						.memberId(rs.getString("member_id"))
						.attachmentNo(rs.getInt("attachment_no"))
					.build();
		}
	};

	public void insert(MemberProfileDto memberProfileDto) {
		String sql = "insert into member_profile(member_id, attachment_no) values(?, ?)";
		Object[] param = {
				memberProfileDto.getMemberId(),
				memberProfileDto.getAttachmentNo()
		};
		jdbcTemplate.update(sql, param);
	}
	
	public MemberProfileDto selectOne(String memberId) {
		String sql = "select * from member_profile where member_id = ?";
		Object[] param = {memberId};
		List<MemberProfileDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}


	
	
}
