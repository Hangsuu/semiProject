package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberSealWithImageDto;
import com.kh.poketdo.vo.PocketPaginationVO;

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
						.sealJoinNo(rs.getInt("seal_join_no"))
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
	
	//memberId 와 memberSealNo 로 attachmentNo 검색
	public String selectAttachNo (String memberId, String memberSealNo) {
		String sql ="select attachment_no from member_seal_with_image where member_join_id =? and my_seal_no =? ";
		Object[] param = {memberId, memberSealNo};
		return jdbcTemplate.queryForObject(sql, String.class, param);
	}
	
	//페이징 적용된 조회 및 카운트
	public int selectCount(PocketPaginationVO vo) {
		
		if(vo.isSearch()) {
			String sql = "select count(*) from seal_with_image where instr(#1,?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[]param =  {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
			
		}
		else {
			String sql = "select count(*) from seal_with_image";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//페이징 적용된 조회 및 카운트
	public int mySelectCount(String memberId, PocketPaginationVO vo) {
		
		if(vo.isSearch()) {
			String sql = "select count(*) from member_seal_with_image where instr(#1,?)>0 and member_join_id = ?" ;
			sql = sql.replace("#1", vo.getColumn());
			Object[]param =  {vo.getKeyword(), memberId};
			return jdbcTemplate.queryForObject(sql, int.class, param);
			
		}
		else {
			String sql = "select count(*) from member_seal_with_image where member_join_id=?";
			Object[] param = {memberId};
			return jdbcTemplate.queryForObject(sql, int.class,param);
		}
	}
	
//	목록
	public List<MemberSealWithImageDto> selectOne(String memberId, PocketPaginationVO vo){
		if(vo.isSearch()) {
			String sql="select*from( "
					+ "select TMP.*, rownum RN from (  "
					+ " select * from member_seal_with_image "
					+ " where instr(#1,?)>0 "
					+ " and member_join_id = ?"
					+ " order by seal_no asc "
					+ " ) TMP ) "
					+ " where RN between ? and ?";
			sql=sql.replace("#1", vo.getColumn());
			Object[]param = { vo.getKeyword(), memberId, vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql="select * from( "
					+ "select TMP.*, rownum RN from ( "
					+ "select * from member_seal_with_image "
					+ " where member_join_id = ? "
					+ " order by seal_no asc "
					+ ") TMP ) "
					+ "where RN between ? and ? ";
			Object[]param = {memberId, vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}

	
}
