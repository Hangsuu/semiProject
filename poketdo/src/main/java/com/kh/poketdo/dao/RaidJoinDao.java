package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.RaidJoinDto;

@Repository
public class RaidJoinDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private RaidDao raidDao;
	
	private RowMapper<RaidJoinDto> mapper  = new RowMapper<RaidJoinDto>() {
		@Override
		public RaidJoinDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RaidJoinDto.builder()
					.raidJoinNo(rs.getInt("raid_join_no"))
					.raidJoinOrigin(rs.getInt("raid_join_origin"))
					.raidJoinMember(rs.getString("raid_join_member"))
					.raidJoinContent(rs.getString("raid_join_content"))
					.raidJoinConfirm(rs.getInt("raid_join_confirm")).build();
		}
	};
	
	public void insert(RaidJoinDto raidJoinDto) {
		String sql="insert into raid_join(raid_join_no, raid_join_origin, raid_join_member,"
				+ "raid_join_content, raid_join_confirm) values(raid_join_seq.nextval, ?,?,?,?)";
		Object[] param= {raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinMember(), raidJoinDto.getRaidJoinContent(),
				raidJoinDto.getRaidJoinConfirm()};
		jdbcTemplate.update(sql, param);
	}
	//확정된 인원수
	public int count(int allboardNo) {
		String sql="select count(*) from raid_join where raid_join_origin=? and raid_join_confirm=1";
		Object[] param= {allboardNo};
		int cnt = jdbcTemplate.queryForObject(sql, int.class, param);
		return cnt; 
	}
	//참가신청한 인원수
	public int participant(int allboardNo) {
		String sql="select count(*) from raid_join where raid_join_origin=?";
		Object[] param= {allboardNo};
		int cnt = jdbcTemplate.queryForObject(sql, int.class, param);
		return cnt; 
	}
	public List<RaidJoinDto> selectList(int allboardNo){
		String sql = "select * from raid_join where raid_join_origin=? and raid_join_confirm=0";
		Object[] param = {allboardNo};
		return jdbcTemplate.query(sql, mapper, param);
	}
	public List<RaidJoinDto> selectConfirmedList(int allboardNo){
		String sql = "select * from raid_join where raid_join_origin=? and raid_join_confirm=1";
		Object[] param = {allboardNo};
		return jdbcTemplate.query(sql, mapper, param);
	}
	public RaidJoinDto selectOne(int allboardNo, String memberId) {
		String sql = "select * from raid_join where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		List<RaidJoinDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	public void delete(int allboardNo, String memberId) {
		String sql = "delete raid_join where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		jdbcTemplate.update(sql, param);
	}
	public void edit(RaidJoinDto raidJoinDto) {
		String sql = "update raid_join set raid_join_content=? where raid_join_origin=? and raid_join_member=?";
		Object[] param = {raidJoinDto.getRaidJoinContent(), raidJoinDto.getRaidJoinOrigin(), raidJoinDto.getRaidJoinMember()};
		jdbcTemplate.update(sql, param);
	}
	//해당 레이드에 신청했는지 여부를 판단
	public boolean isJoiner(int allboardNo, String memberId) {
		String sql = "select count(*) from raid_join where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		return jdbcTemplate.queryForObject(sql, int.class, param)==1;
	}
	//해당 레이드에 확정됐는지 여부를 판단
	public boolean isConfirmed(int allboardNo, String memberId) {
		String sql = "select raid_join_confirm from raid_join where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		return jdbcTemplate.queryForObject(sql, int.class, param)==1;
	}
	//확정상태로 변경
	public void confirm(int allboardNo, String memberId) {
		String sql = "update raid_join set raid_join_confirm=1 where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		jdbcTemplate.update(sql, param);
	}
	//확정상태에서 제거
	public void ban(int allboardNo, String memberId) {
		String sql = "update raid_join set raid_join_confirm=0 where raid_join_origin=? and raid_join_member=?";
		Object[] param = {allboardNo, memberId};
		jdbcTemplate.update(sql, param);
	}
	//확정자, 참가자 숫자를 입력하고 반환하는 메서드
	public List<Integer> joinerCount(int allboardNo){
		List<Integer> list = new ArrayList<>();
		int count = count(allboardNo);
		raidDao.confirmedCount(count, allboardNo);
		int participant = participant(allboardNo);
		list.add(count);
		list.add(participant);
		return list;
	}
}