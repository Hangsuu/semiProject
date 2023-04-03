<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">
		
		
	<div class="seal-information">
			<div>
				<span>나의 인장</span>
			</div>

		<form action="mysealSelect" method="post">
		<div class="seal-container">
			<c:forEach var="mySeal" items="${list}"  varStatus="status"> 
			<div>
				<div>
					<img width="96" height="96" 	src="${mySeal.imageURL}">
				</div>
				<div>
					<span>No.0${mySeal.sealNo}</span>
				</div>
				<div>
					<span>${mySeal.sealName}</span>
				</div>
			</div>	
			</c:forEach>
		</div>
			<div>
				<button>선택 완료</button>
			</div>
			</form>
	</div>
<div class="row pagination mb-30">
			<!-- 페이지 네비게이터-vo에 있는 데이터를 기반으로 구현  -->

			<c:choose>
				<c:when test="${vo.first }">
					<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
				</c:when>
				<c:otherwise>
					<a href="myseal?page=1"><i class="fa-solid fa-angles-left"></i></a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${!vo.prev }">
					<a class="disabled"> <i class="fa-solid fa-angle-left"></i></a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.prevPage}"> <i class="fa-solid fa-angle-left"></i> </a>
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
					<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.nextPage }"> <i class="fa-solid fa-angle-right"></i></a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${vo.last }">
					<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
				</c:when>
				<c:otherwise>
					<a href="myseal?${vo.parameter}&page=${vo.totalPage}"> <i class="fa-solid fa-angles-right"></i></a>
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
		
			</article>
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>