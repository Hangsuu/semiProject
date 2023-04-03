package com.kh.poketdo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.ReplyWithNickDto;

@Repository
public class ReplyWithNickDao {
	  @Autowired
	  private JdbcTemplate jdbcTemplate;

	  RowMapper<ReplyWithNickDto> mapper = (rs, index) -> {
	    return ReplyWithNickDto
	        .builder()
	        .replyNo(rs.getInt("reply_no"))
	        .replyWriter(rs.getString("reply_writer"))
	        .replyOrigin(rs.getInt("reply_origin"))
	        .replyContent(rs.getString("reply_content"))
	        .replyTime(rs.getDate("reply_time"))
	        .replyGroup(rs.getInt("reply_group"))
	        .replyLike(rs.getInt("reply_like"))
	        .memberNick(rs.getString("member_nick"))
	        .attachmentNo(rs.getInt("attachment_no"))
	        .build();
	  };
	  
	  public List<ReplyWithNickDto> selectList(int replyOrigin) {
		    String sql = "SELECT * FROM reply_with_nick where reply_origin=? CONNECT BY PRIOR reply_no = COALESCE(reply_group, 0) START WITH COALESCE(reply_group, 0) = 0 order siblings by reply_no ASC";
		    Object[] param = { replyOrigin };
		    return jdbcTemplate.query(sql, mapper, param);
		  }
	  public List<ReplyWithNickDto> selectLikeList(int replyOrigin){
		  String sql="SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from reply_with_nick where reply_origin=? and reply_like!=0 order by reply_like desc, reply_no asc"+
					") tmp"+
					") WHERE rn BETWEEN 1 AND 3";
		  Object[] param= {replyOrigin};
		  return jdbcTemplate.query(sql, mapper, param);
	  }
	  public ReplyWithNickDto selectOne(int replyNo) {
		    String sql = "select * from reply_with_nick where reply_no=?";
		    Object[] param = { replyNo };
		    List<ReplyWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		    return list.isEmpty() ? null : list.get(0);
	  }

	  public int replyWithNickCount(int replyOrigin) {
		String sql = "select count(*) from (SELECT * FROM reply_with_nick where reply_origin=? CONNECT BY PRIOR reply_no = COALESCE(reply_group, 0) START WITH COALESCE(reply_group, 0) = 0 order siblings by reply_no ASC)";
		Object[] param = { replyOrigin };
		return jdbcTemplate.queryForObject(sql, int.class, param);
	  }
}
