package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.SealWithImageDto;

@Repository
public class SealWithImageDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<SealWithImageDto> mapper = new RowMapper<SealWithImageDto>() {

		@Override
		public SealWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return SealWithImageDto.builder()
								.sealNo(rs.getInt("seal_no"))
								.sealName(rs.getString("seal_name"))
								.sealPrice(rs.getInt("seal_price"))
								.attachmentNo(rs.getObject("attachment_no")==null ?
																												null : rs.getInt("attachment_no")
									)
								.build();
		}
	};
	
	//전체 목록
			public List<SealWithImageDto> selectList(){
				String sql ="select * from seal_with_image order by seal_no asc";
				return jdbcTemplate.query(sql, mapper);
			}
			
			//조회
			public List<SealWithImageDto> selectList(String column, String keyword){
				String sql = "select * from seal_with_image where instr(#1,?)>0 "
						+ "order by #1 asc";
				sql = sql.replace("#1", column);
				Object[] param = {keyword};
				return jdbcTemplate.query(sql,  mapper, param);
			}
			
			//상세
			public SealWithImageDto selectOne(int sealNo) {
				String sql ="select * from seal_with_image where seal_no=?";
				Object [] param = {sealNo};
				List<SealWithImageDto> list = jdbcTemplate.query(sql,  mapper, param);
				return list.isEmpty() ? null : list.get(0); 
			}
	
}
