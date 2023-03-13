package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberDto;

@Repository
public class MemberDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<MemberDto> mapper = new RowMapper<MemberDto>() {

        @Override
        @Nullable
        public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MemberDto.builder().memberId(rs.getString("member_id")).memberPw(rs.getString("member_pw"))
                    .memberNick(rs.getString("member_nick")).memberCode(rs.getString("member_code"))
                    .memberEmail(rs.getString("member_email")).memberLevel(rs.getString("member_level"))
                    .memberPoint(rs.getInt("member_point")).memberjoin(rs.getDate("member_join"))
                    .memberLogin(rs.getDate("member_login")).memberLoginCnt(rs.getInt("member_login_cnt"))
                    .memberDeadline(rs.getDate("member_deadline")).build();
        }

    };

    // C
    // ReadAll
    public List<MemberDto> selectAll() {
        String sql = "select * from member";
        return jdbcTemplate.query(sql, mapper);
    }

    // ReadByPK
    public MemberDto selectOne(String memberId) {
        String sql = "select * from member where member_id = ?";
        Object[] param = { memberId };
        List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }
    // U
    // D
}