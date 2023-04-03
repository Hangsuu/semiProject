package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AuctionBidDto;

@Repository
public class AuctionBidDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<AuctionBidDto> mapper = new RowMapper<AuctionBidDto>() {
		@Override
		public AuctionBidDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return AuctionBidDto.builder()
					.auctionBidNo(rs.getInt("auction_bid_no"))
					.auctionBidOrigin(rs.getInt("auction_bid_origin"))
					.auctionBidMember(rs.getString("auction_bid_member"))
					.auctionBidPrice(rs.getInt("auction_bid_price"))
					.auctionBidTime(rs.getDate("auction_bid_time")).build();
		}
	};
	public int sequence() {
		String sql = "select auction_bid_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(AuctionBidDto dto) {
		String sql="insert into auction_bid(auction_bid_no, auction_bid_origin, "
				+ "auction_bid_member, auction_bid_price) values(?,?,?,?)";
		Object[] param = {dto.getAuctionBidNo(), dto.getAuctionBidOrigin(), dto.getAuctionBidMember(),
				dto.getAuctionBidPrice()};
		jdbcTemplate.update(sql, param);
	}
	public List<AuctionBidDto> selectList(int allboardNo) {
		String sql ="select * from auction_bid where auction_bid_origin=? order by auction_bid_price desc";
		return jdbcTemplate.query(sql, mapper, allboardNo);
	}
	public int maxPrice(int seqNo) {
		String sql = "select max(auction_bid_price) from auction_bid where auction_bid_origin=?";
		Object[] param = {seqNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	//마지막 입찰 정보
	public AuctionBidDto lastBid(int allboardNo) {
		List<AuctionBidDto> list = selectList(allboardNo);
		return list.isEmpty()? null:list.get(0);
	}
}
