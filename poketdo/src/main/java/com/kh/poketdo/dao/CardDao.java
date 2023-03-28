package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.CardDto;

@Repository
public class CardDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    
	public void insert(CardDto cardDto) {
		String sql="insert into card("
					+ "card_no, attachment_no, card_nick, card_nation, card_server, "
					+ "card_slot1, card_slot2, card_slot3, card_slot4, card_slot5, card_slot6, "
					+ "card_comment1, card_comment2"
					+ ") values ("
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?"
					+ ")";
		Object[] param = {
				cardDto.getCardNo(), cardDto.getAttachmentNo(),
				cardDto.getCardNick(), cardDto.getCardNation(), cardDto.getCardServer(),
				cardDto.getCardSlot1(), cardDto.getCardSlot2(), cardDto.getCardSlot3(),
				cardDto.getCardSlot4(), cardDto.getCardSlot5(), cardDto.getCardSlot6(),
				cardDto.getCardComment1(), cardDto.getCardComment2()
		};
		jdbcTemplate.update(sql,param);
		
	}


    private RowMapper<CardDto> mapper = new RowMapper<CardDto>() {

        @Override
        @Nullable
        public CardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return CardDto.builder()
            		.cardNo(rs.getInt("card_no"))
            		.attachmentNo(rs.getInt("attachment_no"))
                    .cardNick(rs.getString("card_nick"))
                    .cardNation(rs.getString("card_nation"))
                    .cardServer(rs.getString("card_server"))
                    .cardSlot1(rs.getInt("card_slot1"))
                    .cardSlot2(rs.getInt("card_slot2"))
                    .cardSlot3(rs.getInt("card_slot3"))
                    .cardSlot4(rs.getInt("card_slot4"))
                    .cardSlot5(rs.getInt("card_slot5"))
                    .cardSlot6(rs.getInt("card_slot6"))    
                    .cardComment1(rs.getString("card_comment1"))
                    .cardComment2(rs.getString("card_comment2"))
                    .build();
        }

    };
	
	
}
