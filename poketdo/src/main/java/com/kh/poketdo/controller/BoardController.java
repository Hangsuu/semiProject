package com.kh.poketdo.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.poketdo.dao.AllboardDao;
import com.kh.poketdo.dao.BoardWithImageDao;
import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.BoardWithImageDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardWithImageDao boardWithImageDao;
	
	@Autowired
	private AllboardDao allboardDao;
	
	// 게시판 사이트 구현
	@GetMapping("/list")
	public String list(@ModelAttribute("vo") PaginationVO vo,
			Model model, @RequestParam(required = false, defaultValue = "boardTitle") String column, 
			@RequestParam(required = true, defaultValue = "") String keyword) {
		// 게시글 전체 개수
		int totalCount = boardWithImageDao.selectCount(vo);
		vo.setCount(totalCount);
		
		if(keyword.equals("")) {//키워드가 없다면 -> 목록

		// 게시글
		List<BoardWithImageDto> list = boardWithImageDao.selectList();
		model.addAttribute("list", list);
		}
		else { //키워드가 있다면 -> 검색
			model.addAttribute("column", column);
			model.addAttribute("keyword", keyword);
			model.addAttribute("list", boardWithImageDao.selectList(column, keyword));
			
			//검색 완료 후 검색어 창 비우기
			model.addAttribute("keyword", keyword);
		}
		//검색 여부와 관계 없이 공지사항을 3개 조회해서 Model에 첨부
		//공지사항
		model.addAttribute("noticeList", boardWithImageDao.selectNoticeList(1, 3));
		return "/WEB-INF/views/board/list.jsp";
	}
	
	// 인기게시판 구현(추천 30이상)
	@GetMapping("/hot")
	public String hot(@ModelAttribute("vo") PaginationVO vo,
			Model model, @RequestParam(required = false, defaultValue = "boardTitle") String column, 
			@RequestParam(required = true, defaultValue = "") String keyword) {
		// 게시글 전체 개수
		int totalCount = boardWithImageDao.selectCount(vo);
		vo.setCount(totalCount);
		
		if(keyword.equals("")) {//키워드가 없다면 -> 목록

		// 게시글
		List<BoardWithImageDto> list = boardWithImageDao.hotSelectList();
		model.addAttribute("list", list);
		}
		else { //키워드가 있다면 -> 검색
			model.addAttribute("column", column);
			model.addAttribute("keyword", keyword);
			model.addAttribute("list", boardWithImageDao.selectList(column, keyword));
			
			//검색 완료 후 검색어 창 비우기
			model.addAttribute("keyword", keyword);
		}
		//검색 여부와 관계 없이 공지사항을 3개 조회해서 Model에 첨부
		//공지사항
		model.addAttribute("noticeList", boardWithImageDao.selectNoticeList(1, 3));
		return "/WEB-INF/views/board/hot.jsp";
	}

	
	// 게시글 작성 페이지 구현[GET]
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/board/write.jsp";
	}
	
	
	@PostMapping("/write")
	public String write(@ModelAttribute BoardWithImageDto boardWithImageDto,
	                    HttpSession session, RedirectAttributes attr) {
	    
		 //현재 로그인한 사용자의 memberId를 boardWithImageDto의 boardWriter에 설정
	    String memberId = (String)session.getAttribute("memberId");
	    boardWithImageDto.setBoardWriter(memberId);
	    
		// 게시글 번호 생성
	    int allboardNo = allboardDao.sequence();
	    int boardNo = boardWithImageDao.sequence();
	    
	    // BoardWithImageDto 객체에 번호 설정
	    boardWithImageDto.setAllboardNo(allboardNo);
	    boardWithImageDto.setBoardNo(boardNo);

	    // 게시글 생성
	    allboardDao.insert(AllboardDto.builder().allboardNo(allboardNo).allboardBoardType("board").allboardBoardNo(boardNo).build());
	    boardWithImageDao.insert(boardWithImageDto);

	    //상세 페이지로 redirect
	    attr.addAttribute("boardNo", boardNo);
	    attr.addAttribute("allboardNo", allboardNo);

	    return "redirect:detail";
	}


	
	
	// 게시글 수정 페이지 구현[GET]
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		model.addAttribute("boardDto", boardWithImageDao.selectOne(boardNo));
		
		return "/WEB-INF/views/board/edit.jsp";
	}
	
	
	// 게시글 수정 페이지 구현[POST]
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardWithImageDto boardWithImageDto,
			RedirectAttributes attr) {
		boardWithImageDao.update(boardWithImageDto);
		attr.addAttribute("boardNo", boardWithImageDto.getBoardNo());
		
		return "redirect:detail";
	}
	
	// 게시글 삭제 페이지 구현[GET]
	@GetMapping("/delete")
	public String delete(@RequestParam int boardNo) {
		boardWithImageDao.delete(boardNo);
		return "redirect:list";//상대경로
		//return "redirect:/board/list";//절대경로
	}
	
	
	// 관리자를 위한 전체 삭제 기능
	@PostMapping("/deleteAll")
	public String deleteAll(@RequestParam(value="boardNo") List<Integer> list) {
		for(int boardNo : list) {
			boardWithImageDao.delete(boardNo);
		}
	    // 예시: Board.deleteAllPosts();

	    return "redirect:/board/list";
	}

	
//	조회수 중복 방지 시나리오
//	1. 작성자 본인은 조회수 증가를 하지 않는다
//	2. 한 번 이상 본 글은 조회수 증가를 하지 않는다
//		(1) 세션에 현재 사용자가 읽은 글 번호를 저장해야 한다
//		(2) 새로운 글을 읽으려 할 때 현재 읽는 글 번호가 읽은 이력이 있는지 조회
//		(3) 읽은 적이 있으면 조회수 증가를 하지 않고 없으면 추가 후 조회수 증가
	
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo, 
						Model model, HttpSession session) {
		//사용자가 작성자인지 판정 후 JSP로 전달
		BoardWithImageDto boardWithImageDto = boardWithImageDao.selectOne(boardNo);
		String memberId = (String) session.getAttribute("memberId");
		
		boolean owner = boardWithImageDto.getBoardWriter() != null 
				&& boardWithImageDto.getBoardWriter().equals(memberId);
		model.addAttribute("owner", owner);
		
		//사용자가 관리자인지 판정 후 JSP로 전달
		String memberLevel = (String) session.getAttribute("memberLevel");
		boolean admin = memberLevel != null && memberLevel.equals("관리자");
		model.addAttribute("admin", admin);
		
		//조회수 증가
		if(!owner) {//내가 작성한 글이 아니라면(시나리오 1번)
					
			//시나리오 2번 진행
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(boardNo)) {//읽은 적이 없는가(기억에 없는가)
				boardWithImageDao.updateReadCount(boardNo);
				boardWithImageDto.setBoardRead(boardWithImageDto.getBoardRead()+1);//DTO 조회수 1증가
				memory.add(boardNo);//저장소에 추가(기억에 추가)
			}
			//System.out.println("memory = " + memory);
			session.setAttribute("memory", memory);//저장소 갱신
			
		}
		model.addAttribute("boardWithImageDto", boardWithImageDto);
		return "/WEB-INF/views/board/detail.jsp";
	}
	
}
