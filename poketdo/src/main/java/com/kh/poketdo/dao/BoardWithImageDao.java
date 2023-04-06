package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.BoardWithImageDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class BoardWithImageDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(BoardWithImageDto boardWithImageDto) {
	    // board 테이블에 데이터 추가를 위한 SQL
	    String sql = "insert into board ("
	        + "board_no, allboard_no, board_writer, board_title, board_content, board_time, board_head, board_read, board_like, board_reply"
	        + ") values ("
	        + "?, ?, ?, ?, ?, sysdate, ?, 0, 0, 0)";
	    Object[] param = {
	        boardWithImageDto.getBoardNo(),
	        boardWithImageDto.getAllboardNo(),
	        boardWithImageDto.getBoardWriter(),
	        boardWithImageDto.getBoardTitle(),
	        boardWithImageDto.getBoardContent(),
	        boardWithImageDto.getBoardHead()
	    };
	    
	    // jdbcTemplate을 사용하여 SQL 실행
	    jdbcTemplate.update(sql, param);
	}

	
	private RowMapper<BoardWithImageDto> mapper = new RowMapper<BoardWithImageDto>(){
		@Override
		public BoardWithImageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			BoardWithImageDto boardWithImageDto = new BoardWithImageDto();
			boardWithImageDto.setBoardNo(rs.getInt("board_no"));
			boardWithImageDto.setAllboardNo(rs.getInt("allboard_no"));
			boardWithImageDto.setBoardWriter(rs.getString("board_writer"));
			boardWithImageDto.setBoardTitle(rs.getString("board_title"));
			boardWithImageDto.setBoardContent(rs.getString("board_content"));
			boardWithImageDto.setBoardTime(rs.getDate("board_time"));
			boardWithImageDto.setBoardHead(rs.getString("board_head"));
			boardWithImageDto.setBoardRead(rs.getInt("board_read"));
			boardWithImageDto.setBoardLike(rs.getInt("board_like"));
			boardWithImageDto.setBoardReply(rs.getInt("board_reply"));
			return boardWithImageDto;
		}
	};
	
	//게시글 수정
		public boolean update(BoardWithImageDto boardWithImageDto) {
			String sql = "update board "
							+ "set board_head= ?, board_title= ?, board_content= ? "
							+ "where allboard_no = ?";
			Object[] param = {
				boardWithImageDto.getBoardHead(), boardWithImageDto.getBoardTitle(),
				boardWithImageDto.getBoardContent(), boardWithImageDto.getAllboardNo()
			};
			return jdbcTemplate.update(sql, param) > 0;
		}
		
		//게시글 삭제
		public boolean delete(int allboardNo) {
			String sql = "delete board where allboard_no = ?";
			Object[] param = {allboardNo};
			return jdbcTemplate.update(sql, param) > 0;
		}
		
		//(답글 구현X) 전체 게시글 리스트 조회
		public List<BoardWithImageDto> selectList() {
//			String sql = "select * from board order by board_no desc";
			String sql = "select * from board";
			return jdbcTemplate.query(sql, mapper);
		}
		
		
		// 전체 게시글 리스트에서 특정 키워드로 조회
		public List<BoardWithImageDto> selectList(String column, String keyword) {
			String sql = "select * from board "
							+ "where instr(#1, ?) > 0";
			sql = sql.replace("#1", column);
			Object[] param = {keyword};
			return jdbcTemplate.query(sql, mapper, param);
		}
		
		// 인기 게시판 구현
		public List<BoardWithImageDto> hotSelectList() {
			String sql = "select * from board where board_like >= 1";
			return jdbcTemplate.query(sql, mapper);
		}
		
		// 게시글 중 하나를 골라 상세보기
		public BoardWithImageDto selectOne(int allboardNo) {
			String sql = "select * from board where allboard_no = ?";
			Object[] param = {allboardNo};
			List<BoardWithImageDto> list = jdbcTemplate.query(sql, mapper, param);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//멤버아이디, 보드넘버로 allboardNo 검색
		public BoardWithImageDto selectAllboardNo (int boardNo, String memberId) {
			String sql ="select allboard_no from board where board_no=? and member_id=?";
			Object[] param = {boardNo, memberId};
			List<BoardWithImageDto> list = jdbcTemplate.query(sql, mapper,param);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//공지사항 조회하는 기능
		public List<BoardWithImageDto> selectNoticeList(int begin, int end){
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
		public void likeSet(int allboardNo, int likeCount) {
		    String sql = "update board set board_like = ? where allboard_no = ?";
		    Object[] param = {likeCount ,allboardNo};
		    jdbcTemplate.update(sql, param);
		}

		
		// 댓글 갯수 갱신 기능
		public void replySet(int allboardNo, int replyCount) {
		    String sql = "update board set board_reply = ? where allboard_no = ?";
		    Object[] param = {replyCount, allboardNo};
		    jdbcTemplate.update(sql, param);
		}

		
		//첨부파일을 추가하였을 때의 번호가 첨부파일 테이블의 번호에 묶는 기능
		public void connect(int allboardNo, int attachmentNo) {
			String sql = "insert into board_attachment values(?, ?)";
			Object[] param = {allboardNo, attachmentNo};
			jdbcTemplate.update(sql, param);
		}
		
}