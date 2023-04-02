<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">

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
					<c:when test="${vo.column =='seal_no'}">
						<select name="column" class="form-input">
							<option value="seal_name"  >이름</option>
							<option value="seal_no" selected>번호</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="form-input">
							<option value="seal_name" selected>이름</option>
							<option value="seal_no" >번호</option>
						</select>
					</c:otherwise>
				</c:choose>
				<input type="search" name="keyword" placeholder="검색어" required
					value="${vo.keyword}" class="form-input">
				<button type="submit" class="form-btn neutral">검색</button>
	
			</form>
		</div>

	<c:if test="${sessionScope.memberLevel=='관리자' }">
		<div class="pocket-insert-btn">
			<a href="insert" class="form-btn positive" >인장 신규 등록</a>
		</div>
	</c:if>

		<div class="seal-information">
			<div>
				<span>인장 판매 목록</span>
			</div>
			<div>
				<a href="/member/myseal">
					<i class="fa-solid fa-square-arrow-up-right"></i>
					<span>내 인장 목록 보러가기</span>
					<span>보유 포인트 : ${point} point</span>
				</a>
			</div>
		</div>
		<div class="seal-container">
			<c:if test="${sessionScope.memberLevel=='관리자' }">
					<div>
						<div>
							<div>
								<img src="${list.get(0).imageURL}">
							</div>
							<div>
								<span>No.0${list.get(0).sealNo}</span>
							</div>
							<div>
								<span>${list.get(0).sealName}</span>
							</div>
							<div class="seal-price">
								<span>
									point : ${list.get(0).sealPrice}
								</span>
							</div>
						</div>
						<div class="seal-admin">
							<div>
								<form action="purchase" method="post">
									<input type="hidden" name="sealNo" value="${list.get(0).sealNo}"> 
									<input type="hidden" name="point" value="${list.get(0).sealPrice}"> 
								<button type="submit" class="form-btn positive">구매</button>
							</form>
							</div>
							<div>
								<a href="edit?sealNo=${list.get(0).sealNo}" class="form-btn neutral" >수정</a>
							</div>
							<div>
								<a href="delete?sealNo=${list.get(0).sealNo}" class="form-btn negative" >삭제</a>
							</div>
						</div>
					</div>
			</c:if>
			
		
			<c:forEach begin="1" var="sealWithImageDto" items="${list}" >
			<div>
				<div>
					<div class="seal-image-container">
						<img src="${sealWithImageDto.imageURL}">
					</div>
					<div>
						<span>No.0${sealWithImageDto.sealNo}</span>
					</div>
					<div>
						<span>
						${sealWithImageDto.sealName}
						<c:if test="${sessionScope.memberLevel=='관리자' }">
							<c:forEach var="list2" items="${list2}">
								<c:choose>
									<c:when test="${list2 eq sealWithImageDto.sealNo}">
										(보유중)
									</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						</span>
					</div>
					<div class="seal-price">
						<span>
						point : ${sealWithImageDto.sealPrice}

						</span>
					</div>
				</div>
				<div class="seal-admin">
					<div>
						<form action="purchase" method="post">
							<input type="hidden" name="sealNo" value="${sealWithImageDto.sealNo}"> 
							<input type="hidden" name="point" value="${sealWithImageDto.sealPrice}"> 
						<button type="submit" class="form-btn positive">구매</button>
					</form>
					</div>
					<div>
						<a href="edit?sealNo=${sealWithImageDto.sealNo}" class="form-btn neutral" >수정</a>
					</div>
					<div>
						<a href="delete?sealNo=${sealWithImageDto.sealNo}" class="form-btn negative" >삭제</a>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>


	
	<c:if test="${sessionScope.memberLevel=='관리자' }">
		<div class="pocket-insert-btn">
			<a href="insert" class="form-btn positive" >인장 신규 등록</a>
		</div>
	</c:if>
	
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
					<c:when test="${vo.column =='seal_no'}">
						<select name="column" class="form-input">
							<option value="seal_name"  >이름</option>
							<option value="seal_no" selected>번호</option>
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="form-input">
							<option value="seal_name" selected>이름</option>
							<option value="seal_no" >번호</option>
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