package com.kh.poketdo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.TagDto;

@Repository
public class TagDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<TagDto> mapper = (rs, index)->{
		return TagDto.builder().tagName(rs.getString("tag_name"))
				.tagOrigin(rs.getInt("tag_origin")).build();
	};
	
	public void insert(TagDto tagDto) {
		String sql = "insert into tag(tag_name, tag_origin) values(?,?)";
		Object[] param = {tagDto.getTagName(), tagDto.getTagOrigin()};
		jdbcTemplate.update(sql, param);
	}
	public List<TagDto> selectAllboard(String tagName){
		String sql = "select * from tag where tag_name=?";
		Object[] param = {tagName};
		return jdbcTemplate.query(sql, mapper, param);
	}
}
