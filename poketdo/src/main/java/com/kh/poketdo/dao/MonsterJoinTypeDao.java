package com.kh.poketdo.dao;

import com.kh.poketdo.dto.MonsterJoinTypeDto;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

@Repository
public class MonsterJoinTypeDao {

  //JdbcTemplate 주입
  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<MonsterJoinTypeDto> mapper = new RowMapper<MonsterJoinTypeDto>() {
    @Override
    @Nullable
    public MonsterJoinTypeDto mapRow(ResultSet rs, int rowNum)
      throws SQLException {
      return MonsterJoinTypeDto
        .builder()
        .monsterJoinNo(rs.getInt("monster_join_no"))
        .typeJoinNo(rs.getInt("type_join_no"))
        .build();
    }
  };

  //포켓몬스터 번호 + 속성 번호 입력
  public void insert(int mosterJoinNo, int typeJoinNo) {
    String sql =
      "insert into monster_join_type (monster_join_no, type_join_no) values(?, ?)";
    Object[] param = { mosterJoinNo, typeJoinNo };
    jdbcTemplate.update(sql, param);
  }

  public List<MonsterJoinTypeDto> selectOne(int monsterJoinNo) {
    String sql =
      "select * from monster_join_type where monster_join_no = ? order by type_join_no asc";
    Object[] param = { monsterJoinNo };
    return jdbcTemplate.query(sql, mapper, param);
  }
}
