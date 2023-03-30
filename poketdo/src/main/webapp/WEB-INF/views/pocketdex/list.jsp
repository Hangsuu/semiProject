<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="container-1200 mt-50 align-center">

		<!-- 검색창  -->
			<div class="row center mb-30" >
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

		<div class="row pagination mb-50" >
		
			<c:choose>
			
				<c:when test="${vo.first }">
					<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?page=1"><i class="fa-solid fa-angles-left"></i></a>
				</c:otherwise>
				
			</c:choose>
				
			<c:choose>
			
				<c:when test="${!vo.prev }">
					<a class="disabled"> <i class="fa-solid fa-angle-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.prevPage}"> <i class="fa-solid fa-angle-left"></i> </a>
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
						<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.nextPage }"> <i class="fa-solid fa-angle-right"></i></a>
					</c:otherwise>
				</c:choose>
	
				<c:choose>
					<c:when test="${vo.last }">
						<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.totalPage}"> <i class="fa-solid fa-angles-right"></i></a>
					</c:otherwise>
				</c:choose>
			</div>

	
		<c:forEach var="pocketmonDto"  items="${list3}">
		
		    <div class="pocket-box row">
		        <div></div>
		        <div></div>
		        <div>
		        	<a href="detail?pocketNo=${pocketmonDto.pocketNo}">
		        		<img src="${pocketmonDto.imageURL}">
		        	</a>
		        </div>
	      </div>
	      
		</c:forEach>

	
		<div class="row pagination mb-30 mt-50" >
		
			<c:choose>
			
				<c:when test="${vo.first }">
					<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?page=1"><i class="fa-solid fa-angles-left"></i></a>
				</c:otherwise>
				
			</c:choose>
				
			<c:choose>
			
				<c:when test="${!vo.prev }">
					<a class="disabled"> <i class="fa-solid fa-angle-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.prevPage}"> <i class="fa-solid fa-angle-left"></i> </a>
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
						<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.nextPage }"> <i class="fa-solid fa-angle-right"></i></a>
					</c:otherwise>
				</c:choose>
	
				<c:choose>
					<c:when test="${vo.last }">
						<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.totalPage}"> <i class="fa-solid fa-angles-right"></i></a>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- 검색창  -->
			<div class="row center mb-30" >
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
		</article>
</section>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>