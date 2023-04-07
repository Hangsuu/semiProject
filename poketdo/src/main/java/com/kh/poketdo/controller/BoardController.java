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
import com.kh.poketdo.dao.BoardDao;
import com.kh.poketdo.dao.BoardWithImageDao;
import com.kh.poketdo.dao.BoardWithNickDao;
import com.kh.poketdo.dao.MemberSealAttachmentNoDao;
import com.kh.poketdo.dto.AllboardDto;
import com.kh.poketdo.dto.BoardDto;
import com.kh.poketdo.dto.BoardWithImageDto;
import com.kh.poketdo.dto.BoardWithNickDto;
import com.kh.poketdo.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardWithNickDao boardWithNickDao;
	
	@Autowired
	private AllboardDao allboardDao;

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private BoardWithImageDao boardWithImageDao;
	
	@Autowired
	private MemberSealAttachmentNoDao memberSealAttachmentNoDao;

	@GetMapping("/list")
	public String list(Model model, 
			@ModelAttribute("vo") PaginationVO vo) {
		//목록의 숫자 계산 후 VO count에 입력
		vo.setCount(boardWithNickDao.selectCount(vo));
		
		model.addAttribute("list", boardWithNickDao.selectList());
		model.addAttribute("list", boardWithNickDao.selectList(vo));
		model.addAttribute("noticeList", boardWithNickDao.selectNoticeList(1,3));
		return "/WEB-INF/views/board/list.jsp";
	}
	
	// 인기게시판 구현(추천 30이상)
	@GetMapping("/hot")
	public String hot(@ModelAttribute("vo") PaginationVO vo,
	Model model) {
	// 게시글 전체 개수
	vo.setCount(boardWithNickDao.selectHotCount(vo));
	// 게시글
	model.addAttribute("hot", boardWithNickDao.selectHotList(vo));
	// 현재 페이지 정보
	model.addAttribute("pagination", vo);
	// 검색 여부와 관계 없이 공지사항을 3개 조회해서 Model에 첨부
	// 공지사항
	model.addAttribute("noticeList", boardWithNickDao.selectNoticeList(1, 3));
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
	    boardWithImageDto.setBoardNo(boardNo);
	    boardWithImageDao.insert(boardWithImageDto);

	    //상세 페이지로 redirect
	    attr.addAttribute("boardNo", boardNo);
	    // attr.addAttribute("allboardNo", allboardNo);

	    return "redirect:detail";
	}
	
	
	// 게시글 수정 페이지 구현[GET]
		@GetMapping("/edit")
		public String edit(@RequestParam int allboardNo, Model model) {
			model.addAttribute("boardWithImageDto", boardWithImageDao.selectOne(allboardNo));
			
			return "/WEB-INF/views/board/edit.jsp";
		}
		// 게시글 수정 페이지 구현[POST]
		@PostMapping("/edit")
		public String edit(@ModelAttribute BoardWithImageDto boardWithImageDto,
				RedirectAttributes attr) {
			boardWithImageDao.update(boardWithImageDto);
			attr.addAttribute("allboardNo", boardWithImageDto.getBoardNo());
			
			return "redirect:detail";
		}
	
	// 게시글 삭제 페이지 구현[GET]
	@GetMapping("/delete")
	public String delete(@RequestParam int allboardNo) {
		boardWithImageDao.delete(allboardNo);
		return "redirect:list";//상대경로
		//return "redirect:/board/list";//절대경로
	}
	
	
	// 관리자를 위한 전체 삭제 기능
	@PostMapping("/deleteAll")
	public String deleteAll(@RequestParam(value="allboardNo") List<Integer> list) {
		for(int allboardNo : list) {
			boardWithImageDao.delete(allboardNo);
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
	public String detail(@RequestParam int boardNo, Model model, HttpSession session) {
	    // 사용자가 작성자인지 판정 후 JSP로 전달
	    // BoardWithNickDto boardWithNickDto = boardWithNickDao.selectOne(allboardNo);
		BoardDto boardDto = boardDao.selectOne(boardNo);
		int allboardNo = boardDto.getAllboardNo();
	    String memberId = session.getAttribute("memberId")== null ? null : (String) session.getAttribute("memberId");
	    boolean owner = boardDto.getBoardWriter() != null
	            && boardDto.getBoardWriter().equals(memberId);
	    model.addAttribute("owner", owner);

	    // 사용자가 관리자인지 판정 후 JSP로 전달
	    String memberLevel = session.getAttribute("memberLevel")==null ? null : (String) session.getAttribute("memberLevel");
	    boolean admin = memberLevel != null && memberLevel.equals("관리자");
	    model.addAttribute("admin", admin);
	    // 조회수 증가
	    if (!owner) {// 내가 작성한 글이 아니라면(시나리오 1번)
	        // 시나리오 2번 진행
	    	
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
	        if (memory == null) {
	            memory = new HashSet<>();
	        }
	        if (!memory.contains(allboardNo)) {// 읽은 적이 없는가(기억에 없는가)
	            boardWithImageDao.updateReadCount(allboardNo);
	            boardDto.setBoardRead(boardDto.getBoardRead() + 1);// DTO 조회수 1증가
	            memory.add(allboardNo);// 저장소에 추가(기억에 추가)
	        }
	        session.setAttribute("memory", memory);// 저장소 갱신
	    }
		// boardDto.getBoardWriter()
	    model.addAttribute("boardDto", boardDto);
		model.addAttribute("member", memberSealAttachmentNoDao.selectOne(boardDto.getBoardWriter()));
	    return "/WEB-INF/views/board/detail.jsp";
	}
	// backup
	// @GetMapping("/detail3")
	// public String detail3(@RequestParam int allboardNo, Model model, HttpSession session) {
	//     // 사용자가 작성자인지 판정 후 JSP로 전달
	//     BoardWithNickDto boardWithNickDto = boardWithNickDao.selectOne(allboardNo);
	//     String memberId = (String) session.getAttribute("memberId");
	//     boolean owner = boardWithNickDto.getBoardWriter() != null
	//             && boardWithNickDto.getBoardWriter().equals(memberId);
	//     model.addAttribute("owner", owner);

	//     // 사용자가 관리자인지 판정 후 JSP로 전달
	//     String memberLevel = (String) session.getAttribute("memberLevel");
	//     boolean admin = memberLevel != null && memberLevel.equals("관리자");
	//     model.addAttribute("admin", admin);
	//     // 조회수 증가
	//     if (!owner) {// 내가 작성한 글이 아니라면(시나리오 1번)
	//         // 시나리오 2번 진행
	    	
	// 		Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
	//         if (memory == null) {
	//             memory = new HashSet<>();
	//         }
	//         if (!memory.contains(allboardNo)) {// 읽은 적이 없는가(기억에 없는가)
	//             boardWithImageDao.updateReadCount(allboardNo);
	//             boardWithNickDto.setBoardRead(boardWithNickDto.getBoardRead() + 1);// DTO 조회수 1증가
	//             memory.add(allboardNo);// 저장소에 추가(기억에 추가)
	//         }
	//         session.setAttribute("memory", memory);// 저장소 갱신

	//    }
	//     model.addAttribute("boardWithNickDto", boardWithNickDto);
	//     return "/WEB-INF/views/board/detail.jsp";
	// }

	
	@GetMapping("/detail2")
	public String detail2(@RequestParam int allboardNo, Model model, HttpSession session) {
	    // 사용자가 작성자인지 판정 후 JSP로 전달
	    BoardWithNickDto boardWithNickDto = boardWithNickDao.selectOne(allboardNo);
	    String memberId = (String) session.getAttribute("memberId");
	    boolean owner = boardWithNickDto.getBoardWriter() != null
	            && boardWithNickDto.getBoardWriter().equals(memberId);
	    model.addAttribute("owner", owner);

	    // 사용자가 관리자인지 판정 후 JSP로 전달
	    String memberLevel = (String) session.getAttribute("memberLevel");
	    boolean admin = memberLevel != null && memberLevel.equals("관리자");
	    model.addAttribute("admin", admin);
	    // 조회수 증가
	    if (!owner) {// 내가 작성한 글이 아니라면(시나리오 1번)
	        // 시나리오 2번 진행
	    	
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
	        if (memory == null) {
	            memory = new HashSet<>();
	        }
	        if (!memory.contains(allboardNo)) {// 읽은 적이 없는가(기억에 없는가)
	            boardWithImageDao.updateReadCount(allboardNo);
	            boardWithNickDto.setBoardRead(boardWithNickDto.getBoardRead() + 1);// DTO 조회수 1증가
	            memory.add(allboardNo);// 저장소에 추가(기억에 추가)
	        }
	        session.setAttribute("memory", memory);// 저장소 갱신

	   }
	    model.addAttribute("boardWithNickDto", boardWithNickDto);
	    return "/WEB-INF/views/board/detail2.jsp";
	}

	
	
}