package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberDto;

@Repository
public class MemberDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    
	public void insert(MemberDto memberDto) {
		String sql="insert into member("
					+ "member_id, member_pw, member_nick, member_birth, "
					+ "member_email, member_level, "
					+ "member_point, member_join, member_deadline"
					+ ") values ("
					+ "?,?,?,?,?,'일반회원', 0, sysdate, sysdate"
					+ ")";
		Object[] param = {
				memberDto.getMemberId(), memberDto.getMemberPw(),
				memberDto.getMemberNick(), memberDto.getMemberBirth(), 
				memberDto.getMemberEmail(), memberDto.getMemberLevel(),
				memberDto.getMemberPoint(), memberDto.getMemberDeadline()
		};
		jdbcTemplate.update(sql,param);
		
	}


    private RowMapper<MemberDto> mapper = new RowMapper<MemberDto>() {

        @Override
        @Nullable
        public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MemberDto.builder()
            		.memberId(rs.getString("member_id"))
            		.memberPw(rs.getString("member_pw"))
                    .memberNick(rs.getString("member_nick"))
                    .memberBirth(rs.getString("member_birth"))
                    .memberEmail(rs.getString("member_email"))
                    .memberLevel(rs.getString("member_level"))
                    .memberPoint(rs.getInt("member_point"))
                    .memberjoin(rs.getDate("member_join"))
                    .memberLogin(rs.getDate("member_login"))
                    .memberLoginCnt(rs.getInt("member_login_cnt"))
                    .memberDeadline(rs.getDate("member_deadline"))
                    .build();
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
        Object[] param = {memberId};
        List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }
    // U
    
    public boolean changeInformation(MemberDto memberDto) {
    	String sql = "update member set "
    			+ "member_nick=?, "
    			+ "member_birth=? "
    			+ "where member_id=?";
    	Object[] param = {
    			memberDto.getMemberNick(),
    			memberDto.getMemberBirth()
    	};
    	return jdbcTemplate.update(sql, param)>0;
    
    }
    
    
    // D
    public boolean delete(String memberId) {
    	String sql = "delete member where member_id=?";
    	Object[] param = {memberId};
    	return jdbcTemplate.update(sql, param)>0;
    }


    //이메일로 아이디찾기
    public String findId(MemberDto memberDto) {
    	String sql = "select member_id from member "
    			+ "where member_email=?";
    	Object[] param = {
    			memberDto.getMemberEmail()
    	};
    	return jdbcTemplate.queryForObject(sql, String.class, param);
    }
    

}
