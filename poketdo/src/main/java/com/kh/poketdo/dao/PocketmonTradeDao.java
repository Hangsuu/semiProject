package com.kh.poketdo.dao;

import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.vo.PaginationVO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
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
        .pocketmonTradeComplete(rs.getInt("pocketmon_trade_complete"))
        .pocketmonTradeRead(rs.getInt("pocketmon_trade_read"))
        .pocketmonTradeReply(rs.getInt("pocketmon_trade_reply"))
        .pocketmonTradeLike(rs.getInt("pocketmon_trade_like"))
        .build();
    }
  };

  // 포켓몬 교환 sequence 생성
  public int sequence() {
    String sql = "select pocketmon_trade_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }

  // C 포켓몬 교환 게시물 생성
  public void insert(PocketmonTradeDto pocketmonTradeDto) {
    String sql =
      "insert into pocketmon_trade (pocketmon_trade_no, allboard_no, pocketmon_trade_title, pocketmon_trade_writer, pocketmon_trade_written_time, pocketmon_trade_content, pocketmon_trade_trade_time, pocketmon_trade_complete, pocketmon_trade_read, pocketmon_trade_reply, pocketmon_trade_like) values (?, ?, ?, ?, sysdate, ?, ?, 0, 0, 0, 0)";
    Object[] param = {
      pocketmonTradeDto.getPocketmonTradeNo(),
      pocketmonTradeDto.getAllboardNo(),
      pocketmonTradeDto.getPocketmonTradeTitle(),
      pocketmonTradeDto.getPocketmonTradeWriter(),
      pocketmonTradeDto.getPocketmonTradeContent(),
      pocketmonTradeDto.getPocketmonTradeTradeTime(),
      // new Timestamp(pocketmonTradeDto.getPocketmonTradeTradeTime().getTime()),
    };
    jdbcTemplate.update(sql, param);
  }

  // R 포켓몬교환 게시물 리스트
  public List<PocketmonTradeDto> selectList(PaginationVO pageVo) {
    String sql;
    Object[] param;
    if (pageVo.getKeyword().equals("")) {
      sql =
        "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade order by pocketmon_trade_no asc) tmp) where rn between ? and ?";
      param = new Object[] { pageVo.getBegin(), pageVo.getEnd() };
    } else {
      sql =
        "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade where instr(#1, ?) > 0 order by pocketmon_trade_no asc) tmp) where rn between ? and ?";
      sql = sql.replace("#1", pageVo.getColumn());
      param =
        new Object[] {
          pageVo.getKeyword(),
          pageVo.getBegin(),
          pageVo.getEnd(),
        };
    }
    return jdbcTemplate.query(sql, mapper, param);
  }

  // R 포켓몬교환 게시물 상세
  public PocketmonTradeDto selectOne(int pocketmonTradeNo) {
    String sql = "select * from pocketmon_trade where pocketmon_trade_no = ?";
    Object[] param = { pocketmonTradeNo };
    List<PocketmonTradeDto> list = jdbcTemplate.query(sql, mapper, param);
    return list.isEmpty() ? null : list.get(0);
  }

  // R 포켓몬교환 게시물 Cnt
  public int getCount(PaginationVO pageVo) {
    String sql;
    int cnt;
    if (pageVo.getKeyword().equals("")) {
      sql = "select count(*) from pocketmon_trade";
      cnt = jdbcTemplate.queryForObject(sql, int.class);
    } else {
      sql = "select count(*) from pocketmon_trade where instr(#1, ?) > 0";
      sql = sql.replace("#1", pageVo.getColumn());
      Object[] param = { pageVo.getKeyword() };
      cnt = jdbcTemplate.queryForObject(sql, int.class, param);
    }
    return cnt;
  }
  // U
  // D
}
