<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




<section class="container-1200 flex-box" style="padding-left:15px;" >

	<aside></aside>
	
	<article class="mt-50 container-1200">

		<!-- 검색창  -->
			<div class="row center mb-30" >
			<h1 class="mb-30" style="font-size:30px">포켓몬 도감</h1>
			
				<c:if test="${sessionScope.memberLevel=='관리자'}">
					<div class="pocket-insert-btn">
						<a href="insert" class="form-btn positive" >포켓몬스터 신규 등록</a>
					</div>
					<div class="pocket-insert-btn">
						<a href="${pageContext.request.contextPath}/pockettype/list" class="form-btn positive" >포켓몬스터 타입 관리</a>
					</div>
				</c:if>
			
				<form action="list" method="get">
					<c:choose>
						<c:when test="${vo.column =='pocket_no'}">
							<select name="column" class="form-input">
								<option value="pocket_name"  >이름</option>
								<option value="pocket_no" selected>번호</option>
							</select>
						</c:when>
						<c:otherwise>
							<select name="column" class="form-input">
								<option value="pocket_name" selected >이름</option>
								<option value="pocket_no" >번호</option>
							</select>
						</c:otherwise>
					</c:choose>
					<input type="search" name="keyword" placeholder="검색어" required
						value="${vo.keyword}" class="form-input">
					<button type="submit" class="form-btn neutral">검색</button>
		
				</form>
			</div>
	<!-- 페이지 네이션 -->
	<c:if test="${!list3.isEmpty()}">
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
		</c:if>
			
			<c:choose>
				<c:when test="${!list3.isEmpty()}">
				    <ul class="pocket-ul">
						<c:forEach var="pocketmonDto"  items="${list3}">
							 <a href="detail?pocketNo=${pocketmonDto.pocketNo}" class="pocket-box-a">
							  <li class="pocket-li row">
							    <div class="pocket-box ">
							      <div></div>
							      <div></div>
							      <div class="image-container">
							          <img src="${pocketmonDto.imageURL}">
							      </div>
							    </div>
							    <div class="pocket-data">
							      <h4>No.0${pocketmonDto.pocketNo}</h4>
							      <h3>${pocketmonDto.pocketName}</h3>
							   		   <div>
					    					<c:forEach var="i" begin="0" end="${pocketmonDto.getPocketTypes().size()-1}">
												<c:choose>
													<c:when test="${pocketmonDto.getPocketTypes().get(i).equals('없음')}">
													</c:when>
													<c:otherwise>
														<div class="pdc-color type-back-color${pocketmonDto.getPocketTypeNoes().get(i)} ">
															<span>
																${pocketmonDto.getPocketTypes().get(i)}
															</span>
														</div>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</div>
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
	
	<c:if test="${sessionScope.memberLevel=='관리자' }">
		<div class="pocket-insert-btn">
			<a href="insert" class="form-btn positive" >포켓몬스터 신규 등록</a>
		</div>
		<div class="pocket-insert-btn">
			<a href="${pageContext.request.contextPath}/pockettype/list" class="form-btn positive" >포켓몬스터 타입 관리</a>
		</div>
	</c:if>
	
	<!-- 페이지 네이션 -->
	<c:if test="${!list3.isEmpty()}">
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
		</c:if>
			<!-- 검색창  -->
			<div class="row center mb-30" >
				<form action="list" method="get">
					<c:choose>
						<c:when test="${vo.column =='pocket_no'}">
							<select name="column" class="form-input">
								<option value="pocket_name"  >이름</option>
								<option value="pocket_no" selected>번호</option>
							</select>
						</c:when>
						<c:otherwise>
							<select name="column" class="form-input">
								<option value="pocket_name"  selected>이름</option>
								<option value="pocket_no" >번호</option>
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