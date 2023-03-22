package com.kh.poketdo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AllboardDto {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private int allboardNo;
  private String allboardBoardType;
  private int allboardBoardTypeNo;

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
