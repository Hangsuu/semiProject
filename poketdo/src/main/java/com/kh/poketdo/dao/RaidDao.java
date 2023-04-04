package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.RaidDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class RaidDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AllboardDao allboardDao;
	
	private RowMapper<RaidDto> mapper = new RowMapper<RaidDto>() {
		@Override
		public RaidDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return RaidDto.builder()
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
					.raidType(rs.getInt("raid_type")).build();
		}
	};
	public int sequence() {
		String sql = "select allboard_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int raidSequence() {
		String sql = "select raid_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//생성(C)
	public void insert(RaidDto dto) {
		String sql = "insert into raid(allboard_no, raid_no, raid_writer, raid_title, raid_content, "
				+ "raid_monster, raid_start_time, raid_code, raid_type) "
				+ "values(?,?,?,?,?,?,?,?,?)";
		int raidSeq = raidSequence();
		dto.setRaidNo(raidSeq);
		Object[] param = {dto.getAllboardNo(),dto.getRaidNo(), dto.getRaidWriter(), dto.getRaidTitle(), dto.getRaidContent(), 
				dto.getRaidMonster(), dto.getRaidStartTime(), dto.getRaidCode(), dto.getRaidType()};
		
		AllboardDto allboardDto = new AllboardDto();
		allboardDto.setAllboardNo(dto.getAllboardNo());
		allboardDto.setAllboardBoardType("raid");
		allboardDto.setAllboardBoardNo(raidSeq);
		allboardDao.insert(allboardDto);
		
		jdbcTemplate.update(sql, param);
	}
	//삭제(D)
	public boolean delete(int allboardNo) {
		String sql = "delete raid where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param)>0;
	}
	//읽기(R)
	public List<RaidDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from raid where instr(#1, ?)>0 #4 order by #2 #3"+
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
					"select * from raid #4 order by #2 #3"+
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
			String sql = "select count(*) from raid where instr(#1, ?)>0 #4";
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
			String sql = "select count(*) from raid #4";
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	public void readCount(int allboardNo) {
		String sql = "update raid set raid_read=raid_read+1 where allboard_no=?";
		Object[] param = {allboardNo};
		jdbcTemplate.update(sql, param);
	}
	public RaidDto selectOne(int allboardNo) {
		String sql = "select * from raid where allboard_no=?";
		Object[] param = {allboardNo};
		List<RaidDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	//수정(U)
	public boolean edit(RaidDto raidDto) {
		String sql = "update raid set raid_title=?, raid_content=?, raid_type=?, raid_code=? where allboard_no=?";
		Object[] param = {raidDto.getRaidTitle(), raidDto.getRaidContent(), raidDto.getRaidType(), raidDto.getRaidCode(), raidDto.getAllboardNo()};
		return jdbcTemplate.update(sql, param)>0;
	}
	//댓글 갯수 반영
	public void replySet(int allboardNo, int replyCount) {
		String sql = "update raid set raid_reply=? where allboard_no=?";
		Object[] param = {replyCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//좋아요 갯수 반영
	public void likeSet(int allboardNo, int likeCount) {
		String sql = "update raid set raid_like=? where allboard_no=?";
		Object[] param = {likeCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//확정된 참가자 숫자를 입력
	public void confirmedCount(int count, int allboardNo) {
		String sql = "update raid set raid_count=? where allboard_no=?";
		Object[] param = {count, allboardNo};
		jdbcTemplate.update(sql, param);
	}
}