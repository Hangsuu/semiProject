package com.kh.poketdo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.vo.CombinationVO;

@Repository
public class CombinationVODao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<CombinationVO> mapper = (rs, index)-> {
		return CombinationVO.builder().tagName(rs.getString("tag_name"))
				.tagCount(rs.getInt("tag_count")).build();
	};
	
	//태그를 포함한 게시물들의 태그를 카운트
	public List<CombinationVO> recommandTag(String tagList){
		String[] list = tagList.split(",");
		int n = list.length;
		String question = "?";
		for(int i=1; i<n; i++) {
			question+=",?";
		}
		
		String sql = "SELECT * FROM ("+
				"SELECT tmp.*, rownum rn FROM ("+
				"SELECT tag_name, COUNT(tag_name) AS tag_count "
				+ "FROM tag "
				+ "WHERE tag_origin IN ("
				+ "SELECT tag_origin "
				+ "FROM tag "
				+ "WHERE tag_name IN ("+question+") "
				+ "GROUP BY tag_origin "
				+ "HAVING COUNT(DISTINCT tag_name) = #1"
				+ ")"
				+ "AND tag_name NOT IN ("+question+")"
				+ "GROUP BY tag_name ORDER BY tag_count DESC"+
				") tmp"+
				") WHERE rn BETWEEN 1 AND 10";
		sql = sql.replace("#1", n+"");
		Object[] param = new Object[n*2];
		for(int i=0; i<n*2; i++) {
			param[i] = (Object)list[i%n];
		}
		return jdbcTemplate.query(sql, mapper, param);
	}
}