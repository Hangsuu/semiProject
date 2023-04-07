<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="회원이라면">
<script type="text/javascript">
$(function () {
	

	var memberPoint = parseInt("${point}") || 0;
	
	$(".buy-form button[type='submit']").on("click", function(e) {
		  var sealPrice = $(this).siblings("input[name='point']").val();
		  var PointCheck = memberPoint > sealPrice;
		  console.log(PointCheck);
		  if (!PointCheck) {
		    alert("포인트가 부족합니다!");
		    e.preventDefault();
		  }
		});

		$(".buy-form").submit(function(e) {
		  if (!confirm("정말 구매하시겠습니까?")) {
		    e.preventDefault();
		  }
		});
});
</script>
</c:if>

<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">



	<c:if test="${sessionScope.memberLevel=='관리자' }">
		<div class="pocket-insert-btn">
			<a href="insert" class="form-btn positive" >인장 신규 등록</a>
		</div>
	</c:if>
	<c:choose>
	<c:when test="${!list.isEmpty()}">

		<div class="seal-information">
			<div>
				<span>인장 판매 목록</span>
			</div>
			<c:choose>
				<c:when test="${sessionScope.memberLevel != null}">
					<div>
							<span>보유 포인트 : ${point} point</span>
						<a href="/member/myseal">
							<span>내 인장 목록 보러가기</span>
							<i class="fa-solid fa-square-arrow-up-right"></i>
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div>
						<a href="/member/login">
							<span>로그인 후 이용하세요.</span>
						</a>
					</div>
				</c:otherwise>
			</c:choose>
			
		</div>

		<div class="seal-container mb-10">
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
							<div >
								<span>
									point : ${list.get(0).sealPrice}
								</span>
							</div>
						</div>
						<div class="seal-admin">
							<c:if test="${sessionScope.memberLevel=='관리자' }">
							
								<div>
									<a href="edit?sealNo=${list.get(0).sealNo}" class="form-btn neutral" >수정</a>
								</div>
								<div>
									<a href="delete?sealNo=${list.get(0).sealNo}" class="form-btn negative"  class="confirm-delete">삭제</a>
								</div>
							</c:if>
						</div>
					</div>
			
		
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
						<c:if test="${sessionScope.memberLevel != null}">
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
					<div >
						<span>
						point : ${sealWithImageDto.sealPrice}

						</span>
					</div>
				</div>
				<div class="seal-admin">
					<div>
					<c:if test="${sessionScope.memberLevel != null}">
						<form action="purchase" method="post" class="buy-form">
							<input type="hidden" name="sealNo" value="${sealWithImageDto.sealNo}"> 
							<input type="hidden" name="point" value="${sealWithImageDto.sealPrice}"> 
							<button type="submit" class="form-btn positive">구매</button>
						</form>
					</c:if>
					</div>
					<c:if test="${sessionScope.memberLevel=='관리자' }">
						<div>
							<a href="edit?sealNo=${sealWithImageDto.sealNo}" class="form-btn neutral" >수정</a>
						</div>
						<div>
							<a href="delete?sealNo=${sealWithImageDto.sealNo}" class="form-btn negative confirm-delete" >삭제</a>
						</div>
					</c:if>
				</div>
			</div>
			</c:forEach>
		</div>
		        </c:when>
		        <c:otherwise>
		        	<div style=" text-align: center; margin:200px;">
		        		<span>검색 결과가 없습니다.</span>
		        	</div>
		        </c:otherwise>
			</c:choose>

	
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