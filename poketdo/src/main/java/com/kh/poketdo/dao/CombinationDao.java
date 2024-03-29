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
	@Autowired
	private TagDao tagDao;
	
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
	//태그 검색
	public List<CombinationDto> tagSearchList(PaginationVO vo){
		//태그 없고 검색어 없을떄
		if(vo.tagList.length()==0 && !vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from combination order by combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		//태그 있고 검색어 없을 때
		else if(vo.tagList.length()>0 && !vo.isSearch()) {
			String[] list = vo.getTagList().split(",");
			int n = list.length;
			String question = "?";
			for(int i=1; i<n; i++) {
				question+=",?";
			}
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT * FROM combination WHERE allboard_no IN"
					+ "(SELECT tag_origin FROM tag WHERE tag_name in("+question+") "
					+ "GROUP BY tag_origin HAVING count(DISTINCT tag_name)=#1) "
					+ "ORDER BY combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", n+"");
			Object[] param = new Object[n+2];
			for(int i=0; i<n; i++) {
				param[i]=list[i];
			}
			param[n] = vo.getBegin();
			param[n+1] = vo.getEnd();
			return jdbcTemplate.query(sql, mapper, param);
		}
		//태그 없고 검색어 있을 때
		else if(vo.tagList.length()==0 && vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from combination where instr(#1, ?)>0 order by combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(),vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		//다있을 때
		else {
			String[] list = vo.getTagList().split(",");
			int n = list.length;
			String question = "?";
			for(int i=1; i<n; i++) {
				question+=",?";
			}
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT * FROM combination WHERE allboard_no IN"
					+ "(SELECT tag_origin FROM tag WHERE tag_name in("+question+") "
					+ "GROUP BY tag_origin HAVING count(DISTINCT tag_name)=#1) "
					+ "and instr(#2, ?)>0 "
					+ "ORDER BY combination_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", n+"");
			sql = sql.replace("#2", vo.getColumn());
			Object[] param = new Object[n+3];
			for(int i=0; i<n; i++) {
				param[i]=list[i];
			}
			param[n] = vo.getKeyword();
			param[n+1] = vo.getBegin();
			param[n+2] = vo.getEnd();
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int tagListCount(PaginationVO vo) {
		if(vo.tagList.length()==0 && !vo.isSearch()) {
			String sql = "select count(*) from combination";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		else if(vo.tagList.length()>0 && !vo.isSearch()) {
			String[] list = vo.getTagList().split(",");
			int n = list.length;
			String question = "?";
			for(int i=1; i<n; i++) {
				question+=",?";
			}
			String sql = "SELECT count(*) FROM combination WHERE allboard_no IN(SELECT tag_origin FROM tag "
					+ "WHERE tag_name in("+question+")"
					+ " GROUP BY tag_origin HAVING count(DISTINCT tag_name)=#1)";
			sql = sql.replace("#1", n+"");
			Object[] param = new Object[n];
			for(int i=0; i<n; i++) {
				param[i]=list[i];
			}
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else if(vo.tagList.length()==0 && vo.isSearch()) {
			String sql = "select count(*) from combination where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String[] list = vo.getTagList().split(",");
			int n = list.length;
			String question = "?";
			for(int i=1; i<n; i++) {
				question+=",?";
			}
			String sql = "SELECT count(*) FROM combination WHERE allboard_no IN(SELECT tag_origin FROM tag "
					+ "WHERE tag_name in("+question+")"
					+ " GROUP BY tag_origin HAVING count(DISTINCT tag_name)=#1) "
					+ "and instr(#2, ?)>0";
			sql = sql.replace("#1", n+"");
			sql = sql.replace("#2", vo.getColumn());
			Object[] param = new Object[n+1];
			for(int i=0; i<n; i++) {
				param[i]=list[i];
			}
			param[n] = vo.getKeyword();
			return jdbcTemplate.queryForObject(sql, int.class, param);
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