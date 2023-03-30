package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTypeDto;

@Repository
public class PocketmonTypeDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  //조회를 위한 RowMapper 생성
  private RowMapper<PocketmonTypeDto> mapper = new RowMapper<PocketmonTypeDto>() {
	@Override
	public PocketmonTypeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PocketmonTypeDto.builder()
				.pocketTypeNo(rs.getInt("pocket_type_no"))
				.pocketTypeName(rs.getString("pocket_type_name"))
				.build();
	}
  };

  //포켓몬스터 타입 정보 입력
  public void insert(PocketmonTypeDto pocketmonTypeDto) {
	  String sql = "insert into pocketmon_type ( "
	  		+ "pocket_type_no, pocket_type_name ) "
	  		+ "values(? , ?)";
	  Object [] param = {
			  							pocketmonTypeDto.getPocketTypeNo(),
			  							pocketmonTypeDto.getPocketTypeName()
	  								};
	  jdbcTemplate.update(sql,param);
  }
  
  //포켓몬스터 타입 정보 목록
  public List<PocketmonTypeDto> selectList(){
	  String sql ="select*from pocketmon_type order by pocket_type_no asc";
	  return jdbcTemplate.query(sql, mapper);
  }
  
  //포켓몬스터 타입 정보 수정
  public boolean edit(PocketmonTypeDto pocketmonTypeDto) {
	  String sql = "update pocketmon_type set "
	  		+ "pocket_type_name=? "
	  		+ "where pocket_type_no=?";
	  Object [] param = {
			  							pocketmonTypeDto.getPocketTypeName(),
			  							pocketmonTypeDto.getPocketTypeNo()
	  								};
	  return jdbcTemplate.update(sql,param)>0;
  }

  
  //포켓몬스터 타입 정보 삭제
  public boolean delete(int pocketTypeNo) {
	  String sql= " delete pocketmon_type where pocket_type_no=?";
	  Object[] param = {pocketTypeNo};
	  return jdbcTemplate.update(sql,param)>0;
  }
  
  
  //포켓몬스터 번호로 포켓몬스터 타입 이름 검색
  public String selectOneForTypeName(int pocketTypeNo) {
    String sql =
      "select pocket_type_name from pocketmon_type where pocket_type_no = ?";
    Object[] param = { pocketTypeNo };
    return jdbcTemplate.queryForObject(sql, String.class, param);
  }
  
  //포켓몬스터 타입 정보 상세 검색
  public PocketmonTypeDto selectOne(int pocketTypeNo) {
	  String sql= 
			  "select * from pocketmon_type where pocket_type_no=?";
			  
	 Object[] param = {pocketTypeNo};
	 List<PocketmonTypeDto> list = jdbcTemplate.query(sql,  mapper, param);
	 return list.isEmpty() ? null : list.get(0);
  }
  

		


}
