package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MessageWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class MessageWithNickDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<MessageWithNickDto> mapper = new RowMapper<MessageWithNickDto>() {
        @Override
        @Nullable
        public MessageWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MessageWithNickDto
                    .builder()
                    .messageNo(rs.getInt("message_no"))
                    .messageRecipient(rs.getString("message_recipient"))
                    .messageSender(rs.getString("message_sender"))
                    .messageTitle(rs.getString("message_title"))
                    .messageContent(rs.getString("message_content"))
                    .messageSendTime(rs.getDate("message_send_time"))
                    .messageReadTime(rs.getDate("message_read_time"))
                    .messageSenderStore(rs.getInt("message_sender_store"))
                    .messageRecipientStore(rs.getInt("message_recipient_store"))
                    .messageSenderNick(rs.getString("message_sender_nick"))
                    .messageRecipientNick(rs.getString("message_recipient_nick"))
                    .build();
        }
    };

    // R 받은메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectReceiveMessage(PaginationVO pageVo, String memberId) {
        String sql;
        Object[] param;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 order by message_no desc) tmp) where rn between ? and ?";
            param = new Object[] { memberId, pageVo.getBegin(), pageVo.getEnd() };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and instr(#1, ?) > 0 order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    memberId,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 보낸메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectSendMessage(PaginationVO pageVo, String memberId) {
        String sql;
        Object[] param;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_sender = ? and message_sender_store = 1 order by message_no desc) tmp) where rn between ? and ?";
            param = new Object[] { memberId, pageVo.getBegin(), pageVo.getEnd() };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_sender = ? and message_sender_store = 1 and instr(#1, ?) > 0 order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    memberId,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 안 읽은 받은메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectReceiveNRMessage(PaginationVO pageVo, String memberId) {
        String sql;
        Object[] param;
        if (pageVo.getKeyword().equals("")) {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and message_read_time is null order by message_no desc) tmp) where rn between ? and ?";
            param = new Object[] { memberId, pageVo.getBegin(), pageVo.getEnd() };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and instr(#1, ?) > 0 and message_read_time is null order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    memberId,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 받은 메세지 + 닉네임 가져오기
    public MessageWithNickDto selectReceiveMessage(int messageNo, String memberId) {
        String sql = "select * from message_with_nick where message_no = ? and message_recipient = ?";
        Object[] param = { messageNo, memberId };
        List<MessageWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }

    // R 보낸 메세지 + 닉네임 가져오기
    public MessageWithNickDto selectSendMessage(int messageNo, String memberId) {
        String sql = "select * from message_with_nick where message_no = ? and message_sender = ?";
        Object[] param = { messageNo, memberId };
        List<MessageWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }

    // R 받은메세지 카운트 세기
    public int getReceiveCount(PaginationVO pageVo, String memberId) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ?";
            Object[] param = { memberId };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and instr(#1, ?) > 0";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { memberId, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

    // R 안 읽은 받은메세지 카운트 세기
    public int getReceiveNRCount(PaginationVO pageVo, String memberId) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and message_read_time is null";
            Object[] param = { memberId };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and instr(#1, ?) > 0 and message_read_time is null";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { memberId, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

    // R 보낸메세지 카운트 세기
    public int getSendCount(PaginationVO pageVo, String memberId) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_sender_store = 1 and message_sender = ?";
            Object[] param = { memberId };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_sender_store = 1 and message_sender = ? and instr(#1, ?) > 0";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { memberId, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

}
