package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberSealWithImageDto;

@Repository
public class MemberSealWithImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<MemberSealWithImageDto> mapper 
		= new RowMapper<MemberSealWithImageDto>() {

			@Override
			public MemberSealWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
				return MemberSealWithImageDto.builder()
						.memberJoinId(rs.getString("member_join_id"))
						.sealNo(rs.getInt("seal_no"))
						.sealPrice(rs.getInt("seal_price"))
						.mySealNo(rs.getInt("my_seal_no"))
						.sealName(rs.getString("seal_Name"))
						.attachmentNo(rs.getObject("attachment_no")==null ?
								null : rs.getInt("attachment_no"))
						.build();
			}
	};
	
	public List<MemberSealWithImageDto> selectOne(String memberId) {
		String sql = "select * from member_seal_with_image where member_join_id =? order by my_seal_no asc";
		Object[] param = {memberId};
		return jdbcTemplate.query(sql,mapper,param);
	}
	
}
