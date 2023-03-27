package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTypeImageDto;
import com.kh.poketdo.dto.SealImageDto;

@Repository
public class SealImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<SealImageDto> mapper = new RowMapper<SealImageDto>() {

		@Override
		public SealImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return SealImageDto.builder()
					.sealNo(rs.getInt("seal_no"))
					.attachmentNo(rs.getInt("attachment_no"))
				.build();
		}
	};
	
	//이미지 등록
	public void insert (SealImageDto sealImageDto) {
		String sql = "insert into seal_image values(?,?)";
		Object [] param = {
				sealImageDto.getSealNo(),
				sealImageDto.getAttachmentNo()
		};
		jdbcTemplate.update(sql,param);
 	}
	
	//이미지 attachmentNo 검색
	public SealImageDto selectOne(int sealNo) {
		String sql = "select * from seal_image where seal_no=?";
		Object [] param = {sealNo};
		List<SealImageDto> list = jdbcTemplate.query(sql,  mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//삭제
	public boolean imageDelete(int sealNo) {
		String sql="delete from seal_image where seal_no=? ";
		Object[] param = {sealNo};
		return jdbcTemplate.update(sql,param)>0;
	}

}
