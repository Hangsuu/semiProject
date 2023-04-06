package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PointDto;
import com.kh.poketdo.dto.PointNameImageDto;
import com.kh.poketdo.vo.PocketPaginationVO;

@Repository
public class PointNameImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<PointNameImageDto> mapper = new RowMapper<PointNameImageDto>() {

		@Override
		public PointNameImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PointNameImageDto
					.builder()
					.pointBoardWriter(rs.getString("point_board_writer"))
					.writerName(rs.getString("writer_name"))
					.memberNick(rs.getString("member_nick"))
					.pointBoardNo(rs.getInt("point_board_no"))
					.pointBoardHead(rs.getInt("point_board_head"))
					.requestPoint(rs.getInt("request_point"))
					.attachmentNo(rs.getInt("attachment_no"))
					.pointBoardTime(rs.getDate("point_board_time"))
					.build();
		}
	};

	//페이징 적용된 조회 및 카운트
	public int selectCount(PocketPaginationVO vo) {
		
		if(vo.isSearch()) {
			String sql = "select count(*) from point_name_image where "+vo.getColumn()+"=? ";
			Object[]param =  {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else {
			String sql = "select count(*) from point_name_image";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
//	목록
	public List<PointNameImageDto> selectList(PocketPaginationVO vo){
		if(vo.isSearch()) {
			String sql="select*from( "
					+ " select rownum rn, TMP.*from ( "
					+ " select * from point_name_image "
					+ " where "+vo.getColumn()+"=? "
					+ " order by point_board_no desc "
					+ " )TMP"
					+ " )where rn between ? and ?";
			Object[]param = { vo.getKeyword(), vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
		else {
			String sql="select * from( "
					+ " select TMP.*, rownum RN from ( "
					+ " select * from point_name_image "
					+ " order by point_board_no desc "
					+ " ) TMP ) "
					+ " where RN between ? and ? ";
			Object[]param = {vo.getBegin(), vo.getEnd()};
			return jdbcTemplate.query(sql, mapper, param);
		}
	}

	
}
