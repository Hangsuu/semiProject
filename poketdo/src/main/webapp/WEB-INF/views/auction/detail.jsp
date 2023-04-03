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
});
</script>
<!-- 댓글장 템플릿 -->
<script type="text/template" id="reply-template">
	<div class="row reply-box flex-box">
		<div class="remove-box" style="width:5%">
			<div class="align-center center" style="padding-top:1em">
				<i class="fa-solid fa-reply fa-flip-both" style="font-size:16px"></i>
			</div>
		</div>
		<div class="align-right remain-box" style="width:95%">
			<div class="row flex-box" style="align-items:center">
				<div class="reply-writer"></div>
				<div class="reply-time ms-20" style="font-size:14px"></div>
				<div class="align-right reply-option me-20"></div>
				<div class="left reply-like-box">
					<i class="fa-heart reply-like"></i>
					<span class="reply-like-count"></span>
				</div>
			</div>
			<div class="row reply-content" style="padding-left:1em"></div>
		</div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row reply-edit">
		<textarea class="row reply-edit-content form-input w-100 summernote-reply-edit"></textarea>
	</div>
</script>
<script type="text/template" id="reply-child-template">
	<div class="row reply-child">
		<textarea class="form-input w-100 summernote-reply-child reply-textarea"></textarea>
	</div>
</script>
<script src="/static/js/like.js"></script>
<script src="/static/js/bookmark.js"></script>
<div class="container-900 mt-50">
	<div class="row">
	제목 : ${auctionDto.auctionTitle}
	<c:if test="${auctionDto.auctionFinish==0}">
		<button class="form-btn negative finish-btn">거래 완료</button>
	</c:if>
	</div>
	<div class="row">
		<div class="row finished-auction">
			<div class="row">
				<span>종료된 경매</span>
			</div>
			<div class="row">
			낙찰 가격 : <span class="final-price"></span>
			</div>	
			<!-- 작성자 최대 입찰자 컨트롤 기능 -->
			<div class="row writer-control-box">
				낙찰자 : 
				<div class="final-last-bid" style="display:inline-block"></div>
				<a class="form-btn neutral send-message">쪽지 보내기</a>
				<input type="hidden" class="finish-bid-id">
			</div>		
		</div>
		<div class="row ing-auction">
			<div class="row">
				남은시간 : <span class="rest-time" data-finish-time="${auctionDto.finishTime}">${auctionDto.time}</span>
			</div>
			<div class="row">
				<div style="display:inline-block">
					최고 입찰 가격 : <span class="min-bid-price"></span>
				</div>
				<div style="display:inline-block" class="bid-info ms-10">
					(입찰자 : <img class="board-seal last-bid-seal"><span class="last-bid-nick"></span>)
				</div>
			</div>
			<div class="row">
			즉시 입찰 가격 : <span class="max-bid-price"></span>
			</div>
		</div>
	</div>
	<div class="row">
	조회수 : ${auctionDto.auctionRead}
	</div>
	<div class="row flex-box">
		<div>
			내용
		</div>
		<div class="align-right">
	<!-- 좋아요 -->
			<div class="left like-box" style="display:inline-block">
				<i class="fa-heart detail-like"></i>
				<span class="like-count"></span>
			</div>
	<!-- 즐겨찾기 -->
			<div class="right user-bookmark" style="display: inline-block">
				<i class="fa-regular fa-bookmark" style="color:gray" data-allboard-no="${auctionDto.allboardNo}" data-bookmark-type="auction"></i>
			</div>
		</div>
	</div>
	<div class="row form-input w-100" style="min-height:200px">${auctionDto.auctionContent}</div>
	<div class="row">
	글쓴이 : <span class="auction-writer"><img class="board-seal" src="${auctionDto.urlLink}">${auctionDto.memberNick}</span>
	</div>
<!-- 입찰기능 -->
	<c:if test="${sessionScope.memberId!=auctionDto.auctionWriter}">
		<div class="my-point"></div>
		<input type="hidden" class="my-point-input">
		<div class="row bid-form">
			<form class="form-bid">
				<input type="hidden" name="auctionBidOrigin" value="${auctionDto.allboardNo}">
				<input type="hidden" name="auctionBidMember" value="${sessionScope.memberId}">
				<input class="form-input" name="auctionBidPrice">
				<button type="button" class="form-btn neutral bid-btn">입찰</button>
			</form>
		</div>
	</c:if>
<!-- 입찰 기능 끝-->

<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-best-target">
		<div class="row" style="border-bottom:1.5px solid #9DACE4; padding-bottom:0.5em">
			Best 댓글
		</div>
	</div>
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row mt-30">
		<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
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