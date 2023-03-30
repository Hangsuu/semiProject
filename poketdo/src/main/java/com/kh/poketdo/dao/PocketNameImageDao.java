package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonNameImageDto;

@Repository
public class PocketNameImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<PocketmonNameImageDto> mapper = new RowMapper<PocketmonNameImageDto>() {
		public PocketmonNameImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketmonNameImageDto.builder()
					.pocketNo(rs.getInt("pocket_no"))
					.attachmentNo(rs.getInt("attachment_no"))
					.pocketName(rs.getString("pocket_name"))
					.build();
		}
	};
	
	//포켓몬스터 이름으로 attachmentNo 검색
	public PocketmonNameImageDto selectOne(String pocketName) {
		String sql = "select*from pocketmon_name_image where pocket_name=?";
		Object[] param = {pocketName};
		List<PocketmonNameImageDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
}
