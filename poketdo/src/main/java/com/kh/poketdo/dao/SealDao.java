package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.SealDto;

@Repository
public class SealDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	  //조회를 위한 RowMapper 생성
	  private RowMapper<SealDto> mapper = new RowMapper<SealDto>() {
		@Override
		public SealDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return SealDto.builder()
					.sealNo(rs.getInt("seal_no"))
					.sealName(rs.getString("seal_name"))
					.build();
		}
	  };
	
	  //인장 정보 입력
	  public void insert(SealDto sealDto) {
		  String sql = "insert into seal ( "
		  		+ "seal_no, seal_name) "
		  		+ "values(? , ?)";
		  Object[] param = {
				  sealDto.getSealNo(),
				  sealDto.getSealName()
		  };
		  jdbcTemplate.update(sql,param);
	  }
	  
	  //인장 정보 목록
	  public List<SealDto> selectList(){
		  String sql = "select*from seal order by seal_no asc";
		  return jdbcTemplate.query(sql, mapper);
	  }
	  
	  //인장 정보 수정
	  public boolean edit(SealDto sealDto) {
		  String sql = "update seal set seal_name=? where seal_no=?";
		  Object[] param = {sealDto.getSealName(), sealDto.getSealNo()};
		  return jdbcTemplate.update(sql,param)>0;
	  }
	  
	  //인장 정보 삭제
	  public boolean delete(int sealNo) {
		  String sql = "delete seal where seal_no=?";
		  Object[] param = {sealNo};
		  return jdbcTemplate.update(sql,param)>0;
	  }
	  
	  //인장 정보 상세 검색
	  public SealDto selectOne(int sealNo) {
		  String sql ="select*from seal where seal_no=?";
		  Object[] param = {sealNo};
		  List<SealDto> list = jdbcTemplate.query(sql, mapper, param);
		  return list.isEmpty() ? null : list.get(0);
	  }
	  
}
