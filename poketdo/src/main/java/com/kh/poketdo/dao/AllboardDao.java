package com.kh.poketdo.dao;

import com.kh.poketdo.dto.AllboardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AllboardDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  public int sequence() {
    String sql = "select allboard_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }

  // C
  public void insert(AllboardDto allboardDto) {
    String sql =
      "insert into allboard (allboard_no, allboard_board_type, allboard_board_type_no) values (?, ?, ?)";
    Object[] param = {
      allboardDto.getAllboardNo(),
      allboardDto.getAllboardBoardType(),
      allboardDto.getAllboardBoardTypeNo(),
    };
    jdbcTemplate.update(sql, param);
  }
  // R
  // R
  // U
  // D
}
