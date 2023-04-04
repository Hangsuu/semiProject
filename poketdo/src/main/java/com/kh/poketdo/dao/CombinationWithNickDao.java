package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.CombinationWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class CombinationWithNickDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<CombinationWithNickDto> mapper = new RowMapper<CombinationWithNickDto>() {
		@Override
		public CombinationWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return CombinationWithNickDto.builder()
					.allboardNo(rs.getInt("allboard_no"))
					.combinationNo(rs.getInt("Combination_no"))
					.combinationWriter(rs.getString("combination_writer"))
					.combinationTitle(rs.getString("combination_title"))
					.combinationType(rs.getString("combination_type"))
					.combinationContent(rs.getString("combination_content"))
					.combinationTime(rs.getDate("combination_time"))
					.combinationReply(rs.getInt("combination_reply"))
					.combinationLike(rs.getInt("combination_like"))
					.combinationRead(rs.getInt("combination_read"))
					.memberNick(rs.getString("member_nick"))
					.attachmentNo(rs.getInt("attachment_no"))
					.build();
		}
	};
	//태그 검색
	public List<CombinationWithNickDto> tagSearchList(PaginationVO vo){
		//태그 없고 검색어 없을떄
		if(vo.tagList.length()==0 && !vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from combination_with_nick order by combination_no desc"+
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
					"SELECT * FROM combination_with_nick WHERE allboard_no IN"
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
					"select * from combination_with_nick where instr(#1, ?)>0 order by combination_no desc"+
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
					"SELECT * FROM combination_with_nick WHERE allboard_no IN"
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
			String sql = "select count(*) from combination_with_nick";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		else if(vo.tagList.length()>0 && !vo.isSearch()) {
			String[] list = vo.getTagList().split(",");
			int n = list.length;
			String question = "?";
			for(int i=1; i<n; i++) {
				question+=",?";
			}
			String sql = "SELECT count(*) FROM combination_with_nick WHERE allboard_no IN(SELECT tag_origin FROM tag "
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
			String sql = "select count(*) from combination_with_nick where instr(#1, ?)>0";
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
			String sql = "SELECT count(*) FROM combination_with_nick WHERE allboard_no IN(SELECT tag_origin FROM tag "
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
	public CombinationWithNickDto selectOne(int allboardNo) {
		String sql = "select * from combination_with_nick where allboard_no=?";
		Object[] param = {allboardNo};
		List<CombinationWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
}
