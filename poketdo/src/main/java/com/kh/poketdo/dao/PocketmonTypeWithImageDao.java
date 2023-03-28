package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTypeWithImageDto;

@Repository
public class PocketmonTypeWithImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<PocketmonTypeWithImageDto> mapper = new RowMapper<PocketmonTypeWithImageDto>() {

		@Override
		public PocketmonTypeWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PocketmonTypeWithImageDto.builder()
								.pocketTypeNo(rs.getInt("pocket_type_no"))
								.pocketTypeName(rs.getString("pocket_type_name"))
								.attachmentNo(rs.getObject("attachment_no")==null ?
																												null : rs.getInt("attachment_no"))
								.build();
		}
	};
	
		//전체 목록
		public List<PocketmonTypeWithImageDto> selectList(){
			String sql ="select * from pocketmon_type_with_image order by pocket_type_no asc";
			return jdbcTemplate.query(sql, mapper);
		}
		
		//조회
		public List<PocketmonTypeWithImageDto> selectList(String column, String keyword){
			String sql = "select * from pocketmon_type_with_image where instr(#1,?)>0 "
					+ "order by #1 asc";
			sql = sql.replace("#1", column);
			Object[] param = {keyword};
			return jdbcTemplate.query(sql,  mapper, param);
		}
		
		//상세
		public PocketmonTypeWithImageDto selectOne(int pocketTypeNo) {
			String sql ="select * from pocketmon_type_with_image where pocket_type_no=?";
			Object [] param = {pocketTypeNo};
			List<PocketmonTypeWithImageDto> list = jdbcTemplate.query(sql,  mapper, param);
			return list.isEmpty() ? null : list.get(0); 
		}
		
	
	
}
