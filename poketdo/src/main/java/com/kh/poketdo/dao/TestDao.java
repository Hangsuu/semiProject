package com.kh.poketdo.dao;

import com.kh.poketdo.dto.TestDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TestDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  public void insert(TestDto testdto) {
    String sql = "INSERT INTO TEST VALUES(?)";
    Object[] param = { testdto.getTime() };
    jdbcTemplate.update(sql, param);
  }
}
