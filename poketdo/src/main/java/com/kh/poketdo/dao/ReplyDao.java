package com.kh.poketdo.dao;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.ReplyDto;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  @Autowired
  private AllboardDao allboardDao;

  @Autowired
  private AuctionDao auctionDao;

  @Autowired
  private RaidDao raidDao;
  
  @Autowired
  private CombinationDao combinationDao;
  
  @Autowired
  private BoardWithImageDao boardWithImageDao;

  RowMapper<ReplyDto> mapper = (rs, index) -> {
    return ReplyDto
        .builder()
        .replyNo(rs.getInt("reply_no"))
        .replyWriter(rs.getString("reply_writer"))
        .replyOrigin(rs.getInt("reply_origin"))
        .replyContent(rs.getString("reply_content"))
        .replyTime(rs.getDate("reply_time"))
        .replyGroup(rs.getInt("reply_group"))
        .build();
  };

  public void insert(ReplyDto replyDto) {
    String sql = "insert into reply(reply_no, reply_origin, reply_writer," +
        "reply_content, reply_time ,reply_group) values(reply_seq.nextval,?,?,?,sysdate,?)";
    Object[] param = {
        replyDto.getReplyWriter(),
        replyDto.getReplyOrigin(),
        replyDto.getReplyWriter(),
        replyDto.getReplyContent(),
        replyDto.getReplyTime(),
        replyDto.getReplyGroup(),
    };
    jdbcTemplate.update(sql, param);

    // 게시글의 리플라이 개수를 판단해서 DB 입력
    int allboardNo = replyDto.getReplyOrigin();
    replyInsert(allboardNo);
  }

  public List<ReplyDto> selectList(int replyOrigin) {
    String sql = "SELECT * FROM reply where reply_origin=? CONNECT BY PRIOR reply_no = COALESCE(reply_group, 0) START WITH COALESCE(reply_group, 0) = 0 order siblings by reply_no ASC";
    Object[] param = { replyOrigin };
    return jdbcTemplate.query(sql, mapper, param);
  }

  public void update(ReplyDto replyDto) {
    String sql = "update reply set reply_content=? where reply_no=?";
    Object[] param = { replyDto.getReplyContent(), replyDto.getReplyNo() };
    jdbcTemplate.update(sql, param);
  }

  public void delete(int replyNo) {
    String sql = "delete reply where reply_no=?";
    Object[] param = { replyNo };

    // 게시글의 리플라이 개수를 판단해서 DB 입력
    int allboardNo = selectOne(replyNo).getReplyOrigin();

    jdbcTemplate.update(sql, param);
    replyInsert(allboardNo);
  }

  public ReplyDto selectOne(int replyNo) {
    String sql = "select * from reply where reply_no=?";
    Object[] param = { replyNo };
    List<ReplyDto> list = jdbcTemplate.query(sql, mapper, param);
    return list.isEmpty() ? null : list.get(0);
  }

  // 댓글 갯수 카운트 메서드
  public int replyCount(int allboardNo) {
    String sql = "select count(*) from reply where reply_origin=?";
    Object[] param = { allboardNo };
    return jdbcTemplate.queryForObject(sql, int.class, param);
  }

  // 댓글 갯수 입력 메서드
  public void replyInsert(int allboardNo) {
    AllboardDto allboardDto = allboardDao.selectOne(allboardNo);
    int replyCount = replyCount(allboardNo);
    String allboardType = allboardDto.getAllboardBoardType();
    switch (allboardType) {
      case "board":
    	boardWithImageDao.replySet(allboardNo, replyCount);
      case "auction":
        auctionDao.replySet(allboardNo, replyCount);
      case "raid":
        raidDao.replySet(allboardNo, replyCount);
      case "combination" : 
    	combinationDao.replySet(allboardNo, replyCount);
    }
  }

  // 댓글 시퀀스
  public int sequence() {
    String sql = "select reply_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }
  
  // 답글 메서드
  public void updateReplyGroup(int originId, int replyGroup) {
	  String sql = "update reply set reply_group = ? where reply_origin = ?";
	  Object[] param = {originId, replyGroup};
	  jdbcTemplate.update(sql, param);
  }
}
