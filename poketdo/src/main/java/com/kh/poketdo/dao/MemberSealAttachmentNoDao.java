package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberSealAttachmentNoDto;

@Repository
public class MemberSealAttachmentNoDao {

    @Autowired
    private JdbcTemplate jdbctemplate;

    private RowMapper<MemberSealAttachmentNoDto> mapper = new RowMapper<MemberSealAttachmentNoDto>() {
        @Override
        @Nullable
        public MemberSealAttachmentNoDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MemberSealAttachmentNoDto.builder().memberId(rs.getString("member_id")).memberNick(rs.getString("member_nick")).attachmentNo(rs.getObject("attachment_no") == null ? null : rs.getInt("attachment_no")).build();
        }
    };
    
    // R 
    public MemberSealAttachmentNoDto selectOne(String memberId) {
        String sql = "select * from member_seal_attachmentno where member_id = ?";
        Object[] param = { memberId };
        List<MemberSealAttachmentNoDto> list = jdbctemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0); 
    }
    // R
    public MemberSealAttachmentNoDto selectOneByNick(String memberNick) {
        String sql = "select * from member_seal_attachmentno where member_nick = ?";
        Object[] param = { memberNick };
        List<MemberSealAttachmentNoDto> list = jdbctemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0); 
    }

    // R 
    public Integer selectOneSealAttachmentNo(String memberId){
        String sql = "select attachment_no from member_seal_attachmentno where member_id = ?";
        Object[] param = { memberId };
        return jdbctemplate.queryForObject(sql, Integer.class, param);
    }
    // R 
    public Integer selectOneSealAttachmentNoByNick(String memberNick){
        String sql = "select attachment_no from member_seal_attachmentno where member_nick = ?";
        Object[] param = { memberNick };
        return jdbctemplate.queryForObject(sql, Integer.class, param);
    }

    // R 
    public String getSealUrl(String memberId) {
        Integer sealAttachmentNo = selectOneSealAttachmentNo(memberId);
        if(sealAttachmentNo==null) return "https://via.placeholder.com/150x150?text=mainImg";
        else return "/attachment/download?attachmentNo="+sealAttachmentNo;
    }
    // R
    public String getSealUrlByNick(String memberNick) {
        Integer sealAttachmentNo = selectOneSealAttachmentNoByNick(memberNick);
        if(sealAttachmentNo==null) return "https://via.placeholder.com/150x150?text=mainImg";
        else return "/attachment/download?attachmentNo="+sealAttachmentNo;
    }
}
