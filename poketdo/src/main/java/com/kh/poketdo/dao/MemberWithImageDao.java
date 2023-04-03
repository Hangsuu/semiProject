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
import com.kh.poketdo.vo.PaginationVO;
@Repository
public class MemberWithImageDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(MemberWithImageDto memberWithImageDto) {
		String sql="insert into member("
					+ "member_id, member_pw, member_nick, member_email, "
					+ "member_level, member_point, "
					+ "member_join, member_login, member_login_cnt, member_deadline, "
					+ "member_birth, member_seal_no"
					+ ") values ("
					+ "?,?,?,?,'일반회원',0,sysdate,?,0,sysdate,0,0"
					+ ")";
		Object[] param = {
				memberWithImageDto.getMemberId(), memberWithImageDto.getMemberPw(),
				memberWithImageDto.getMemberNick(), memberWithImageDto.getMemberEmail(),
				memberWithImageDto.getMemberLevel(), memberWithImageDto.getMemberPoint(),
				memberWithImageDto.getMemberJoin(), memberWithImageDto.getMemberLogin(),
				memberWithImageDto.getMemberLoginCnt(), memberWithImageDto.getMemberDeadline(),
				memberWithImageDto.getMemberBirth(), memberWithImageDto.getMemberSealNo()
		};
		jdbcTemplate.update(sql,param);
		
	}


	private RowMapper<MemberWithImageDto> mapper = new RowMapper<MemberWithImageDto>() {
        @Override
        public MemberWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MemberWithImageDto.builder()
                    .memberId(rs.getString("MEMBER_ID"))
                    .memberPw(rs.getString("MEMBER_PW"))
                    .memberNick(rs.getString("MEMBER_NICK"))
                    .memberBirth(rs.getString("MEMBER_BIRTH"))
                    .memberEmail(rs.getString("MEMBER_EMAIL"))
                    .memberLevel(rs.getString("MEMBER_LEVEL"))
                    .memberPoint(rs.getInt("MEMBER_POINT"))
                    .memberJoin(rs.getDate("MEMBER_JOIN"))
                    .memberLogin(rs.getDate("MEMBER_LOGIN"))
                    .memberLoginCnt(rs.getInt("MEMBER_LOGIN_CNT"))
                    .memberDeadline(rs.getDate("MEMBER_DEADLINE"))
                    .memberSealNo(rs.getInt("MEMBER_SEAL_NO"))
                    .build();
        }
    };

    // C
    // ReadAll
    public List<MemberWithImageDto> selectAll() {
        String sql = "SELECT * FROM MEMBER";
        return jdbcTemplate.query(sql, mapper);
    }

//	카운트 구하는 기능
	public int selectCount() {
		String sql = "select count(*) from member";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	// 페이징 적용된 조회 및 카운트 (게시글 총 개수)
			public int selectCount(PaginationVO vo) {
				if(vo.isSearch()) {//검색
					String sql = "select count(*) from member where instr(#1, ?) > 0";
					sql = sql.replace("#1", vo.getColumn());
					Object[] param = {vo.getKeyword()};
					return jdbcTemplate.queryForObject(sql, int.class, param);
				}
				else { //목록
					String sql = "select count(*) from member";
					return jdbcTemplate.queryForObject(sql, int.class);
				}
			}	
			
			// 전체 게시글 리스트에서 특정 키워드로 조회
			public List<MemberWithImageDto> selectList(String column, String keyword) {
				String sql = "select * from member "
								+ "where instr(#1, ?) > 0";
				sql = sql.replace("#1", column);
				Object[] param = {keyword};
				return jdbcTemplate.query(sql, mapper, param);
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

