package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.poketdo.dto.PocketmonTradeDto;
import com.kh.poketdo.vo.PaginationVO;

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
          .pocketmonTradeHead(rs.getString("pocketmon_trade_head"))
          .pocketmonTradeTradeTime(rs.getDate("pocketmon_trade_trade_time"))
          .pocketmonTradeComplete(rs.getInt("pocketmon_trade_complete"))
          .pocketmonTradeRead(rs.getInt("pocketmon_trade_read"))
          .pocketmonTradeReply(rs.getInt("pocketmon_trade_reply"))
          .pocketmonTradeLike(rs.getInt("pocketmon_trade_like"))
          .pocketmonTradeIsblocked(rs.getInt("pocketmon_trade_isblocked"))
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
    String sql = "insert into pocketmon_trade (pocketmon_trade_no, allboard_no, pocketmon_trade_title, pocketmon_trade_writer, pocketmon_trade_written_time, pocketmon_trade_content, pocketmon_trade_head, pocketmon_trade_trade_time, pocketmon_trade_complete, pocketmon_trade_read, pocketmon_trade_reply, pocketmon_trade_like, pocketmon_trade_isblocked) values (?, ?, ?, ?, sysdate, ?, ?, ?, 0, 0, 0, 0, 0)";
    Object[] param = {
        pocketmonTradeDto.getPocketmonTradeNo(),
        pocketmonTradeDto.getAllboardNo(),
        pocketmonTradeDto.getPocketmonTradeTitle(),
        pocketmonTradeDto.getPocketmonTradeWriter(),
        pocketmonTradeDto.getPocketmonTradeContent(),
        pocketmonTradeDto.getPocketmonTradeHead(),
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
      sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade order by pocketmon_trade_no desc) tmp) where rn between ? and ?";
      param = new Object[] { pageVo.getBegin(), pageVo.getEnd() };
    } else {
      sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade where instr(#1, ?) > 0 order by pocketmon_trade_no desc) tmp) where rn between ? and ?";
      sql = sql.replace("#1", pageVo.getColumn());
      param = new Object[] {
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

  // R 포켓몬교환 공지
  public List<PocketmonTradeDto> selectNotice() {
    String sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade where pocketmon_trade_head = '공지' order by pocketmon_trade_no desc) tmp) where rn between 1 and 3";
    return jdbcTemplate.query(sql, mapper);
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

  // U 포켓몬교환 게시물 수정
  public boolean update(PocketmonTradeDto pocketmonTradeDto) {
    String sql = "update pocketmon_trade set pocketmon_trade_head = ?, pocketmon_trade_title = ?, pocketmon_trade_content = ?, pocketmon_trade_trade_time = ? where pocketmon_trade_no = ?";
    Object[] param = {
        pocketmonTradeDto.getPocketmonTradeHead(),
        pocketmonTradeDto.getPocketmonTradeTitle(),
        pocketmonTradeDto.getPocketmonTradeContent(),
        pocketmonTradeDto.getPocketmonTradeTradeTime(),
        pocketmonTradeDto.getPocketmonTradeNo(),
    };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // U 포켓몬교환 게시물 좋아요 수정
  public boolean likeSet(int allboardNo, int likeCount) {
    String sql = "update pocketmon_trade set pocketmon_trade_like = ? where allboard_no = ?";
    Object[] param = { likeCount, allboardNo };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // U 포켓몬교환 게시물 댓글 수정
  public boolean replySet(int allboardNo, int replyCount) {
    String sql = "update pocketmon_trade set pocketmon_trade_reply = ? where allboard_no = ?";
    Object[] param = { replyCount, allboardNo };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // U 포켓몬교환 게시물 조회수 수정
  public boolean readSet(int pocketmonTradeNo) {
    String sql = "update pocketmon_trade set pocketmon_trade_read = pocketmon_trade_read + 1 where pocketmon_trade_no = ?";
    Object[] param = { pocketmonTradeNo };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // D 포켓몬교환 게시물 삭제
  public boolean delete(int pocketmonTradeNo) {
    String sql = "delete from pocketmon_trade where pocketmon_trade_No = ?";
    Object[] param = { pocketmonTradeNo };
    return jdbcTemplate.update(sql, param) > 0;
  }
}
