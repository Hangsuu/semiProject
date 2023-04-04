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
					.auctionMainImg(rs.getInt("auction_main_img"))
					.auctionFinish(rs.getInt("auction_finish"))
					.build();
		}
	};
	public int sequence() {
		String sql = "select allboard_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int auctionSequence() {
		String sql = "select auction_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//등록(C)
	public void insert(AuctionDto dto) {
		String sql = "insert into auction(allboard_no, auction_no, auction_writer, auction_title, auction_content, "
				+ "auction_finish_time, auction_min_price, auction_max_price)"
				+ " values(?,?,?,?,?,?,?,?)";
		int auctionSeq = auctionSequence();
		dto.setAuctionNo(auctionSeq);
		if(dto.getAuctionMaxPrice()==null) dto.setAuctionMaxPrice(0);
		if(dto.getAuctionMinPrice()==null) dto.setAuctionMinPrice(0);
		Object[] param = {dto.getAllboardNo(), dto.getAuctionNo(), dto.getAuctionWriter(), dto.getAuctionTitle(), dto.getAuctionContent(), 
				dto.getAuctionFinishTime(),	dto.getAuctionMinPrice(), dto.getAuctionMaxPrice()};
		
		AllboardDto allboardDto = new AllboardDto();
		allboardDto.setAllboardNo(dto.getAllboardNo());
		allboardDto.setAllboardBoardType("auction");
		allboardDto.setAllboardBoardNo(auctionSeq);
		allboardDao.insert(allboardDto);
		
		jdbcTemplate.update(sql, param);
	}
	public void insertImg(int allboardNo, int auctionMainImg) {
		String sql = "update auction set auction_main_img=? where allboard_No=?";
		Object[] param = {auctionMainImg, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//읽기(R) 통합
	public List<AuctionDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from auction where instr(#1, ?)>0 #4 order by #2 #3"+
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
					"select * from auction #4 order by #2 #3"+
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
			String sql = "select count(*) from auction where instr(#1, ?)>0 #4";
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
			String sql = "select count(*) from auction #4";
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
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
	//종료 시간 얻기
	public long getFinishTime(int allboardNo) {
		String sql = "select auction_finish_time from auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, Date.class, param).getTime();
	}
	//최소 입찰금액 얻기
	public int getMinPrice(int allboardNo) {
		String sql = "select auction_min_price from auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	//최대 입찰금액 얻기
	public int getMaxPrice(int allboardNo) {
		String sql = "select auction_max_price from auction where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	//상위 입찰 시 최소 입찰금액 변경
	public void changeMinPrice(int auctionMinPrice, int allboardNo) {
		String sql = "update auction set auction_min_price=? where allboard_no=?";
		Object[] param = {auctionMinPrice, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	//수정(U)
	public boolean edit(AuctionDto auctionDto) {
		String sql = "update auction set auction_title=?, auction_content=?, auction_min_price=?, auction_max_price=? where allboard_no=?";
		Object[] param = {auctionDto.getAuctionTitle(), auctionDto.getAuctionContent(), 
				auctionDto.getAuctionMinPrice(), auctionDto.getAuctionMaxPrice(), auctionDto.getAllboardNo()};
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
	
	//북마크 읽기
	public List<AuctionDto> bookmarkList(PaginationVO vo, String memberId){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT A.* FROM auction A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? where instr(#1, ?)>0 order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {memberId, vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"SELECT A.* FROM auction A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? order by auction_no desc"+
					") tmp"+
					") WHERE rn BETWEEN ? AND ?";
			Object[] param = {memberId, vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}
	public int bookmarkCount(PaginationVO vo, String memberId) {
		if(vo.isSearch()) {
			String sql = "SELECT count(*) FROM auction A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=? where instr(#1, ?)>0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {memberId, vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "SELECT count(*) FROM auction A INNER JOIN bookmark B ON a.ALLBOARD_NO =b.allboard_no AND b.member_id=?";
			Object[] param = {memberId};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
	}
	//거래종료, 배송중일 때 상태 처리
	public boolean changeFinish(int allboardNo) {
		String sql = "update auction set auction_finish=2 where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param)==1;
	}
	public boolean changeDelivery(int allboardNo) {
		String sql = "update auction set auction_finish=1 where allboard_no=?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param)==1;
	}
}
