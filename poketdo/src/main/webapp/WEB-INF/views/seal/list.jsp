<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<h1>인장 구매 목록</h1>
	<table>
		<thead>
			<tr>
				<th>이미지</th>
				<th>번호</th>
				<th>이름</th>
				<th>가격</th>
				<th>구매</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="sealWithImageDto" items="${list}" >
				<tr>
					<td>
						<img width="96" height="96"
							src="${sealWithImageDto.imageURL}">
					</td>
					<td>
					${sealWithImageDto.sealNo}
					</td>
					<td>
						<a href="detail?sealNo=${sealWithImageDto.sealNo}">
							${sealWithImageDto.sealName}
						</a>
					</td>
					<td>
						${sealWithImageDto.sealPrice}
					</td>
					<td>
						<form action="purchase" method="post">
							<input type="hidden" name="sealNo" value="${sealWithImageDto.sealNo}"> 
							<input type="hidden" name="point" value="${sealWithImageDto.sealPrice}"> 
							<button>구매</button>
						</form>
					</td>
					<td>
						<a href="edit?sealNo=${sealWithImageDto.sealNo}">수정</a>
						<a href="delete?sealNo=${sealWithImageDto.sealNo}">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">인장 신규 등록</a>
	
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