package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AuctionWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class AuctionWithNickDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<AuctionWithNickDto> mapper = new RowMapper<AuctionWithNickDto>() {
		@Override
		public AuctionWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return AuctionWithNickDto.builder()
					.allboardNo(rs.getInt("allboard_no"))
					.auctionNo(rs.getInt("auction_no"))
					.auctionWriter(rs.getString("auction_writer"))
					.auctionTitle(rs.getString("auction_title"))
					.auctionContent(rs.getString("auction_content"))
					.auctionTime(rs.getDate("auction_time"))
					.auctionFinishTime(rs.getDate("auction_finish_time"))
					.auctionMinPrice(rs.getInt("auction_min_price"))
					.auctionMaxPrice(rs.getInt("auction_max_price"))
					.auctionLike(rs.getInt("auction_like"))
					.auctionDislike(rs.getInt("auction_dislike"))
					.auctionReply(rs.getInt("auction_reply"))
					.auctionRead(rs.getInt("auction_read"))
					.auctionMainImg(rs.getInt("auction_main_img"))
					.auctionFinish(rs.getInt("auction_finish"))
					.memberNick(rs.getString("member_nick"))
					.attachmentNo(rs.getInt("attachment_no"))
					.auctionBidCount(rs.getInt("auction_bid_count"))
					.build();
		}
	};
	
	//읽기(R) 통합
	public List<AuctionWithNickDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from auction_with_nick where instr(#1, ?)>0 #4 order by #2 #3"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			sql = sql.replace("#2", vo.getItem());
			sql = sql.replace("#3", vo.getOrder());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "and "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from auction_with_nick #4 order by #2 #3"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#2", vo.getItem());
			sql = sql.replace("#3", vo.getOrder());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from auction_with_nick where instr(#1, ?)>0 #4";
			sql = sql.replace("#1", vo.getColumn());
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "and "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from auction_with_nick #4";
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public AuctionWithNickDto selectOne(int allboardNo) {
		String sql = "select * from auction_with_nick where allboard_no=?";
		Object[] param = {allboardNo};
		List<AuctionWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	
	//북마크 읽기
	public List<AuctionWithNickDto> bookmarkList(PaginationVO vo, String memberId){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT A.* FROM auction_with_nick A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? where instr(#1, ?)>0 order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {memberId, vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT A.* FROM auction_with_nick A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {memberId, vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int bookmarkCount(PaginationVO vo, String memberId) {
		if(vo.isSearch()) {
			String sql = "SELECT count(*) FROM auction_with_nick A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {memberId, vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "SELECT count(*) FROM auction_with_nick A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=?";
			Object[] param = {memberId};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
	}
}
