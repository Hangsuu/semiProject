package com.kh.poketdo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.BookmarkDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class BookmarkDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AllboardDao allboardDao;
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private RaidDao raidDao;
	
	//좋아요/좋아요 해제 입력 및 결과값 반환
	public boolean insert(BookmarkDto bookmarkDto) {
		String countSql = "select count(*) from bookmark where allboard_no=? and member_id=?";
		Object[] param = {bookmarkDto.getAllboardNo(), bookmarkDto.getMemberId()};
		int count = jdbcTemplate.queryForObject(countSql, int.class, param);
		
		if(count==1) {
			String deleteSql = "delete bookmark where allboard_no=? and member_id=?";
			jdbcTemplate.update(deleteSql, param);
			return false;
		}
		else {
			String insertSql = "insert into bookmark(allboard_no, member_id, bookmark_type) values(?,?,?)";
			Object[] param2 = {bookmarkDto.getAllboardNo(), bookmarkDto.getMemberId(), bookmarkDto.getBookmarkType()};
			jdbcTemplate.update(insertSql, param2);
			return true;
		}
	}
	//최초 좋아요 여부 판단
	public boolean isBookmark(BookmarkDto bookmarkDto) {
		String countSql = "select count(*) from bookmark where allboard_no=? and member_id=?";
		Object[] param = {bookmarkDto.getAllboardNo(), bookmarkDto.getMemberId()};
		return jdbcTemplate.queryForObject(countSql, int.class, param)==1;
	}
	
/*
	// 개수 카운트 메서드
	public int bookmarkCount(int allboardNo) {
		String sql = "select count(*) from bookmark where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	//좋아요 개수 입력 메서드
	public void bookmarkInsert(int allboardNo) {
		AllboardDto allboardDto = allboardDao.selectOne(allboardNo);
		int likeCount = bookmarkCount(allboardNo);
		String allboardType = allboardDto.getAllboardBoardType();
		switch(allboardType) {
			case "auction" : auctionDao.likeSet(allboardNo, likeCount);
			case "raid" : raidDao.likeSet(allboardNo, likeCount);
		}
	}
*/
}
