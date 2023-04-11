package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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
	
	
	//나의 인장목록에 추가
	public void insert (String memberId, int sealNo) {
		String sql ="insert into member_join_seal (my_seal_no , member_join_id, seal_join_no) values (member_join_seal_seq.nextval,?,?)";
		Object [] param = {memberId, sealNo};
		jdbcTemplate.update(sql, param);
	}
	//삭제
	public void delete (int sealNo) {
		String sql ="delete member_join_seal where my_seal_no=?";
		Object [] param = {sealNo};
		jdbcTemplate.update(sql, param);
	}
	
	//멤버아이디로 기본 인장 번호 조회
	public MemberJoinSealDto selectOne(String memberId) {
		String sql ="select*from member_join_seal where member_join_id=? and seal_join_no=0";
		Object[] param = {memberId};
		List<MemberJoinSealDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
    //회원가입 시 기본 멤버인장 등록
    public void basicSealInsert (String memberId) {
    	String sql = "insert into member_join_seal (my_seal_no, member_join_id, seal_join_no) "
    			+ "values(member_join_seal_seq.nextval, ? , 0)";
    	Object [] param = {memberId};
    	jdbcTemplate.update(sql,param);
    }

	

	
}
