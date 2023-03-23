package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.RaidJoinDto;

@Repository
public class RaidJoinDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<RaidJoinDto> mapper  = new RowMapper<RaidJoinDto>() {
		@Override
		public RaidJoinDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RaidJoinDto.builder()
					.raidJoinNo(rs.getInt("raid_join_no"))
					.raidJoinOrigin(rs.getInt("raid_join_origin"))
					.raidJoinParticipant(rs.getString("raid_join_participant"))
					.raidJoinContent(rs.getString("raid_join_content"))
					.raidJoinConfirm(rs.getInt("raid_join_confirm")).build();
		}
	};
	
	public void insert(RaidJoinDto raidJoinDto) {
		String sql="insert into raid_join(raid_join_no, raid_join_origin, raid_join_participant,"
				+ "raid_join_content, raid_join_confirm) values(raid_join_seq.nextval,?,?,?,?)";
		Object[] param= {raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinParticipant(), raidJoinDto.getRaidJoinContent(),
				raidJoinDto.getRaidJoinConfirm()};
		jdbcTemplate.update(sql, param);
	}
	public int count(int seqNo) {
		String sql="select count(*) from raid_join where raid_join_origin=? and raid_join_confirm=1";
		Object[] param= {seqNo};
		Integer cnt = jdbcTemplate.queryForObject(sql, Integer.class, param);
		if(cnt==null) cnt=0;
		return cnt; 
	}
}