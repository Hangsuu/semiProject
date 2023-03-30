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
<script src="/static/js/reply.js"></script>
<script>
$(function(){
	$(".delete-btn").click(function(event){
		if(!confirm("정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
			event.preventDefault();
			return;
		}
		else{
			window.location.href=$(this).attr("href");
		}
	})	
})
</script>
<script type="text/template" id="reply-template">
	<div class="row reply-box" style="border-bottom:1px solid lightgray">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content"></div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row">
		<textarea class="row reply-edit-content form-input w-100 summernote-reply-edit"></textarea>
	</div>
</script>
<script type="text/template" id="reply-child-template">
	<div class="row">
	<hr>
		<textarea class="form-input w-100 summernote-reply"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
</script>
<script src="/static/js/like.js"></script>
<script src="/static/js/bookmark.js"></script>
<div class="container-900 mt-50">
	<div class="row">
	제목 : ${auctionDto.auctionTitle}
	</div>
	<div class="row">
		<div class="row finished-auction">
			<div class="row">
				<span>종료된 경매</span>
			</div>
			<div class="row">
			낙찰 가격 : <span class="min-bid-price"></span>
			</div>			
		</div>
		<div class="row ing-auction">
			<div class="row">
				남은시간 : <span class="rest-time" data-finish-time="${auctionDto.finishTime}">${auctionDto.time}</span>
			</div>
			<div class="row">
			최고 입찰 가격 : <span class="min-bid-price"></span>
			</div>
			<div class="row">
			즉시 입찰 가격 : <span class="max-bid-price"></span>
			</div>
		</div>
	</div>
	<div class="row">
	조회수 : ${auctionDto.auctionRead}
	</div>
	<div class="row">
	내용
<!-- 좋아요 -->
		<div class="right user-like"><i class="fa-regular fa-heart" style="color:red"></i></div>
<!-- 즐겨찾기 -->
		<div class="right user-bookmark"><i class="fa-regular fa-bookmark" style="color:gray" data-allboard-no="${auctionDto.allboardNo}" data-bookmark-type="auction"></i></div>
		<div class="row form-input w-100" style="min-height:200px">${auctionDto.auctionContent}</div>
	</div>
	<div class="row">
	글쓴이 : <span class="auction-writer">${auctionDto.auctionWriter}</span>
	</div>
<!-- 입찰기능 -->
	<div class="row bid-form">
		<form class="form-bid">
			<input type="hidden" name="auctionBidOrigin" value="${auctionDto.allboardNo}">
			<input type="hidden" name="auctionBidMember" value="${sessionScope.memberId}">
			<input class="form-input" name="auctionBidPrice">
			<button type="button" class="form-btn neutral bid-btn">입찰</button>
		</form>
	</div>
<!-- 입찰기능 끝 -->
<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
		<textarea class="form-input w-100 summernote-reply"></textarea>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<c:if test="${sessionScope.memberId==auctionDto.auctionWriter}">
			<a href="delete?page=${param.page}&allboardNo=${auctionDto.allboardNo}" class="form-btn neutral delete-btn">삭제</a>
			<a href="edit?page=${param.page}&allboardNo=${auctionDto.allboardNo}" class="form-btn neutral">수정</a>
		</c:if>
		<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="form-btn neutral">목록</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>