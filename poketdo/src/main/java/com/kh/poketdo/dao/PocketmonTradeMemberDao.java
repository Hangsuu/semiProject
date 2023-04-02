package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PocketmonTradeMemberDto;
import com.kh.poketdo.vo.PocketmonTradePageVO;

@Repository
public class PocketmonTradeMemberDao {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<PocketmonTradeMemberDto> mapper = new RowMapper<PocketmonTradeMemberDto>() {
        @Override
        @Nullable
        public PocketmonTradeMemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return PocketmonTradeMemberDto
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
            .memberNick(rs.getString("member_nick"))
            .attachmentNo(rs.getObject("attachment_no")==null?0:rs.getInt("attachment_no"))
            .build();
        }
    };

    // C
    // R 포켓몬교환 + 멤버 게시물 리스트
    public List<PocketmonTradeMemberDto> selectList(PocketmonTradePageVO pageVo) {
        String sql;
        Object[] param;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade_member order by pocketmon_trade_no desc) tmp) where rn between ? and ?";
            // param = new Object[] { pageVo.getBegin(), pageVo.getEnd() };
            param = new Object[] { 1, 10 };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade_member where instr(#1, ?) > 0 order by pocketmon_trade_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                pageVo.getKeyword(),
                pageVo.getBegin(),
                pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 포켓몬교환 + 멤버 공지 리스트
    public List<PocketmonTradeMemberDto> selectNotice() {
        String sql = "select * from (select rownum rn, tmp.* from (select * from pocketmon_trade_member where pocketmon_trade_head = '공지' order by pocketmon_trade_no desc) tmp) where rn between 1 and 3";
        return jdbcTemplate.query(sql, mapper);
    }

    // U
    // D
}
