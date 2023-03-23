package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MonsterTypeDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  public String selectOne(int monsterTypeNo) {
    String sql =
      "select monster_type_name from monster_type where monster_type_no = ?";
    Object[] param = { monsterTypeNo };
    return jdbcTemplate.queryForObject(sql, String.class, param);
  }
}
