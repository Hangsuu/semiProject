package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.MemberJoinSealDto;

@Repository
public class MemberJoinSealDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	//조회를 위한 RowMapper 생성
	private RowMapper<MemberJoinSealDto> mapper = new RowMapper<MemberJoinSealDto>() {
		@Override
		public MemberJoinSealDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return MemberJoinSealDto.builder()
					.mySealNo(rs.getInt("my_seal_no"))
					.memberJoinId(rs.getString("member_join_id"))
					.sealJoinNo(rs.getInt("seal_join_no"))
					.build();
		}
	}; 
	
	//memberId, sealNo 입력
	public void insert (String memberId, int sealNo) {
		String sql ="insert into member_join_seal (my_seal_no , member_join_id, seal_join_no) values (member_join_seal_seq.nextval,?,?)";
		Object [] param = {memberId, sealNo};
		jdbcTemplate.update(sql, param);
	}
	//memberId, sealNo 입력
	public void delete (int sealNo) {
		String sql ="delete member_join_seal where my_seal_no=?";
		Object [] param = {sealNo};
		jdbcTemplate.update(sql, param);
	}
	
    //회원가입 시 기본 멤버인장 등록
    public void basicSealInsert (String memberId) {
    	String sql = "insert into member_join_seal (my_seal_no, member_join_id, seal_join_no) "
    			+ "values(member_join_seal_seq.nextval, ? , 0)";
    	Object [] param = {memberId};
    	jdbcTemplate.update(sql,param);
    }

	//회원 아이디와 인장번호로 나의 인장번호 조회
    public String mySealNoSelect (String memberId) {
    	String sql ="select my_seal_no from member_join_seal where member_join_id=? and seal_join_no=0";
    	Object [] param = {memberId};
    	return jdbcTemplate.queryForObject(sql, String.class, param);
    }

	
}
