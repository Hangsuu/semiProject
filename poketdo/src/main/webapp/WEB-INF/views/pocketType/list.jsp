<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">

			<div class="row center mb-30" >
				<h1 class="mb-20">포켓몬스터 타입</h1>

					<div class="pocket-insert-btn">
						<a href="insert" class="form-btn positive" >포켓몬스터 타입 신규 등록</a>
					</div>
			</div>
					
			<c:choose>
				<c:when test="${!list.isEmpty()}">
					<ul class="pocket-ul">
						<c:forEach var="pocketmonTypeWithImageDto" items="${list}">
							<a href="detail?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}" class="pocket-type-box-a">
								<li class="pocket-li row">
									<div class="pocket-type-box">
										<div></div>
										<div class="pdc-color type-back-color${pocketmonTypeWithImageDto.pocketTypeNo}" >
											<img width="200" height="200" src="${pageContext.request.contextPath}${pocketmonTypeWithImageDto.imageURL}">
										</div>
									</div>
									<div class="pocket-data">
										<h4>No.0${pocketmonTypeWithImageDto.pocketTypeNo}</h4>
										<h3>${pocketmonTypeWithImageDto.pocketTypeName}</h3>
									</div>
								</li>
							</a>
						</c:forEach>
					</ul>
		        </c:when>
		        <c:otherwise>
		        	<div style=" text-align: center; margin:200px;">
		        		<span>검색 결과가 없습니다.</span>
		        	</div>
		        </c:otherwise>
			</c:choose>	
	
	<div class="row pagination mb-30">
			<!-- 페이지 네비게이터-vo에 있는 데이터를 기반으로 구현  -->

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
		<div class="row center mb-30">
			<form action="list" method="get">
				<c:choose>
					<c:when test="${vo.column =='pocket_type_no'}">
						<select name="column" class="form-input">
							<option value="pocket_type_name"  >이름</option>
							<option value="pocket_type_no" selected>번호</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="form-input">
							<option value="pocket_type_name" selected>이름</option>
							<option value="pocket_type_no" >번호</option>
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