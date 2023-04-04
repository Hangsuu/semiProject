package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.RaidWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class RaidWithNickDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<RaidWithNickDto> mapper = new RowMapper<RaidWithNickDto>() {
		@Override
		public RaidWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RaidWithNickDto.builder()
					.allboardNo(rs.getInt("allboard_no"))
					.raidNo(rs.getInt("raid_no"))
					.raidWriter(rs.getString("raid_writer"))
					.raidTitle(rs.getString("raid_title"))
					.raidContent(rs.getString("raid_content"))
					.raidMonster(rs.getString("raid_monster"))
					.raidTime(rs.getDate("raid_time"))
					.raidStartTime(rs.getTimestamp("raid_start_time"))
					.raidCode(rs.getString("raid_code"))
					.raidCount(rs.getInt("raid_count"))
					.raidReply(rs.getInt("raid_reply"))
					.raidLike(rs.getInt("raid_like"))
					.raidRead(rs.getInt("raid_read"))
					.raidType(rs.getInt("raid_type"))
					.memberNick(rs.getString("member_nick"))
					.attachmentNo(rs.getInt("attachment_no"))
					.build();
		}
	};
	
	//읽기(R)
	public List<RaidWithNickDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from raid_with_nick where instr(#1, ?)>0 #4 order by #2 #3"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			sql = sql.replace("#2", vo.getItem());
			sql = sql.replace("#3", vo.getOrder());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "and "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getKeyword(), vo.getBegin(),vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from raid_with_nick #4 order by #2 #3"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#2", vo.getItem());
			sql = sql.replace("#3", vo.getOrder());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from raid_with_nick where instr(#1, ?)>0 #4";
			sql = sql.replace("#1", vo.getColumn());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "and "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from raid_with_nick #4";
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	public RaidWithNickDto selectOne(int allboardNo) {
		String sql = "select * from raid_with_nick where allboard_no=?";
		Object[] param = {allboardNo};
		List<RaidWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
}
