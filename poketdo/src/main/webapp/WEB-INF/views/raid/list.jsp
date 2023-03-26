<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
	<div class="row"><h1 style="font-size:2em">레이드</h1></div>
	<div class="row">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="form-input">
				<option value="raid_title">제목</option>
				<option value="raid_monster">몬스터</option>
				<option value="raid_content">내용</option>
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
					<th>시작시간</th>
					<th>참가자</th>
					<th>타입</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="raidDto" items="${list}">
					<tr>
						<td>${raidDto.raidNo}</td>
						<td><a href="detail?allboardNo=${raidDto.allboardNo}&page=${param.page}" class="link">
							[${raidDto.raidMonster}] ${raidDto.raidTitle}
						</a></td>
						<td>${raidDto.time}</td>
						<td>${raidDto.raidCount}/4</td>
						<c:choose>
							<c:when test="${raidDto.raidType==0}">
								<td>모집</td>
							</c:when>
							<c:otherwise>
								<td>선착순</td>
							</c:otherwise>
						</c:choose>
						<td>${raidDto.raidLike}</td>
						<td>${raidDto.raidRead}</td>
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