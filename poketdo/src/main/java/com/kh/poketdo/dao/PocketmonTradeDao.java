package com.kh.poketdo.dao;

import com.kh.poketdo.dto.PocketmonTradeDto;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
@RequestMapping("/trade")
public class PocketmonTradeDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<PocketmonTradeDto> mapper = new RowMapper<>() {
    @Override
    @Nullable
    public PocketmonTradeDto mapRow(ResultSet rs, int rowNum)
      throws SQLException {
      return PocketmonTradeDto
        .builder()
        .pocketmonTradeNo(rs.getInt("pocketmon_trade_no"))
        .allboardNo(rs.getInt("allboard_no"))
        .pocketmonTradeTitle(rs.getString("pocketmon_trade_title"))
        .pocketmonTradeWriter(rs.getString("pocketmon_trade_writer"))
        .pocketmonTradeWrittenTime(rs.getDate("pocketmon_trade_written_time"))
        .pocketmonTradeContent(rs.getString("pocketmon_trade_content"))
        .pocketmonTradeTradeTime(rs.getDate("pocketmon_trade_trade_time"))
        .pocketmonTradeComplete(
          rs.getInt("pocketmon_trade_complete") == 0 ? false : true
        )
        .pocketmonTradeRead(rs.getInt("pocketmon_trade_read"))
        .pocketmonTradeReply(rs.getInt("pocketmon_trade_reply"))
        .pocketmonTradeLike(rs.getInt("pocketmon_trade_like"))
        .build();
    }
  };

  // C
  private void insert(PocketmonTradeDto pocketmonTradeDto) {
    String sql =
      "insert into pocketmon_trade (trade_no, allboard_no, trade_title, trade_writer, trade_written_time, trade_content, trade_trade_time, trade_complete, trade_read, trade_reply, trade_like) values (pocketmon_trade_seq.nextval, )";
  }
  // R
  // R
  // U
  // D
}
