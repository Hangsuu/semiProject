package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.CombinationDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class CombinationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AllboardDao allboardDao;
	
	private RowMapper<CombinationDto> mapper = new RowMapper<CombinationDto>() {
		@Override
		public CombinationDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return CombinationDto.builder()
					.allboardNo(rs.getInt("allboard_no"))
					.combinationNo(rs.getInt("Combination_no"))
					.combinationWriter(rs.getString("combination_writer"))
					.combinationTitle(rs.getString("combination_title"))
					.combinationType(rs.getString("combination_type"))
					.combinationContent(rs.getString("combination_content"))
					.combinationTime(rs.getDate("combination_time"))
					.combinationReply(rs.getInt("combination_reply"))
					.combinationLike(rs.getInt("combination_like"))
					.combinationRead(rs.getInt("combination_read")).build();
		}
	};
	public int sequence() {
		String sql = "select allboard_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int combinationSequence() {
		String sql = "select combination_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//생성(C)
	public void insert(CombinationDto dto) {
		String sql = "insert into combination(allboard_no, combination_no, combination_writer, combination_title,"
				+ " combination_type,combination_content) "
				+ "values(?,?,?,?,?,?)";
		int combinationSeq = combinationSequence();
		dto.setCombinationNo(combinationSeq);
		Object[] param = {dto.getAllboardNo(), dto.getCombinationNo(), dto.getCombinationWriter(), dto.getCombinationTitle(), 
				dto.getCombinationType(), dto.getCombinationContent()};		
		AllboardDto allboardDto = new AllboardDto();
		allboardDto.setAllboardNo(dto.getAllboardNo());
		allboardDto.setAllboardBoardType("combination");
		allboardDto.setAllboardBoardNo(combinationSeq);
		allboardDao.insert(allboardDto);
		
		jdbcTemplate.update(sql, param);
	}
	//삭제(D)
	public boolean delete(int allboardNo) {
		String sql = "delete combination where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param)>0;
	}
	//읽기(R)
	public List<CombinationDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from combination where instr(#1, ?)>0 order by combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(),vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from combination order by combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from combination where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from combination";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	public void readCount(int allboardNo) {
		String sql = "update combination set combination_read=combination_read+1 where allboard_no=?";
		Object[] param = {allboardNo};
		jdbcTemplate.update(sql, param);
	}
	public CombinationDto selectOne(int allboardNo) {
		String sql = "select * from combination where allboard_no=?";
		Object[] param = {allboardNo};
		List<CombinationDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	//수정(U)
	public boolean edit(CombinationDto combinationDto) {
		String sql = "update combination set combination_title=?, combination_content=? , combination_type=? where allboard_no=?";
		Object[] param = {combinationDto.getCombinationTitle(), combinationDto.getCombinationContent(),
				combinationDto.getCombinationType(), combinationDto.getAllboardNo()};
		return jdbcTemplate.update(sql, param)>0;
	}
	//댓글 갯수 반영
	public void replySet(int allboardNo, int replyCount) {
		String sql = "update combination set combination_reply=? where allboard_no=?";
		Object[] param = {replyCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//좋아요 갯수 반영
	public void likeSet(int allboardNo, int likeCount) {
		String sql = "update combination set combination_like=? where allboard_no=?";
		Object[] param = {likeCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
}