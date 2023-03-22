<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
	<div class="row"><h1 style="font-size:2em">레이드</h1></div>
<!-- 테이블 시작 -->
	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>시작시간</th>
					<th>참가자</th>
					<th>글쓴이</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="raidDto" items="${list}">
					<tr>
						<th>${raidDto.raidNo}</th>
						<th><a href="detail?seqNo=${raidDto.seqNo}&page=${param.page}">${raidDto.raidTitle} /타입:${raidDto.raidType}</a></th>
						<th>${raidDto.raidStartTime}</th>
						<th>${raidDto.raidParticipant}/4</th>
						<th>${raidDto.raidWriter}</th>
						<th>${raidDto.raidLike}</th>
						<th>${raidDto.raidRead}</th>
					</tr>
				</c:forEach>				
			</tbody>
		</table>
	</div>
<!-- 테이블 끝 -->
	<div class="row">
	<a href="write">글쓰기</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>