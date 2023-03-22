<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
<form action="write" method="post">
<input type="hidden" name="auctionWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목<input class="form-input w-100" name="auctionTitle">
	</div>
	<div class="row">
		기간선택 : 
		<select name="lastDay" class="form-input">
			<option value="1">1일</option>
			<option value="3">3일</option>
		</select>
	</div>
	<div class="row">
	최소금액 : <input class="form-input w-40" name="auctionMinPrice">
	</div>
	<div class="row">
	최대금액 : <input class="form-input w-40" name="auctionMaxPrice">
	</div>
	<div class="row">
		내용<textarea class="form-input w-100" name="auctionContent"></textarea>
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>