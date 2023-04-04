package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AuctionBidDto;
import com.kh.poketdo.dto.AuctionBidWithNickDto;

@Repository
public class AuctionBidWithNickDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<AuctionBidWithNickDto> mapper = new RowMapper<AuctionBidWithNickDto>() {
		@Override
		public AuctionBidWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return AuctionBidWithNickDto.builder()
					.auctionBidNo(rs.getInt("auction_bid_no"))
					.auctionBidOrigin(rs.getInt("auction_bid_origin"))
					.auctionBidMember(rs.getString("auction_bid_member"))
					.auctionBidPrice(rs.getInt("auction_bid_price"))
					.auctionBidTime(rs.getDate("auction_bid_time"))
					.memberNick(rs.getString("member_nick"))
					.attachmentNo(rs.getInt("attachment_no"))
					.build();
		}
	};
	
	public List<AuctionBidWithNickDto> selectList(int allboardNo) {
		String sql ="select * from auction_bid_with_nick where auction_bid_origin=? order by auction_bid_price desc";
		return jdbcTemplate.query(sql, mapper, allboardNo);
	}
	
	public AuctionBidWithNickDto selectOne(int auctionBidNo) {
		String sql = "select * from auction_bid_with_nick where auction_bid_no=?";
		Object[] param = {auctionBidNo};
		List<AuctionBidWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	
	//마지막 입찰 정보
	public AuctionBidWithNickDto lastBid(int allboardNo) {
		List<AuctionBidWithNickDto> list = selectList(allboardNo);
		return list.isEmpty()? null:list.get(0);
	}
}
