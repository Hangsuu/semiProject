package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.RaidJoinWithNickDto;

@Repository
public class RaidJoinWithNickDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<RaidJoinWithNickDto> mapper  = new RowMapper<RaidJoinWithNickDto>() {
		@Override
		public RaidJoinWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RaidJoinWithNickDto.builder()
					.raidJoinNo(rs.getInt("raid_join_no"))
					.raidJoinOrigin(rs.getInt("raid_join_origin"))
					.raidJoinMember(rs.getString("raid_join_member"))
					.raidJoinContent(rs.getString("raid_join_content"))
					.raidJoinConfirm(rs.getInt("raid_join_confirm"))
					.memberNick(rs.getString("member_nick"))
					.attachmentNo(rs.getInt("attachment_no"))
					.build();
		}
	};
	public List<RaidJoinWithNickDto> selectList(int allboardNo){
		String sql = "select * from raid_join_with_nick where raid_join_origin=? and raid_join_confirm=0";
		Object[] param = {allboardNo};
		return jdbcTemplate.query(sql, mapper, param);
	}
	public List<RaidJoinWithNickDto> selectConfirmedList(int allboardNo){
		String sql = "select * from raid_join_with_nick where raid_join_origin=? and raid_join_confirm=1";
		Object[] param = {allboardNo};
		return jdbcTemplate.query(sql, mapper, param);
	}
}
