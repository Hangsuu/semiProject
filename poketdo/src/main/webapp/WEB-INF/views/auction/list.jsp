<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
</script>
<script src="/static/js/timer.js"></script>
<script src="/static/js/bookmark.js"></script>
<div class="container-800 mt-50">
	<div class="row"><h1 style="font-size:2em">경매</h1></div>
<!-- 검색 -->
	<div class="row">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="form-input">
				<option value="auction_title">제목</option>
				<option value="auction_content">내용</option>
				<option value="auction_writer">글쓴이</option>
			</select>
			<input name="keyword" class="form-input" placeholder="검색">
			<input name="page" type="hidden" value="${param.page}">
			<input name="item" type="hidden" value="${param.item}">
			<input name="order" type="hidden" value="${param.order}">
			<input name="special" type="hidden" value="${param.special}">
			<button class="form-btn neutral">검색</button>
		</form>
		<a href="bookmark?page=1&keyword=&column=" class="form-btn neutral">즐겨찾기 보기</a> 
	</div>
<!-- 게시판 테이블 -->
	<div class="row">
		<table class="table table-slit center">
			<thead>
				<tr>
					<th><a class="link" href="list?page=1&${vo.parameter}">글번호<i class="fa-solid fa-sort ms-10"></i></a></th>
					<th class="w-40">제목</th>
					<th>글쓴이</th>
					<th><a class="link" href="list?page=1&${vo.parameter}&item=auction_finish_time&order=asc&special=auction_finish_time>sysdate and auction_min_price<auction_max_price">남은시간<i class="fa-solid fa-sort ms-10"></i></a></th>
					<th>조회수</th>
					<th>좋아요</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="auctionDto" items="${list}">
					<tr>
						<td>${auctionDto.auctionNo}</td>
						<td>
							<a href="detail?allboardNo=${auctionDto.allboardNo}&page=${param.page}&${vo.parameter}" class="link">
								${auctionDto.auctionTitle}
							</a>
						</td>
						<td>${auctionDto.auctionWriter}</td>
						<td>
							<c:choose>
								<c:when test="${auctionDto.finish==true}">
									<span>종료</span>
								</c:when>
								<c:otherwise>
									<div class="rest-time" data-finish-time="${auctionDto.finishTime}" >
										${auctionDto.time}
									</div>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${auctionDto.auctionRead}</td>
						<td>${auctionDto.auctionLike}</td>
<!-- 즐겨찾기 -->
						<td><i class="fa-regular fa-bookmark" style="color:gray" data-allboard-no="${auctionDto.allboardNo}" data-bookmark-type="auction"></i></td>
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
				<a href="list?${vo.parameter}&page=1&${vo.addParameter}"><i class="fa-solid fa-angles-left"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 이전 페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?${vo.parameter}&page=${vo.prevPage}&${vo.addParameter}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angle-left disabled"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 번호들 -->
		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}" step="1">
			<c:choose>
				<c:when test="${vo.page==i}"><a class="on">${i}</a></c:when>
				<c:otherwise><a href="list?${vo.parameter}&page=${i}&${vo.addParameter}" class="">${i}</a></c:otherwise>
			</c:choose>
		</c:forEach>
	<!-- 다음 페이지 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?${vo.parameter}&page=${vo.nextPage}&${vo.addParameter}" class=""><i class="fa-solid fa-angle-right"></i></a>
			</c:when>
			<c:otherwise><a class="disabled">
				<i class="fa-solid fa-angle-right"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 마지막페이지로 -->
		<c:choose>
			<c:when test="${!vo.last}">
				<a href="list?${vo.parameter}&page=${vo.totalPage}&${vo.addParameter}" class=""><i class="fa-solid fa-angles-right"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
			</c:otherwise>
		</c:choose>
	</div>
<!-- 페이지네이션 끝 -->
	<div class="row">
		<c:if test="${sessionScope.memberId!=null}">
			<a href="write" class="form-btn neutral">글쓰기</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>