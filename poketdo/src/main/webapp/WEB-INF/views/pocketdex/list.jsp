<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


	<h1>포켓몬스터 목록</h1>
	<table>
		<thead>
			<tr>
				<th>이미지</th>
				<th>번호</th>
				<th>이름</th>
				<th>속성</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pocketmonDto"  items="${list3}">
				<tr>
					<td>
					<img width="200" height="200"
						src="${pocketmonDto.imageURL}">
					</td>
					<td>
					${pocketmonDto.pocketNo}
					</td>
					<td>
						<a href="detail?pocketNo=${pocketmonDto.pocketNo}">
							${pocketmonDto.pocketName}
						</a>
					</td>
					<td>
<%-- 						<c:forEach var="i" begin="0" end="${pocketmonDto.getPocketTypes().size()-1}"> --%>
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${i==pocketmonDto.getPocketTypes().size()-1}"> --%>
<%-- 									${pocketmonDto.getPocketTypes().get(i)} --%>
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<%-- 									${pocketmonDto.getPocketTypes().get(i)}, --%>
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<%-- 						</c:forEach> --%>
					</td>
					<td>
						<a href="edit?pocketNo=${pocketmonDto.pocketNo}" >수정</a>
						<a href="delete?pocketNo=${pocketmonDto.pocketNo}" >삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">포켓몬스터 신규 등록</a>
	<div class="row pagination mb-30">
			<!-- 페이지 네비게이터-vo에 있는 데이터를 기반으로 구현  -->

			<c:choose>
				<c:when test="${vo.first }">
					<a class="disabled">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?page=1">&laquo;</a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${!vo.prev }">
					<a class="disabled"> &lt;</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.prevPage}"> &lt; </a>
				</c:otherwise>
			</c:choose>

			<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
				<c:choose>
					<c:when test="${vo.page==i }">
						<a class="on">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:choose>
				<c:when test="${!vo.next }">
					<a class="disabled">&gt;</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.nextPage }"> &gt;</a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${vo.last }">
					<a class="disabled">&raquo;</a>
				</c:when>
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.totalPage}"> &raquo;</a>
				</c:otherwise>
			</c:choose>
		</div>
		
		<!-- 검색창  -->
		<div class="row center mb-30">
			<form action="list" method="get">
				<c:choose>
					<c:when test="${vo.column =='pocket_name'}">
						<select name="column" class="form-input">
							<option value="pocket_name" selected >이름</option>
							<option value="pocket_no" >번호</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="form-input">
							<option value="pocket_name" >이름</option>
							<option value="pocket_no" selected>번호</option>
						</select>
					</c:otherwise>
				</c:choose>
				<input type="search" name="keyword" placeholder="검색어" required
					value="${vo.keyword}" class="form-input">
				<button type="submit" class="form-btn neutral">검색</button>
	
			</form>
		</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>