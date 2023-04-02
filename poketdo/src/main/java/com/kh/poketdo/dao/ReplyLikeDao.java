package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.LikeTableDto;
import com.kh.poketdo.dto.ReplyLikeDto;

@Repository
public class ReplyLikeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReplyDao replyDao;
	
	  // 좋아요/좋아요 해제 입력 및 결과값 반환
	  public boolean insert(ReplyLikeDto replyLikeDto) {
	    String countSql = "select count(*) from reply_like where reply_no=? and member_id=?";
	    Object[] param = {
	        replyLikeDto.getReplyNo(),
	        replyLikeDto.getMemberId()
	    };
	    int count = jdbcTemplate.queryForObject(countSql, int.class, param);
	    if (count == 1) {
	      String deleteSql = "delete reply_like where reply_no=? and member_id=?";
	      jdbcTemplate.update(deleteSql, param);
	      likeInsert(replyLikeDto.getReplyNo());
	      return false;
	    } 
	    else {
	      String insertSql = "insert into reply_like(reply_no, member_id) values(?,?)";
	      jdbcTemplate.update(insertSql, param);
	      likeInsert(replyLikeDto.getReplyNo());
	      return true;
	    }
	  }

	  // 최초 좋아요 여부 판단
	  public boolean isLike(ReplyLikeDto replyLikeDto) {
	    String countSql = "select count(*) from reply_like where reply_no=? and member_id=?";
	    Object[] param = {
	        replyLikeDto.getReplyNo(),
	        replyLikeDto.getMemberId()
	    };
	    return jdbcTemplate.queryForObject(countSql, int.class, param) == 1;
	  }

	  // 좋아요 개수 카운트 메서드
	  public int likeCount(int replyNo) {
	    String sql = "select count(*) from reply_like where reply_no = ?";
	    Object[] param = { replyNo };
	    return jdbcTemplate.queryForObject(sql, int.class, param);
	  }

	  // 좋아요 개수 입력 메서드
	  public int likeInsert(int replyNo) {
	    int likeCount = likeCount(replyNo);
	    replyDao.likeSet(replyNo, likeCount);
	    return likeCount;
	  }
}
