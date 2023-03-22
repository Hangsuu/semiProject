package com.kh.poketdo.dao;

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
  // R
  // R
  // U
  // D
}
