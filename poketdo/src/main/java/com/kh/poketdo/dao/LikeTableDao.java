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
  
  @Autowired
  private BoardWithImageDao boardWithImageDao;

  // 좋아요/좋아요 해제 입력 및 결과값 반환
//등록
	public void insert(LikeTableDto liketableDto) {
		String sql = "insert into like_table(member_id, allboard_no) values(?, ?)";
		Object[] param = {liketableDto.getMemberId(), liketableDto.getAllboardNo()};
		jdbcTemplate.update(sql, param);
	}
	
	//삭제
	public void delete(LikeTableDto liketableDto) {
		String sql = "delete like_table where member_id = ? and allboard_no = ?";
		Object[] param = {liketableDto.getMemberId(), liketableDto.getAllboardNo()};
		jdbcTemplate.update(sql, param);
	}
	
	//확인 - count
		public boolean check(LikeTableDto liketableDto) {
			String sql = "select count(*) from like_table where member_id = ? and allboard_no = ?";
			Object[] param = {liketableDto.getMemberId(), liketableDto.getAllboardNo()};
			int count = jdbcTemplate.queryForObject(sql, int.class, param);
			return count == 1;
		}

  // 최초 좋아요 여부 판단
  public boolean isLike(LikeTableDto liketableDto) {
    String countSql = "select count(*) from like_table where allboard_no=? and member_id=?";
    Object[] param = {
        liketableDto.getAllboardNo(),
        liketableDto.getMemberId(),
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
    case "board":
    	boardWithImageDao.likeSet(allboardNo, likeCount);
    	break;
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
