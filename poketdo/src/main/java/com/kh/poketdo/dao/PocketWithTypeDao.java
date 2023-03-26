package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketWithTypeDto;

@Repository
public class PocketWithTypeDao {

  //JdbcTemplate 주입
  @Autowired
  private JdbcTemplate jdbcTemplate;

  //조회를 위한 RowMapper 생성
  private RowMapper<PocketWithTypeDto> mapper = new RowMapper<PocketWithTypeDto>() {
    @Override
    public PocketWithTypeDto mapRow(ResultSet rs, int rowNum)
      throws SQLException {
      return PocketWithTypeDto
        .builder()
        .pocketNo(rs.getInt("pocket_no"))
        .pocketName(rs.getString("pocket_name"))
        .pocketTypeNo(rs.getInt("pocket_type_no"))
        .pocketTypeName(rs.getString("pocket_type_name"))
        .pocketJoinNo(rs.getInt("pocket_join_no"))
        .typeJoinNo(rs.getInt("type_join_no"))
        .pocketBaseHp(rs.getInt("pocket_base_hp"))
        .pocketBaseAtk(rs.getInt("pocket_base_atk"))
        .pocketBaseDef(rs.getInt("pocket_base_def"))
        .pocketBaseSpd(rs.getInt("pocket_base_spd"))
        .pocketBaseSatk(rs.getInt("pocket_base_satk"))
        .pocketBaseSdef(rs.getInt("pocket_base_sdef"))
        .pocketEffortHp(rs.getInt("pocket_effort_hp"))
        .pocketEffortAtk(rs.getInt("pocket_effort_atk"))
        .pocketEffortDef(rs.getInt("pocket_effort_def"))
        .pocketEffortSpd(rs.getInt("pocket_effort_spd"))
        .pocketEffortSatk(rs.getInt("pocket_effort_satk"))
        .pocketEffortSdef(rs.getInt("pocket_effort_sdef"))
        .build();
    }
  };

  //	포켓몬스터 목록
  public String selectListAddType(int pocketNo) {
    String sql =
      "select pocket_type_name from pocketmon_with_type where pocket_no=?";
    Object[] param = { pocketNo };
    return jdbcTemplate.queryForObject(sql, String.class, param);
  }
}
