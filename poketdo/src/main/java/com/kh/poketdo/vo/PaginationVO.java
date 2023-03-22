package com.kh.poketdo.vo;

import lombok.Data;

@Data
public class PaginationVO {
	private String column = "boardTitle";
	private String keyword = "";
	private int page = 1;	// 현재 페이지 번호
	private int size = 18;	// 한 페이지에 보여줄 게시판 갯수
	private int count;		// 전체 게시물 갯수
	private int blockSize = 10;	// 한 페이지에 보여줄 페이지 수
	
	//검색 여부 판정
	public boolean isSearch() {
		return keyword.equals("") == false;
	}
	public boolean isList() {
		//return keyword.equals("");
		return !isSearch();
	}
	
	// 파라미터 생성 메소드
	// - 목록 일 경우 size=ooo 형태의 문자열을 반환
	// - 검색 일 경우 size=ooo&column=ooo&keyword=ooo 형태의 문자열을 반환
	public String getParameter() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("size= ");
		buffer.append(size);
		
		if(isSearch()) { // 검색이라면 항목을 더 추가한다.
			buffer.append("column = ");
			buffer.append(column);
			buffer.append("keyword = ");
			buffer.append(keyword);
		}
		
		return buffer.toString();
	}
	
	// 시작행번호 계산
	public int getBegin() {
		return page * size - (size - 1);
	}
	
	// 끝행번호 계산
	public int getEnd() {
		return page * size;
	}
	
	// 전체 페이지 계산
	public int getTotalPage() {
		return (count + size - 1) / size;
	}
	
	// 현재 페이지가 포함된 블록 시작 블록 번호 계산
	public int getStartBlock() {
		return (page - 1) / blockSize * blockSize + 1;
	}
	
	// 현재 페이지가 포함된 종료 블록 번호 계산
	public int getFinishBlock() {
		int value = (page - 1) / blockSize * blockSize + blockSize;
		//이 값이 너무 전체 페이지 수보다 크다면 getTotalPage로 전체 페이지를 구한 후 마지막 번호로 대체한다.
		return Math.min(value, getTotalPage());
	}
	
	//첫 페이지인가?
	public boolean isFirst() {
		return page == 1;
	}
	
	//마지막 페이지인가?
	public boolean isLast() {
		return page == getTotalPage();
	}
	
	//[이전]이 나올 조건 - 시작블록이 1보다 크면(page가 size보다 크면)
	public boolean isPrev() {
		return getStartBlock() > 1;
	}
	
	//[다음]이 나올 조건 - 종료 블록이 마지막 페이지보다 작으면
	public boolean isNext() {
		return getFinishBlock() < getTotalPage();
	}
	
	//[이전] 을 누르면 나올 페이지 번호
	public int getPrevPage() {
		return getStartBlock() - 1;
	}
	
	//[다음] 을 누르면 나올 페이지 번호
	public int getNextPage() {
		return getFinishBlock() + 1;
	}
}
