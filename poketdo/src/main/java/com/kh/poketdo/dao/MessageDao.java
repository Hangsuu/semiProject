package com.kh.poketdo.dao;

import com.kh.poketdo.dto.MessageDto;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<MessageDto> mapper = new RowMapper<MessageDto>() {
    @Override
    @Nullable
    public MessageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
      return MessageDto
        .builder()
        .messageNo(rs.getInt("message_no"))
        .messageRecipient(rs.getString("message_recipient"))
        .messageSender(rs.getString("message_sender"))
        .messageTitle(rs.getString("message_title"))
        .messageContent(rs.getString("message_content"))
        .messageSendTime(rs.getDate("message_send_time"))
        .messageReceiveTime(rs.getDate("message_receive_time"))
        .messageSenderStore(rs.getInt("message_sender_store"))
        .messageReceiverStore(rs.getInt("message_receiver_store"))
        .build();
    }
  };

  // 메세지 시퀀스 생성
  public int sequence() {
    String sql = "select message_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }

  // C 메세지 생성
  public void insert(MessageDto messageDto) {
    String sql =
      "insert into message (message_no, message_recipient, message_sender, message_title, message_content, message_send_time, message_sender_store, message_receiver_store) values (?, ?, ?, ?, ?, sysdate, 1, 1)";
    Object[] param = {
      messageDto.getMessageNo(),
      messageDto.getMessageRecipient(),
      messageDto.getMessageSender(),
      messageDto.getMessageTitle(),
      messageDto.getMessageContent(),
      messageDto.getMessageReceiveTime(),
    };
    jdbcTemplate.update(sql, param);
  }

  // R 받은 메시지리스트 부르기
  public List<MessageDto> selectList(String messageRecipient) {
    String sql =
      "select * from message where message_recipient = ? and message_receiver_store = 1";
    Object[] param = { messageRecipient };
    return jdbcTemplate.query(sql, mapper, param);
  }
  // R
  // U
  // D
}
