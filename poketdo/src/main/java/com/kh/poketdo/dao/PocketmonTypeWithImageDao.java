package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTypeWithImageDto;
import com.kh.poketdo.vo.PocketTypePaginationVO;

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
		
		//페이징 적용된 조회 및 카운트
				public int selectCount(PocketTypePaginationVO vo) {
					
					if(vo.isSearch()) {
						String sql = "select count(*) from pocketmon_type_with_image where instr(#1,?)>0";
						sql = sql.replace("#1", vo.getColumn());
						Object[]param =  {vo.getKeyword()};
						return jdbcTemplate.queryForObject(sql, int.class, param);
						
					}
					else {
						String sql = "select count(*) from pocketmon_type";
						return jdbcTemplate.queryForObject(sql, int.class);
					}
				}
		
//		목록
		public List<PocketmonTypeWithImageDto> selectList(PocketTypePaginationVO vo){
			if(vo.isSearch()) {
				String sql="select*from("
						+ "select rownum rn, TMP.*from ("
						+ " select * from pocketmon_type_with_image "
						+ " where instr(#1,?)>0"
						+ " order by pocket_type_no asc"
						+ " )TMP"
						+ ")where rn between ? and ?";
				sql=sql.replace("#1", vo.getColumn());
				Object[]param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper, param);
			}
			else {
				String sql="select * from( "
						+ "select TMP.*, rownum RN from ( "
						+ "select * from pocketmon_type_with_image "
						+ " order by pocket_type_no asc "
						+ ") TMP ) "
						+ "where RN between ? and ? ";
				Object[]param = {vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper, param);
			}
		}
	
}
