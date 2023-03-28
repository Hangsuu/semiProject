package com.kh.poketdo.dao;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.LikeTableDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LikeTableDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  @Autowired
  private AllboardDao allboardDao;

  @Autowired
  private AuctionDao auctionDao;

  @Autowired
  private PocketmonTradeDao pocketmonTradeDao;

  @Autowired
  private RaidDao raidDao;
	@Autowired
	private CombinationDao combinationDao;

  // 좋아요/좋아요 해제 입력 및 결과값 반환
  public boolean insert(LikeTableDto likeTableDto) {
    String countSql = "select count(*) from like_table where allboard_no=? and member_id=?";
    Object[] param = {
        likeTableDto.getAllboardNo(),
        likeTableDto.getMemberId(),
    };
    int count = jdbcTemplate.queryForObject(countSql, int.class, param);
    if (count == 1) {
      String deleteSql = "delete like_table where allboard_no=? and member_id=?";
      jdbcTemplate.update(deleteSql, param);
      likeInsert(likeTableDto.getAllboardNo());
      return false;
    } else {
      String insertSql = "insert into like_table(allboard_no, member_id) values(?,?)";
      jdbcTemplate.update(insertSql, param);
      likeInsert(likeTableDto.getAllboardNo());
      return true;
    }
  }

  // 최초 좋아요 여부 판단
  public boolean isLike(LikeTableDto likeTableDto) {
    String countSql = "select count(*) from like_table where allboard_no=? and member_id=?";
    Object[] param = {
        likeTableDto.getAllboardNo(),
        likeTableDto.getMemberId(),
    };
    return jdbcTemplate.queryForObject(countSql, int.class, param) == 1;
  }

  // 좋아요 개수 카운트 메서드
  public int likeCount(int allboardNo) {
    String sql = "select count(*) from like_table where allboard_no = ?";
    Object[] param = { allboardNo };
    return jdbcTemplate.queryForObject(sql, int.class, param);
  }

  // 좋아요 개수 입력 메서드
  public int likeInsert(int allboardNo) {
    AllboardDto allboardDto = allboardDao.selectOne(allboardNo);
    int likeCount = likeCount(allboardNo);
    String allboardType = allboardDto.getAllboardBoardType();
    // System.out.println(allboardType);
    switch (allboardType) {
      case "auction":
        auctionDao.likeSet(allboardNo, likeCount);
        break;
      case "raid":
        raidDao.likeSet(allboardNo, likeCount);
			case "combination" : combinationDao.likeSet(allboardNo, likeCount);
        break;
      case "pocketmon_trade":
        pocketmonTradeDao.likeSet(allboardNo, likeCount);
        break;
    }
    return likeCount;
  }
}
