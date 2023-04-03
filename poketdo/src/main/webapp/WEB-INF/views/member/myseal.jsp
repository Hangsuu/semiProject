<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
$(function () {
	
	$(".sell-form").click(function(e){
	    e.preventDefault();
	    if(!confirm("정말 삭제하시겠습니까?"))	return;
	    window.location.href = $(this).attr("href");
	});
	
	var memberPoint = ${point};
	
	$(".buy-form button[type='submit']").on("click", function(e) {
		  var sealPrice = $(this).siblings("input[name='point']").val();
		  var PointCheck = memberPoint > sealPrice;
		  console.log(PointCheck);
		  if (!PointCheck) {
		    alert("포인트가 부족합니다!");
		    e.preventDefault();
		  }
		});

		$(".confirm-form").submit(function(e) {
		  if (!confirm("정말 구매하시겠습니까?")) {
		    e.preventDefault();
		  }
		});
});
</script>

<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">
		

		<div class="my-seal-information" >
				<div>
					<span>나의 인장</span>
				</div>
				<div>
					<span>보유 포인트 :  ${point} point</span>
					<span>현재 적용 인장</span>
					<img width="96" height="96" src="${selectAttachNo}">
					<a href="/seal/list">
						<i class="fa-solid fa-square-arrow-up-right"></i>
						<span>인장 구매하러 가기</span>
					</a>
				</div>
		</div>
		<c:choose>
	<c:when test="${!list.isEmpty()}">
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
				<div>
					<span>판매가 : ${mySeal.getSellPrice()} </span>
				</div>
				<div class="my-seal-menu">
							<div>
								<form action="mysealSelect" method="post">
									<input type="hidden" name="mySealNo" value="${mySeal.mySealNo}">
									<button class="form-btn positive">적용</button>
								</form>
							</div>
							<c:if test="${mySeal.sealNo!=0}">
							<div>
								<form action="mysealSell" method="post">
									<input type="hidden" name="mySealNo" value="${mySeal.mySealNo}">
									<input type="hidden" name="sealPrice" value="${mySeal.getSellPrice()}">
									<button class="form-btn negative">판매</button>
								</form>
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