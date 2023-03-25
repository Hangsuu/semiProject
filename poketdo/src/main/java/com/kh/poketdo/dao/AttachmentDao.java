package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AttachmentDto;

@Repository
public class AttachmentDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<AttachmentDto> mapper = new RowMapper<AttachmentDto>() {
		
		@Override
		public AttachmentDto mapRow(ResultSet rs, int rowNum) throws SQLException{
			
			return AttachmentDto.builder()
					.attachmentNo(rs.getInt("attachment_no"))
					.attachmentName(rs.getString("attachment_name"))
					.attachmentType(rs.getString("attachment_type"))
					.attachmentSize(rs.getLong("attachment_size"))
				.build();
		}
	};
		
	public int sequence() {
		String sql = "select attachment_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);	
	}
	public void insert(AttachmentDto attachmentDto) {
		String sql = "insert into attachment("
				+ "attachment_no, attachment_name, "
				+ "attachment_type, attachment_size "
				+ ") values(?,?,?,?)";
		Object[] param = {
				attachmentDto.getAttachmentNo(),
				attachmentDto.getAttachmentName(),
				attachmentDto.getAttachmentType(),
				attachmentDto.getAttachmentSize()
		};
		jdbcTemplate.update(sql, param);
	}
	
	//상세 조회 구현
	public AttachmentDto selectOne(int attachmentNo) {
		String sql = "select * from attachment where attachment_no =?";
		Object[] param = {attachmentNo};
		List<AttachmentDto> list = jdbcTemplate.query(sql, mapper, param);
		
		return list.isEmpty() ? null : list.get(0);
	}
	
	

}
