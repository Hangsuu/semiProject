package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonJoinTypeDto;

@Repository
public class PocketmonJoinTypeDao {

  //JdbcTemplate 주입
  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<PocketmonJoinTypeDto> mapper = new RowMapper<PocketmonJoinTypeDto>() {
    @Override
    @Nullable
    public PocketmonJoinTypeDto mapRow(ResultSet rs, int rowNum)
      throws SQLException {
      return PocketmonJoinTypeDto
        .builder()
        .pocketJoinNo(rs.getInt("pocket_join_no"))
        .joinNo(rs.getInt("join_no"))
        .typeJoinNo(rs.getInt("type_join_no"))
        .build();
    }
  };

  //포켓몬스터 번호 + 속성 번호 입력
  public void insert(int pocketJoinNo, int typeJoinNo) {
    String sql =
      "insert into pocketmon_join_type (join_no, pocket_join_no, type_join_no) values(pocketmon_join_type_seq.nextval ,?, ?)";
    Object[] param = { pocketJoinNo, typeJoinNo };
    jdbcTemplate.update(sql, param);
  }

  //포켓몬스터 속성 수정
  public boolean edit(int editTypeJoinNo,  int JoinNo) {
	  String sql = "update pocketmon_join_type set type_join_no = ? where  join_no = ?";
	  Object[] param = {editTypeJoinNo, JoinNo};
	  return jdbcTemplate.update(sql,param)>0;
  }
  
  
  //포켓몬스터 번호로 포켓몬스터 속성 검색
  public List<PocketmonJoinTypeDto> selectOne(int pocketJoinNo) {
    String sql =
      "select * from pocketmon_join_type where pocket_join_no = ? order by type_join_no desc";
    Object[] param = { pocketJoinNo };
    return jdbcTemplate.query(sql, mapper, param);
  }
  
  
}
