package com.kh.poketdo.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.AuctionDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class AuctionDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AllboardDao allboardDao;
	
	private RowMapper<AuctionDto> mapper = new RowMapper<AuctionDto>() {
		@Override
		public AuctionDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return AuctionDto.builder()
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
					.build();
		}
	};
	public int sequence() {
		String sql = "select allboard_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//등록(C)
	public void insert(AuctionDto dto) {
		String sql = "insert into auction(allboard_no, auction_no, auction_writer, auction_title, auction_content, "
				+ "auction_finish_time, auction_min_price, auction_max_price)"
				+ " values(?,auction_seq.nextval,?,?,?,?,?,?)";
		Object[] param = {dto.getAllboardNo(), dto.getAuctionWriter(), dto.getAuctionTitle(), dto.getAuctionContent(), 
				dto.getAuctionFinishTime(),	dto.getAuctionMinPrice(), dto.getAuctionMaxPrice()};
		jdbcTemplate.update(sql, param);
		
		AllboardDto allboardDto = new AllboardDto();
		allboardDto.setAllboardNo(dto.getAllboardNo());
		allboardDto.setAllboardBoardType("auction");
		allboardDto.setAllboardBoardNo(selectOne(dto.getAllboardNo()).getAuctionNo());
		allboardDao.insert(allboardDto);
	}
	//읽기(R) 통합
	public List<AuctionDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from auction where instr(#1, ?)>0 order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from auction order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {
			String sql = "select count(*) from auction where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from auction";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	public AuctionDto selectOne(int allboardNo) {
		String sql = "select * from auction where allboard_no=?";
		Object[] param = {allboardNo};
		List<AuctionDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	public void readCount(int allboardNo) {
		String sql = "update auction set auction_read=auction_read+1 where allboard_no=?";
		Object[] param = {allboardNo};
		jdbcTemplate.update(sql, param);
	}
	public void changeFinishTime(Date date, int allboardNo) {
		String sql="UPDATE auction SET auction_finish_time=? WHERE allboard_no=?";
		Object[] param = {date, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	public int getMinPrice(int allboardNo) {
		String sql = "select auction_min_price from auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	public int getMaxPrice(int allboardNo) {
		String sql = "select auction_max_price from auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	public void changeMinPrice(int auctionMinPrice, int allboardNo) {
		String sql = "update auction set auction_min_price=? where allboard_no=?";
		Object[] param = {auctionMinPrice, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//수정(U)
	public boolean edit(AuctionDto auctionDto) {
		String sql = "update auction set auction_title=?, auction_content=? where allboard_no=?";
		Object[] param = {auctionDto.getAuctionTitle(), auctionDto.getAuctionContent(), auctionDto.getAllboardNo()};
		return jdbcTemplate.update(sql, param)>0;
	}
	//삭제(D)
	public boolean delete(int allboardNo){
		String sql = "delete auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param)>0;
	}
	//댓글 갯수 반영
	public void replySet(int allboardNo, int replyCount) {
		String sql = "update auction set auction_reply=? where allboard_no=?";
		Object[] param = {replyCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//좋아요 갯수 반영
	public void likeSet(int allboardNo, int likeCount) {
		String sql = "update auction set auction_like=? where allboard_no=?";
		Object[] param = {likeCount, allboardNo};
		jdbcTemplate.update(sql, param);
	}
}
