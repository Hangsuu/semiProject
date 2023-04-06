package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.BoardDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class BoardDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<BoardDto> mapper = new RowMapper<BoardDto>(){
		@Override
		public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setAllboardNo(rs.getInt("allboard_no"));
			boardDto.setBoardWriter(rs.getString("board_writer"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardContent(rs.getString("board_content"));
			boardDto.setBoardTime(rs.getDate("board_time"));
			boardDto.setBoardHead(rs.getString("board_head"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardReply(rs.getInt("board_reply"));
			return boardDto;
		}
	};
	
//	번호를 생성하면서 등록하는 방법
//	1. 시퀀스 번호를 듀얼 테이블을 사용하여 조회
//	2. 생성된 번호까지 설정한 DTO를 등록
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//게시글 생성
	public void insert(BoardDto boardDto) {
	    String sql = "INSERT INTO board "
	               + "(board_no, allboard_no, board_writer, board_title, board_content, board_time, board_head, board_read, board_like, board_reply) "
	               + "VALUES (?, ?, ?, ?, ?, SYSDATE, ?, 0, 0, 0)";
	    Object[] param = {
	    	boardDto.getBoardNo(),
	        boardDto.getBoardWriter(),
	        boardDto.getBoardTitle(),
	        boardDto.getBoardContent(),
	        boardDto.getBoardHead()
	    };
	    jdbcTemplate.update(sql, param); 
	}

	
	
	//게시글 수정
	public boolean update(BoardDto boardDto) {
		String sql = "update board "
						+ "set board_head= ?, board_title= ?, board_content= ? "
						+ "where board_no = ?";
		Object[] param = {
			boardDto.getBoardHead(), boardDto.getBoardTitle(),
			boardDto.getBoardContent(), boardDto.getBoardNo()
		};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	
	//게시글 삭제
	public boolean delete(int boardNo) {
		String sql = "delete board where board_no = ?";
		Object[] param = {boardNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//(답글 구현X) 전체 게시글 리스트 조회
	public List<BoardDto> selectList() {
//		String sql = "select * from board order by board_no desc";
		String sql = "select * from board";
		return jdbcTemplate.query(sql, mapper);
	}
	
	
	// 전체 게시글 리스트에서 특정 키워드로 조회
	public List<BoardDto> selectList(String column, String keyword) {
		String sql = "select * from board "
						+ "where instr(#1, ?) > 0";
		sql = sql.replace("#1", column);
		Object[] param = {keyword};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	
	// 인기 게시판 구현
	public List<BoardDto> hotselectList() {
		String sql = "select * from board where board_like >= 30";
		return jdbcTemplate.query(sql, mapper);
	}
		
		
	// 게시글 중 하나를 골라 상세보기
	public BoardDto selectOne(int boardNo) {
		String sql = "select * from board where board_no = ?";
		Object[] param = {boardNo};
		List<BoardDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
	//공지사항 조회하는 기능
	public List<BoardDto> selectNoticeList(int begin, int end){
		String sql = "select * from("
					+ "select rownum rn, TMP.* from ("
					+ "select * from board where board_head='공지' "
					+ "order by board_no desc"
					+ ")TMP"
					+ ") where rn between ? and ?";
		Object[] param = {begin, end};
		return jdbcTemplate.query(sql, mapper, param);
	}	
	
	// 페이징 적용된 조회 및 카운트 (게시글 총 개수)
	public int selectCount(PaginationVO vo) {
		if(vo.isSearch()) {//검색
			String sql = "select count(*) from board where instr(#1, ?) > 0";
			sql = sql.replace("#1", vo.getColumn());
			Object[] param = {vo.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, param);
		}
		else { //목록
			String sql = "select count(*) from board";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//조회수 증가
	public boolean updateReadCount(int allboardNo) {
		String sql = "update board set board_read=board_read+1 "
					+ "where allboard_no = ?";
		Object[] param = {allboardNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	// 좋아요 갯수 증가
	public void updateLikecount(int count, int allboardNo) {
		String sql = "update board set board_like = ? where allboard_no = ?";
		Object[] param = {count, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	
	// 댓글 갯수 갱신 기능
	public void updateReplycount(int count, int allboardNo) {
		String sql = "update board set board_like = ? where allboard_no = ?";
		Object[] param = {count, allboardNo};
		jdbcTemplate.update(sql, param);
	}
	
	//첨부파일을 추가하였을 때의 번호가 첨부파일 테이블의 번호에 묶는 기능
	public void connect(int boardNo, int attachmentNo) {
		String sql = "insert into board_attachment values(?, ?)";
		Object[] param = {boardNo, attachmentNo};
		jdbcTemplate.update(sql, param);
	}
}
