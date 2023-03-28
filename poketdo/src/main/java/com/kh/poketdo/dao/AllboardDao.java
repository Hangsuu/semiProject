package com.kh.poketdo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;

@Repository
public class AllboardDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<AllboardDto> mapper = (rs, index) -> {
    return AllboardDto.builder().allboardNo(rs.getInt("allboard_no"))
        .allboardBoardType(rs.getString("allboard_board_type"))
        .allboardBoardNo(rs.getInt("allboard_board_no")).build();
  };

  // allboard 시퀀스 생성
  public int sequence() {
    String sql = "select allboard_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }

  // C allborad 생성
  public void insert(AllboardDto allboardDto) {
    String sql = "insert into allboard (allboard_no, allboard_board_type, allboard_board_no) values (?, ?, ?)";
    Object[] param = {
        allboardDto.getAllboardNo(),
        allboardDto.getAllboardBoardType(),
        allboardDto.getAllboardBoardNo(),
    };
    jdbcTemplate.update(sql, param);
  }

  // R allboard 1개 조회
  public AllboardDto selectOne(int allboardNo) {
    String sql = "select * from allboard where allboard_no=?";
    Object[] param = { allboardNo };
    List<AllboardDto> list = jdbcTemplate.query(sql, mapper, param);
    return list.isEmpty() ? null : list.get(0);
  }

  // R
  // R
  // U
  // D allboard 삭제
  public boolean delete(int allboardNo) {
    String sql = "delete from allboard where allboard_no = ?";
    Object[] param = { allboardNo };
    return jdbcTemplate.update(sql, param) > 0;
  }
}
