<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="mysealSelect" method="post">
	<h2>현재 적용 인장</h2>
	<img width="96" height="96" src="${selectAttachNo}">
	<h2>보유 인장 목록</h2>
	<table>
			<thead>
				<tr>
					<th>소유 번호</th>
					<th>선택</th>
					<th>이미지</th>
					<th>인장 번호</th>
					<th>인장 이름</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mySeal" items="${list}"  varStatus="status"> 
					<tr>
						<td>
							${status.index+1}
						</td>
						<td>
							<input type="checkbox" name="mySealNo" value="${mySeal.mySealNo}">
						</td>
						<td>
							<img width="96" height="96"
									src="${mySeal.imageURL}">
						</td>
						<td>
							${mySeal.sealNo}
						</td>
						<td>
							${mySeal.sealName}
						</td>
					</tr>
				</c:forEach>
			</tbody>
	</table>
	<button>선택 완료</button>
</form>

<div class="row pagination mb-30">
			<!-- 페이지 네비게이터-vo에 있는 데이터를 기반으로 구현  -->

			<c:choose>
				<c:when test="${vo.first }">
					<a class="disabled">&laquo;</a>
				</c:when>
				<c:otherwise>
					<a href="myseal?page=1">&laquo;</a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${!vo.prev }">
					<a class="disabled"> &lt;</a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.prevPage}"> &lt; </a>
				</c:otherwise>
			</c:choose>

			<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
				<c:choose>
					<c:when test="${vo.page==i }">
						<a class="on">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="myseal?${vo.parameter}&page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:choose>
				<c:when test="${!vo.next }">
					<a class="disabled">&gt;</a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.nextPage }"> &gt;</a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${vo.last }">
					<a class="disabled">&raquo;</a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.totalPage}"> &raquo;</a>
				</c:otherwise>
			</c:choose>
		</div>
		
		<!-- 검색창  -->
		<div class="row center mb-30">
			<form action="myseal" method="get">
				<c:choose>
					<c:when test="${vo.column =='seal_name'}">
						<select name="column" class="form-input">
							<option value="seal_name" selected >이름</option>
							<option value="seal_no" >번호</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="form-input">
							<option value="seal_name" >이름</option>
							<option value="seal_no" selected>번호</option>
						</select>
					</c:otherwise>
				</c:choose>
				<input type="search" name="keyword" placeholder="검색어" required
					value="${vo.keyword}" class="form-input">
				<button type="submit" class="form-btn neutral">검색</button>
			</form>
		</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>