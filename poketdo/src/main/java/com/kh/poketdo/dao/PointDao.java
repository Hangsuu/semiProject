package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.PointDto;
import com.kh.poketdo.vo.PocketPaginationVO;

@Repository
public class PointDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	
	private RowMapper<PointDto> mapper = new RowMapper<PointDto>() {

		@Override
		public PointDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			return PointDto.builder()
					.pointBoardWriter(rs.getString("point_board_writer"))
					.writerName(rs.getString("writer_name"))
					.pointBoardNo(rs.getInt("point_board_no"))
					.requestPoint(rs.getInt("request_point"))
					.pointBoardHead(rs.getInt("point_board_head"))
					.pointBoardTime(rs.getDate("point_board_time"))
					.build();
		}
	};
	//게시번호 시퀀스 생성
	public int sequence() {
		String sql ="select point_board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//포인트 요청 글 작성
	public void requestPointWrite (PointDto pointDto) {
		String sql = "insert into point_board ( "
				+ "point_board_writer, writer_name, point_board_no, "
				+ "request_point, point_board_head, point_board_time ) "
				+ "values(?, ?, ?, ?, ?, sysdate) ";
		Object[] param = {
				pointDto.getPointBoardWriter(),
				pointDto.getWriterName(),
				pointDto.getPointBoardNo(),
				pointDto.getRequestPoint(),
				pointDto.getPointBoardHead()
		};
		jdbcTemplate.update(sql, param);
	}
	
	//게시글 상세 조회
	public PointDto selectOne (int pointBoardNo) {
		String sql = "select*from point_board where point_board_no=?";
		Object [] param = {pointBoardNo};
		List<PointDto> list = jdbcTemplate.query(sql, mapper,param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//게시글 삭제
	public boolean delete(int pointBoardNo) {
		String sql = "delete point_board where point_board_no=?";
		Object[]param= {pointBoardNo};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	//게시글 확인 
	public boolean check(int pointBoardNo) {
		String sql = "update point_board set point_board_head = 1 where point_board_no=?";
		Object [] param = {pointBoardNo};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	
	//포인트 충전
	public boolean addPoint(int point, String memberId) {
		String sql="update member set member_point = member_point + ? where member_id = ?";
		Object [] param = {point, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	//포인트 차감
	public boolean subPoint( int point, String memberId) {
		String sql="update member set member_point = member_point - ? where member_id = ?";
		Object [] param = {point, memberId};
		return jdbcTemplate.update(sql,param)>0;
	}
	
	//페이징 적용된 조회 및 카운트
		public int selectCount(PocketPaginationVO vo) {
			
			if(vo.isSearch()) {
				String sql = "select count(*) from point_board where instr(#1,?)>0";
				sql = sql.replace("#1", vo.getColumn());
				Object[]param =  {vo.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, param);
				
			}
			else {
				String sql = "select count(*) from point_board";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
		
//		목록
		public List<PointDto> selectList(PocketPaginationVO vo){
			if(vo.isSearch()) {
				String sql="select*from( "
						+ "select rownum rn, TMP.*from ("
						+ " select * from point_board "
						+ " where instr(#1,?)>0"
						+ " order by point_board_no desc"
						+ " )TMP"
						+ ")where rn between ? and ?";
				sql=sql.replace("#1", vo.getColumn());
				Object[]param = {vo.getKeyword(), vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper, param);
			}
			else {
				String sql="select * from( "
						+ "select TMP.*, rownum RN from ( "
						+ "select * from point_board "
						+ " order by point_board_no desc "
						+ ") TMP ) "
						+ "where RN between ? and ? ";
				Object[]param = {vo.getBegin(), vo.getEnd()};
				return jdbcTemplate.query(sql, mapper, param);
			}
		}
	
}
