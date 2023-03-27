package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTypeImageDto;

@Repository
public class PocketmonTypeImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<PocketmonTypeImageDto> mapper = new RowMapper<PocketmonTypeImageDto>() {

		@Override
		public PocketmonTypeImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketmonTypeImageDto.builder()
					.pocketTypeNo(rs.getInt("pocket_type_no"))
					.attachmentNo(rs.getInt("attachment_no"))
				.build();
		}
	};
	
	//이미지 등록
		public void insert (PocketmonTypeImageDto pocketmonTypeImageDto) {
			String sql = "insert into pocketmon_type_image values(?,?)";
			Object [] param = {
					pocketmonTypeImageDto.getPocketTypeNo(),
					pocketmonTypeImageDto.getAttachmentNo()
			};
			jdbcTemplate.update(sql,param);
	 	}
		
		//이미지 attachmentNo 검색
		public PocketmonTypeImageDto selectOne(int pocketTypeNo) {
			String sql = "select * from pocketmon_type_image where pocket_type_no=?";
			Object [] param = {pocketTypeNo};
			List<PocketmonTypeImageDto> list = jdbcTemplate.query(sql,  mapper, param);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//삭제
		public boolean imageDelete(int pocketTypeNo) {
			String sql="delete from pocketmon_type_image where pocket_type_no=? ";
			Object[] param = {pocketTypeNo};
			return jdbcTemplate.update(sql,param)>0;
		}
	
}
