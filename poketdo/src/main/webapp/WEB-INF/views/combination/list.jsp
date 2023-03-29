<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
	<div class="row"><h1 style="font-size:2em">추천 조합 게시판</h1></div>
	<div class="row">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="form-input">
				<option value="combination_title">제목</option>
				<option value="combination_type">타입</option>
				<option value="combination_content">내용</option>
			</select>
			<input name="keyword" class="form-input" placeholder="검색어">
			<input name="page" type="hidden" value="${param.page}">
			<button class="form-btn neutral">검색</button>
		</form>
	</div>
<!-- 테이블 시작 -->
	<div class="row">
		<table class="table table-slit center">
			<thead>
				<tr>
					<th>글번호</th>
					<th class="w-40">제목</th>
					<th>글쓴이</th>
					<th>게시시간</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="combinationDto" items="${list}">
					<tr>
						<td>${combinationDto.combinationNo}</td>
						<td><a href="detail?allboardNo=${combinationDto.allboardNo}&page=${param.page}" class="link">
							[${combinationDto.combinationType}] ${combinationDto.combinationTitle}
						</a></td>
						<td>${combinationDto.combinationWriter}</td>
						<td>${combinationDto.combinationTime}</td>
						<td>${combinationDto.combinationLike}</td>
						<td>${combinationDto.combinationRead}</td>
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
		<c:if test="${sessionScope.memberId!=null}">
			<a href="write" class="form-btn neutral">글쓰기</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>