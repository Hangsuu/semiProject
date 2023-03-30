<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${auctionDto.auctionWriter}";
</script>
<script src="/static/js/timer.js"></script>
<script src="/static/js/auction-bid.js"></script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<div class="container-900 mt-50">
<form action="edit" method="post" autocomplete="off" enctype="multipart/form-data">
	<input type="hidden" name="allboardNo" value="${auctionDto.allboardNo}">
	<div class="row">
	제목 : <input class="form-input w-100" name="auctionTitle" value="${auctionDto.auctionTitle}">
	</div>
	<div class="row">
	최고 입찰 가격 : <input class="form-input min-bid-price" name="auctionMinPrice" value="${auctionDto.auctionMinPrice}">
	</div>
	<div class="row">
	즉시 입찰 가격 : <input class="form-input max-bid-price" name="auctionMaxPrice" value="${auctionDto.auctionMaxPrice}">
	</div>
	<div class="row">
	내용
	<textarea class="row form-input w-100 summernote" style="min-height:200px" name="auctionContent">${auctionDto.auctionContent}</textarea>
	</div>
	<button class="form-btn neutral">수정</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>