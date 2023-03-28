package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberWithImageDto;
@Repository
public class MemberWithImageDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(MemberWithImageDto memberWithImageDto) {
		String sql="insert into member("
					+ "member_id, member_pw, member_nick, member_birth, "
					+ "member_email, member_level, "
					+ "member_point, member_join, member_deadline"
					+ ") values ("
					+ "?,?,?,?,?,'일반회원', 0, sysdate, sysdate"
					+ ")";
		Object[] param = {
				memberWithImageDto.getMemberId(), memberWithImageDto.getMemberPw(),
				memberWithImageDto.getMemberNick(), memberWithImageDto.getMemberBirth(), 
				memberWithImageDto.getMemberEmail(), memberWithImageDto.getMemberLevel(),
				memberWithImageDto.getMemberPoint(), memberWithImageDto.getMemberDeadline()
		};
		jdbcTemplate.update(sql,param);
		
	}


    private RowMapper<MemberWithImageDto> mapper = new RowMapper<MemberWithImageDto>() {

        @Override
        @Nullable
        public MemberWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MemberWithImageDto.builder()
            		.memberId(rs.getString("member_id"))
            		.memberPw(rs.getString("member_pw"))
                    .memberNick(rs.getString("member_nick"))
                    .memberBirth(rs.getDate("member_birth"))
                    .memberEmail(rs.getString("member_email"))
                    .memberLevel(rs.getString("member_level"))
                    .memberPoint(rs.getInt("member_point"))
                    .memberJoin(rs.getDate("member_join"))
                    .memberLogin(rs.getDate("member_login"))
                    .memberLoginCnt(rs.getInt("member_login_cnt"))
                    .memberDeadline(rs.getDate("member_deadline"))
                    .build();
        }

    };

    // C
    // ReadAll
    public List<MemberWithImageDto> selectAll() {
        String sql = "select * from member";
        return jdbcTemplate.query(sql, mapper);
    }

//	카운트 구하는 기능
	public int selectCount() {
		String sql = "select count(*) from member";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
// 페이지 번호
	public List<MemberWithImageDto> selectListPaging(int page, int size){
		int end = page * size;
		int begin = end - (size-1);
		String sql = "select * from ("
				+ "select TMP.*, rownum RN from ("
				+ "select * from member order by member_id asc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		Object[] param = {page, size};
		return jdbcTemplate.query(sql, mapper ,param);
	}
    
    // ReadByPK
    public MemberWithImageDto selectOne(String memberId) {
        String sql = "select * from member where member_id = ?";
        Object[] param = {memberId};
        List<MemberWithImageDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }
    // U
    
    public boolean changeInformation(MemberWithImageDto memberDto) {
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

	//관리자용 회원정보 변경
    public boolean changeInformationByAdmin(MemberWithImageDto memberWithImageDto) {
    	String sql =  "update member set "
    				+ "member_nick=?, member_email=?, member_level=?, "
    				+ "member_point=? "
    				+ "where member_id = ?";
    	Object[] param = {memberWithImageDto.getMemberNick(),memberWithImageDto.getMemberEmail(),
    			memberWithImageDto.getMemberLevel(),memberWithImageDto.getMemberPoint(),
    			memberWithImageDto.getMemberId()
    	};
    	return jdbcTemplate.update(sql, param) > 0;
    }
    
    
    
}

