package com.kh.poketdo.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.component.RandomComponent;
import com.kh.poketdo.dto.MemberDto;

@Repository
public class MemberDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    
	public void insert(MemberDto memberDto) {
		String sql="insert into member("
					+ "member_id, member_pw, member_nick, member_birth, "
					+ "member_email, member_level, "
					+ "member_point, member_join, member_seal_no"
					+ ") values ("
					+ "?,?,?,?,?,'일반회원', 0, sysdate, 0"
					+ ")";
		Object[] param = {
				memberDto.getMemberId(), memberDto.getMemberPw(),
				memberDto.getMemberNick(), memberDto.getMemberBirth(), 
				memberDto.getMemberEmail()
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
                    .memberJoin(rs.getDate("member_join"))
                    .memberLogin(rs.getDate("member_login"))
                    .memberLoginCnt(rs.getInt("member_login_cnt"))
                    .memberSealNo(rs.getInt("member_seal_no"))
                    .build();
        }

    };

    // C
    // ReadAll
    public List<MemberDto> selectAll() {
        String sql = "select * from member";
        return jdbcTemplate.query(sql, mapper);
    }

//	카운트 구하는 기능
	public int selectCount() {
		String sql = "select count(*) from member";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
// 페이지 번호
	public List<MemberDto> selectListPaging(int page, int size){
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
    			+ "member_birth=?, "
    			+ "member_email=? "
    			+ "where member_id=?";
    	Object[] param = {
    			memberDto.getMemberNick(),
    			memberDto.getMemberBirth(),
    			memberDto.getMemberEmail(),
    			memberDto.getMemberId()
    	};
    	return jdbcTemplate.update(sql, param)>0;
    
    }
    
    
    // D 회원탈퇴
    public boolean delete(String memberId) {
    	String sql = "delete member where member_id=?";
    	Object[] param = {memberId};
    	return jdbcTemplate.update(sql, param)>0;
    }

	//selectSealNo 입력(나의 인장 이미지 선택)
	public boolean insertMemberSealNo (int selectSealNo, String memberId) {
		String sql ="update member set member_seal_no=? where member_id = ? ";
		Object [] param = {selectSealNo, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	//회원가입 시 나의 인장이미지 기본이미지 선택
	public boolean insertMemberBasicSeal (int selectSealNo, String memberId) {
		String sql ="update member set member_seal_no=? where member_id = ? ";
		Object [] param = {selectSealNo, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	//memberSealNo 조회
	public String selectMemberSealNo (String memberId) {
		String sql ="select member_seal_no from member where member_id = ?";
		Object [] param = {memberId};
		return jdbcTemplate.queryForObject(sql, String.class, param);
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

    
    @Autowired
    private RandomComponent rc;
    //아이디,이메일로 비밀번호 받기
    public String updatePassword(MemberDto memberDto) {
        // 새로운 패스워드 생성
        String newPassword = rc.generateString(10);
        
        // 데이터베이스 업데이트
        String sql = "UPDATE member SET member_pw = ? WHERE member_id = ? AND member_email = ?";
        Object[] params = {newPassword, memberDto.getMemberId(), memberDto.getMemberEmail()};
        int rowsAffected = jdbcTemplate.update(sql, params);
        if (rowsAffected > 0) {
            return newPassword;
        } else {
            return null;
        }
    }
    
    
  //비밀번호 변경 기능
  		public boolean changePassword(String memberId, String memberPw) {
  			String sql = "update member set member_pw = ? where member_id = ?";
  			Object[] param = {memberPw, memberId};
  			return jdbcTemplate.update(sql, param) > 0;
  		}
    
    
    
    
    public MemberDto selectByNickname(String memberNick) {
    	String sql = "select * from member where member_nick = ?";
    	Object[] param = {memberNick};
    	List<MemberDto> list = jdbcTemplate.query(sql, mapper, param);
    	return list.isEmpty() ? null : list.get(0);
    }
    
    public int selectMemberPoint (String memberId) {
    	String sql ="select member_point from member where member_id = ?";
    	Object [] param = {memberId};
    	return jdbcTemplate.queryForObject(sql, int.class,param);
    }


	
    
}