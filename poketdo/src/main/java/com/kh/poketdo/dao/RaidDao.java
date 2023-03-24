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
					.raidStartTime(rs.getDate("raid_start_time"))
					.raidParticipant(rs.getInt("raid_participant"))
					.raidComplete(rs.getInt("raid_complete"))
					.raidReply(rs.getInt("raid_reply"))
					.raidLike(rs.getInt("raid_like"))
					.raidDislike(rs.getInt("raid_dislike"))
					.raidRead(rs.getInt("raid_read"))
					.raidType(rs.getInt("raid_type")).build();
		}
	};
	public int sequence() {
		String sql = "select allboard_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//생성(C)
	public void insert(RaidDto dto) {
		String sql = "insert into raid(allboard_no, raid_no, raid_writer, raid_title, raid_content, "
				+ "raid_monster, raid_start_time, raid_type) "
				+ "values(?,raid_seq.nextval,?,?,?,?,?,?)";
		Object[] param = {dto.getAllboardNo(), dto.getRaidWriter(), dto.getRaidTitle(), dto.getRaidContent(), 
				dto.getRaidMonster(), dto.getRaidStartTime(), dto.getRaidType()};
		jdbcTemplate.update(sql, param);
		
		AllboardDto allboardDto = new AllboardDto();
		allboardDto.setAllboardNo(dto.getAllboardNo());
		allboardDto.setAllboardBoardType("raid");
		allboardDto.setAllboardBoardNo(selectOne(dto.getAllboardNo()).getRaidNo());
		allboardDao.insert(allboardDto);
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
					"select * from raid where instr(#1, ?)>0 order by raid_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(),vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from raid order by raid_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from raid where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from raid";
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
		String sql = "update raid set raid_title=?, raid_content=?, raid_type=? where allboard_no=?";
		Object[] param = {raidDto.getRaidTitle(), raidDto.getRaidContent(), raidDto.getRaidType(), raidDto.getAllboardNo()};
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
}