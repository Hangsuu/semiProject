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
  private PocketmonTradeDao pocketmonTradeDao;
  @Autowired
  private ReplyWithNickDao replyWithNickDao;

  RowMapper<ReplyDto> mapper = (rs, index) -> {
    return ReplyDto
        .builder()
        .replyNo(rs.getInt("reply_no"))
        .replyWriter(rs.getString("reply_writer"))
        .replyOrigin(rs.getInt("reply_origin"))
        .replyContent(rs.getString("reply_content"))
        .replyTime(rs.getDate("reply_time"))
        .replyGroup(rs.getInt("reply_group"))
        .replyLike(rs.getInt("reply_like"))
        .build();
  };

  public void insert(ReplyDto replyDto) {
    String sql = "insert into reply(reply_no, reply_writer, reply_origin, reply_time," +
        "reply_content, reply_group) values(reply_seq.nextval,?,?,sysdate,?,?)";
    Object[] param = {
        replyDto.getReplyWriter(),
        replyDto.getReplyOrigin(),
        replyDto.getReplyContent(),
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
  public List<ReplyDto> selectLikeList(int replyOrigin){
	  String sql="SELECT * FROM ("+
				"SELECT tmp.*, rownum rn FROM ("+
				"select * from reply where reply_origin=? and reply_like!=0 order by reply_like desc, reply_no asc"+
				") tmp"+
				") WHERE rn BETWEEN 1 AND 3";
	  Object[] param= {replyOrigin};
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
    int replyCount = replyWithNickDao.replyWithNickCount(allboardNo);
    System.out.println(replyCount);
    String allboardType = allboardDto.getAllboardBoardType();
    switch (allboardType) {
      case "auction":
        auctionDao.replySet(allboardNo, replyCount);
      case "raid":
        raidDao.replySet(allboardNo, replyCount);
      case "combination" : 
    	  combinationDao.replySet(allboardNo, replyCount);
      case "pocketmon_trade" :
        pocketmonTradeDao.replySet(allboardNo, replyCount);
    }
  }

  public int sequence() {
    String sql = "select reply_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }
  
  //좋아요 개수 입력
  public void likeSet(int replyNo, int likeCount) {
	  String sql = "update reply set reply_like=? where reply_no=?";
	  Object[] param = {likeCount, replyNo};
	  jdbcTemplate.update(sql, param);
  }

  // 댓글 계층(LEVEL) 구하기
  public int getLevel(int replyNo) {
    String sql = "SELECT LEVEL - 1 AS LEVEL_COUNT FROM reply WHERE reply_no = ? CONNECT BY reply_group = PRIOR reply_no START WITH reply_group = 0";
    Object[] param = {replyNo};
    return jdbcTemplate.queryForObject(sql, int.class, param);
  }
}
