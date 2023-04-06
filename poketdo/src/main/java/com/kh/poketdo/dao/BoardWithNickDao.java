package com.kh.poketdo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.poketdo.dto.BoardWithImageDto;
import com.kh.poketdo.dto.BoardWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Repository
public class BoardWithNickDao {
	 @Autowired
	    private JdbcTemplate jdbcTemplate;
	 
	 public void insert(BoardWithNickDto boardWithNickDto) {
		    // board 테이블에 데이터 추가를 위한 SQL
		    String sql = "insert into board ("
		        + "board_no, allboard_no, board_writer, board_title, board_content, board_time, board_head, board_read, board_like, board_reply"
		        + ") values ("
		        + "?, ?, ?, ?, ?, sysdate, ?, 0, 0, 0)";
		    Object[] param = {
		        boardWithNickDto.getBoardNo(),
		        boardWithNickDto.getAllboardNo(),
		        boardWithNickDto.getBoardWriter(),
		        boardWithNickDto.getBoardTitle(),
		        boardWithNickDto.getBoardContent(),
		        boardWithNickDto.getBoardHead()
		    };
		    
		    // jdbcTemplate을 사용하여 SQL 실행
		    jdbcTemplate.update(sql, param);
		}

	    private RowMapper<BoardWithNickDto> mapper = new RowMapper<BoardWithNickDto>() {
	        @Override
	        public BoardWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	            return BoardWithNickDto.builder()
	                    .allboardNo(rs.getInt("allboard_no"))
	                    .boardNo(rs.getInt("board_no"))
	                    .boardWriter(rs.getString("board_writer"))
	                    .boardTitle(rs.getString("board_title"))
	                    .boardContent(rs.getString("board_content"))
	                    .boardTime(rs.getDate("board_time"))
	                    .boardHead(rs.getString("board_Head"))
	                    .boardLike(rs.getInt("board_like"))
	                    .boardReply(rs.getInt("board_reply"))
	                    .boardRead(rs.getInt("board_read"))
	                    .memberNick(rs.getString("member_nick"))
	                    .attachmentNo(rs.getInt("attachment_no"))
	                    .build();
	        }
	    };
	    
	//읽기(R) 통합
	public List<BoardWithNickDto> selectList(PaginationVO vo){
		if(vo.isSearch()) {
			String sql = "SELECT * FROM ("+
					"SELECT tmp.*, rownum rn FROM ("+
					"select * from board_name_image where instr(#1, ?)>0 #4 order by #2 #3"+
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
					"select * from board_name_image #4 order by #2 #3"+
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
			String sql = "select count(*) from board_name_image where instr(#1, ?)>0 #4";
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
			String sql = "select count(*) from board_name_image #4";
			if(vo.getSpecial().length()>0) {
				sql = sql.replace("#4", "where "+vo.getSpecial());
			}
			else {
				sql = sql.replace("#4", vo.getSpecial());
			}
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public BoardWithNickDto selectOne(int allboardNo) {
		String sql = "select * from board_name_image where allboard_no=?";
		Object[] param = {allboardNo};
		List<BoardWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty()? null : list.get(0);
	}
	
	//공지사항 조회하는 기능
			public List<BoardWithNickDto> selectNoticeList(int begin, int end){
				String sql = "select * from("
							+ "select rownum rn, TMP.* from ("
							+ "select * from board_name_image where board_head='공지' "
							+ "order by board_no desc"
							+ ")TMP"
							+ ") where rn between ? and ?";
				Object[] param = {begin, end};
				return jdbcTemplate.query(sql, mapper, param);
			}	
			
			// 인기 게시판 구현
			public List<BoardWithNickDto> selectHotList() {
				String sql = "select * from board_name_image where board_like >= 1";
				return jdbcTemplate.query(sql, mapper);
			}
			
			//(답글 구현X) 전체 게시글 리스트 조회
			public List<BoardWithNickDto> selectList() {
//				String sql = "select * from board order by board_no desc";
				String sql = "select * from board_name_image";
				return jdbcTemplate.query(sql, mapper);
			}
			
			// 
			public List<BoardWithNickDto> selectHotList(PaginationVO vo){
				if(vo.isSearch()) {
					String sql = "SELECT * FROM ("+
							"SELECT tmp.*, rownum rn FROM ("+
							"select * from board_name_image where instr(#1, ?)>0 #4 "+
							"and board_like >= 1 "+
							"order by #2 #3"+
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
							"select * from board_name_image #4 "+
							"where board_like >= 1 "+
							"order by #2 #3"+
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
			public int selectHotCount(PaginationVO vo) {
				if(vo.isSearch()) {
					String sql = "select count(*) from board_name_image where instr(#1, ?)>0 #4 "+
								 "and board_like >= 1";
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
					String sql = "select count(*) from board_name_image #4 "+
								 "where board_like >= 1";
					if(vo.getSpecial().length()>0) {
						sql = sql.replace("#4", "where "+vo.getSpecial());
					}
					else {
						sql = sql.replace("#4", vo.getSpecial());
					}
					return jdbcTemplate.queryForObject(sql, int.class);
				}
			}
			
}
