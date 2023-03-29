package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberSealWithImageDto;
import com.kh.poketdo.dto.PocketmonWithImageDto;
import com.kh.poketdo.dto.SealWithImageDto;
import com.kh.poketdo.vo.PocketPaginationVO;

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
			
			//기본 인장 정보 검색
			public SealWithImageDto selectBasicOne() {
				String sql ="select * from seal_with_image where seal_no=0";
				List<SealWithImageDto> list = jdbcTemplate.query(sql,  mapper);
				return list.isEmpty() ? null : list.get(0); 
			}
	
			
			
			public String selectBasicAttachNo () {
				String sql ="select attachment_no from seal_with_image where seal_no = 0";
				return jdbcTemplate.queryForObject(sql, String.class);
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
			
//			목록
			public List<SealWithImageDto> selectList(PocketPaginationVO vo){
				if(vo.isSearch()) {
					String sql="select*from("
							+ "select rownum RN, TMP.*from ("
							+ " select * from seal_with_image "
							+ " where instr(#1,?)>0"
							+ " order by seal_no asc"
							+ " )TMP"
							+ ")where RN between ? and ?";
					sql=sql.replace("#1", vo.getColumn());
					Object[]param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
					return jdbcTemplate.query(sql, mapper, param);
				}
				else {
					String sql="select * from( "
							+ "select TMP.*, rownum RN from ( "
							+ "select * from seal_with_image "
							+ " order by seal_no asc "
							+ ") TMP ) "
							+ "where RN between ? and ? ";
					Object[]param = {vo.getBegin(), vo.getEnd()};
					return jdbcTemplate.query(sql, mapper, param);
				}
			}
			
}
