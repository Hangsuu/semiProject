package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonImageDto;

@Repository
public class PocketmonImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<PocketmonImageDto> mapper = new RowMapper<PocketmonImageDto>() {

		@Override
		public PocketmonImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketmonImageDto.builder()
					.pocketNo(rs.getInt("pocket_no"))
					.attachmentNo(rs.getInt("attachment_no"))
				.build();
		}
	};
	//이미지 등록
	public void insert (PocketmonImageDto pocketmonImageDto) {
		String sql = "insert into pocketmon_image values(?,?)";
		Object [] param = {
				pocketmonImageDto.getPocketNo(),
				pocketmonImageDto.getAttachmentNo()
		};
		jdbcTemplate.update(sql,param);
 	}
	
	//이미지 attachmentNo 검색
	public PocketmonImageDto selectOne(int pocketNo) {
		String sql = "select * from pocketmon_image where pocket_no=?";
		Object [] param = {pocketNo};
		List<PocketmonImageDto> list = jdbcTemplate.query(sql,  mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
	
}
