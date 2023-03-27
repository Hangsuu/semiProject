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
        .typeJoinNo(rs.getInt("type_join_no"))
        .build();
    }
  };

  //포켓몬스터 번호 + 속성 번호 입력
  public void insert(int pocketJoinNo, int typeJoinNo) {
    String sql =
      "insert into pocketmon_join_type (pocket_join_no, type_join_no) values(?, ?)";
    Object[] param = { pocketJoinNo, typeJoinNo };
    jdbcTemplate.update(sql, param);
  }

  //포켓몬스터 번호로 포켓몬스터 속성 검색
  public List<PocketmonJoinTypeDto> selectOne(int pocketJoinNo) {
    String sql =
      "select * from pocketmon_join_type where pocket_join_no = ? order by type_join_no asc";
    Object[] param = { pocketJoinNo };
    return jdbcTemplate.query(sql, mapper, param);
  }
}
