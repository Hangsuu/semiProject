<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>


	

</style>


<div class="container-1100 mt-50">
	<div class="row"><h1 style="font-size:2em">레이드</h1></div>
	<div class="row">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="form-input neutral">
				<option value="raid_title">제목</option>
				<option value="raid_monster">몬스터</option>
				<option value="raid_content">내용</option>
				<option value="member_nick">글쓴이</option>
			</select>
			<input name="keyword" class="form-input" placeholder="검색어">
			<input name="page" type="hidden" value="${param.page}">
			<button class="form-btn neutral">검색</button>
		</form>
	</div>
<!-- 테이블 시작 -->
	<div class="row table-box">
		<table class="table table-slit table-hover center">
			<thead>
				<tr>
					<th><a class="link" href="list?page=1&${vo.parameter}">글번호<i class="fa-solid fa-sort ms-10"></i></a></th>
					<th class="w-30">제목</th>
					<th>닉네임</th>
					<th><a class="link" href="list?page=1&${vo.parameter}&item=raid_start_time&order=asc&special=raid_start_time>sysdate and raid_count<4">시작시간<i class="fa-solid fa-sort ms-10"></i></a></th>
					<th><a class="link" href="list?page=1&${vo.parameter}&item=raid_count&order=asc, allboard_no desc&special=raid_start_time>sysdate and raid_count<4">참가자<i class="fa-solid fa-sort ms-10"></i></a></th>
					<c:choose>
						<c:when test="${param.special.startsWith('raid_type=1')}">
							<th><a class="link" href="list?page=1&item=allboard_no&order=desc&special=raid_type=0 and raid_start_time>sysdate and raid_count<4">타입<i class="fa-solid fa-sort ms-10"></i></a></th>
						</c:when>
						<c:otherwise>
							<th><a class="link" href="list?page=1&item=allboard_no&order=desc&special=raid_type=1 and raid_start_time>sysdate and raid_count<4">타입<i class="fa-solid fa-sort ms-10"></i></a></th>
						</c:otherwise>
					</c:choose>
					
					<th>좋아요</th>
					<th>조회수</th> 
				</tr>
			</thead>
			<tbody >
				<c:forEach var="raidDto" items="${list}">
					<tr >
						<td>${raidDto.raidNo}</td>
						<td class="left">
							<div class="do-not-line-over" style="width:350px">
								<a href="detail?allboardNo=${raidDto.allboardNo}&page=${param.page}&${vo.parameter}" class="link">
									<span>[${raidDto.raidMonster}] ${raidDto.raidTitle}</span>
								</a>
							</div>
						</td>
						<td><a href="list?page=1&column=member_nick&keyword=${raidDto.memberNick}" class="link" ><img style="vertical-align:middle;" class="board-seal" src="${pageContext.request.contextPath}${raidDto.urlLink}" >${raidDto.memberNick}</a></td>
						<td>${raidDto.time}</td>
						<c:choose>
							<c:when test="${raidDto.raidCount>=4}">
								<td>모집종료</td>
							</c:when>
							<c:otherwise>
								<td>${raidDto.raidCount}/4</td>
							</c:otherwise>
						</c:choose>
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
				<a href="list?page=1&${vo.parameter}&${vo.addParameter}"><i class="fa-solid fa-angles-left"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 이전 페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?page=${vo.prevPage}&${vo.parameter}&${vo.addParameter}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angle-left disabled"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 번호들 -->
		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}" step="1">
			<c:choose>
				<c:when test="${vo.page==i}"><a class="on disabled">${i}</a></c:when>
				<c:otherwise><a href="list?page=${i}&${vo.parameter}&${vo.addParameter}" class="">${i}</a></c:otherwise>
			</c:choose>
		</c:forEach>
	<!-- 다음 페이지 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?page=${vo.nextPage}&${vo.parameter}&${vo.addParameter}" class=""><i class="fa-solid fa-angle-right"></i></a>
			</c:when>
			<c:otherwise><a class="disabled">
				<i class="fa-solid fa-angle-right"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 마지막페이지로 -->
		<c:choose>
			<c:when test="${!vo.last}">
				<a href="list?page=${vo.totalPage}&${vo.parameter}&${vo.addParameter}" class=""><i class="fa-solid fa-angles-right"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
			</c:otherwise>
		</c:choose>
	</div>
<!-- 페이지네이션 끝 -->
	<div class="row">
		<c:if test="${sessionScope.memberId!=null}">
			<a href="write" class="form-btn positive"><i class="fa-solid fa-pen-to-square me-10" style="color:white"></i>글쓰기</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>