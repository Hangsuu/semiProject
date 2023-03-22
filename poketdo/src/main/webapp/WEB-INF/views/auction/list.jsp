<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
	<div class="row"><h1 style="font-size:2em">경매</h1></div>
<!-- 검색 -->
	<div class="row">
		<form action="list" method="get">
			<select name="column" class="form-input">
				<option value="auction_title">제목</option>
				<option value="auction_content">내용</option>
				<option value="auction_writer">글쓴이</option>
			</select>
			<input name="keyword" class="form-input" placeholder="검색">
			<input name="page" type="hidden" value="${param.page}">
			<button class="form-btn neutral">검색</button>
		</form> 
	</div>
<!-- 게시판 테이블 -->
	<div class="row">
		<table class="table table-slit center">
			<thead>
				<tr>
					<th>글번호</th>
					<th class="w-40">제목</th>
					<th>글쓴이</th>
					<th>종료시간</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="auctionDto" items="${list}">
					<tr>
						<td>${auctionDto.seqNo}</td>
						<td><a href="detail?seqNo=${auctionDto.seqNo}&page=${param.page}" class="link">${auctionDto.auctionTitle}</a></td>
						<td>${auctionDto.auctionWriter}</td>
						<td>${auctionDto.auctionFinishTime}</td>
						<td>${auctionDto.auctionRead}</td>
						<td>${auctionDto.auctionLike}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
<!-- 테이블 끝 -->
<!-- 페이지네이션 -->
	<div class="row center pagination">
	<!-- 1페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.first}">
				<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
			</c:when>
			<c:otherwise>
				<a href="list?page=1"><i class="fa-solid fa-angles-left"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 이전 페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angle-left disabled"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 번호들 -->
		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}" step="1">
			<c:choose>
				<c:when test="${vo.page==i}"><a class="on">${i}</a></c:when>
				<c:otherwise><a href="list?${vo.parameter}&page=${i}" class="">${i}</a></c:otherwise>
			</c:choose>
		</c:forEach>
	<!-- 다음 페이지 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?page=${vo.nextPage}" class=""><i class="fa-solid fa-angle-right"></i></a>
			</c:when>
			<c:otherwise><a class="disabled">
				<i class="fa-solid fa-angle-right"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 마지막페이지로 -->
		<c:choose>
			<c:when test="${!vo.last}">
				<a href="list?page=${vo.totalPage}" class=""><i class="fa-solid fa-angles-right"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
			</c:otherwise>
		</c:choose>
	</div>
<!-- 페이지네이션 끝 -->
	<div class="row">
		<a href="write" class="form-btn neutral">글쓰기</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>