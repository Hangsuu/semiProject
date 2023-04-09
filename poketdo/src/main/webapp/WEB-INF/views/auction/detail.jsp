<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${auctionDto.auctionWriter}";
	var auctionFinish="${auctionDto.auctionFinish}";
</script>
<script src="${pageContext.request.contextPath}/static/js/timer.js"></script>
<script src="${pageContext.request.contextPath}/static/js/auction-bid.js"></script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/reply.js"></script>
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
	$(".edit-btn").click(function(event){
					event.preventDefault();
		var params = new URLSearchParams(location.search);
		var allboardNo = params.get("allboardNo");
		$.ajax({
			url:contextPath+"/rest/auction/check/"+allboardNo,
			method:"get",
			success:function(response){
				if(response){
					alert("경매가 시작된 게시물을 수정할 수 없습니다.");
				}
				else{
					window.location.href=$(".edit-btn").attr("href");
				}
			}
		});
	});
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
<script type="text/template" id="auction-delivery-template">
<div class="flex-box p-20" style="height:220px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);">
	<div class="w-25 flex-box align-center" style="font-size:60px;">
		<div class="row">
			<div class="row flex-box align-center" style=" height:100px">
				<i class="fa-solid fa-credit-card" style="color:#c9c9c9"></i>
			</div>
			<div class="row flex-box align-center" style=" height:30px">
				<span style="font-size:16px">낙찰자</span><span class="finish-bid-nick ms-10" style="font-size:16px"></span>
			</div>
			<div class="row flex-box align-center" style=" height:30px">
				<a class="form-btn neutral send-message">쪽지보내기</a>
			</div>
		</div>
	</div>
	<div class="flex-box align-center" style="font-size:40px; width:12.5%">
		<i class="fa-solid fa-arrow-right" style="color:#c9c9c9"></i>
	</div>
	<div class="w-25 flex-box align-center" style="font-size:60px;">
		<div class="row">
			<div class="row flex-box align-center" style=" height:100px">
				<i class="fa-solid fa-truck" style="color:#c9c9c9"></i>
			</div>
			<div class="row flex-box align-center" style=" height:60px">
				<button class="form-btn negative delivery-btn">배송 전</button>
			</div>
		</div>
	</div>
	<div class="flex-box align-center" style="font-size:40px; width:12.5%">
		<i class="fa-solid fa-arrow-right" style="color:#c9c9c9"></i>
	</div>
	<div class="w-25 flex-box align-center" style="font-size:60px">
		<div class="row">
			<div class="row flex-box align-center" style=" height:100px">
				<i class="fa-solid fa-gift" style="color:#c9c9c9"></i>
			</div>
				<div class="row flex-box align-center" style=" height:60px">
				<button class="form-btn negative finish-btn">수령 완료</button>
			</div>
		</div>
	</div>
</div>
</script>
<script src="${pageContext.request.contextPath}/static/js/like.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bookmark.js"></script>
<div class="container-1000 mt-50">
<input type="hidden" class="finish-bid-id">
	<div class="row flex-box">
		<span class="board-detail-origin">굿즈 경매</span>
		<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="board-detail-btn align-right">목록</a>
	</div>
	<div class="row board-detail-title">
		${auctionDto.auctionTitle}
	<!-- 즐겨찾기 -->
		<div class="user-bookmark ms-20" style="display: inline-block" title="즐겨찾기 추가">
			<i class="fa-regular fa-bookmark" style="font-size:20px;color:gray" data-allboard-no="${auctionDto.allboardNo}" data-bookmark-type="auction"></i>
		</div>
	</div>
	<div class="row flex-box">
		<div class="row" style="vertical-align:center; display:inline-block">
			<span class="auction-writer">
			<!-- 작성자 검색 링크 -->
				<a href="list?page=1&column=member_nick&keyword=${auctionDto.memberNick}" class="link">
					<img class="board-seal" src="${pageContext.request.contextPath}${auctionDto.urlLink}" style="vertical-align:middle"><span style="vertical-align:middle">${auctionDto.memberNick}</span>
				</a>
			</span>
			<span class="board-detail-time" style="vertical-align:middle">${auctionDto.boardTime}</span>
			<!-- 작성자와 memberId가 같으면 수정, 삭제 버튼 생김 -->
			<c:if test="${sessionScope.memberId==auctionDto.auctionWriter}">
				<a href="edit?page=${param.page}&allboardNo=${auctionDto.allboardNo}&${vo.parameter}" class="board-detail-btn edit-btn" style="vertical-align:middle">수정</a>
				<a href="delete?page=${param.page}&allboardNo=${auctionDto.allboardNo}" class="board-detail-btn delete-btn" style="vertical-align:middle">삭제</a>
			</c:if>
			<c:if test="${sessionScope.memberLevel=='관리자'}">
				<a href="delete?page=${param.page}&allboardNo=${auctionDto.allboardNo}" class="board-detail-btn delete-btn" style="vertical-align:middle">삭제</a>
			</c:if>
		</div>
		<div class="row align-right">
			조회수 : ${auctionDto.auctionRead}
		</div>
	</div>
<!-- 본문 시작 -->
	<div class="row" style="border-top:3px solid #f2f4fb; border-bottom: 3px solid #f2f4fb">
<!-- 확정자 페이지 -->
	<div class="row finish-target"></div>
<!-- 확정자 페이지 끝 -->
	<!-- 경매 진행 관련 -->
		<div class="row" style="border:2px solid #f2f4fb; padding-left:1em; padding-right:1em">
			<div class="row finished-auction">
				<div class="row">
					<span>종료된 경매</span>
				</div>
				<div class="row">
				낙찰 가격 : <span class="final-price"></span>
				</div>	
				<!-- 작성자 최대 입찰자 컨트롤 기능 -->
				<div class="row writer-control-box board-nick-image">
					낙찰자 : 
					<div class="final-last-bid" style="display:inline-block; vertical-align:middle"></div>
				</div>		
			</div>
			<div class="row ing-auction">
				<div class="row">
					<span class="rest-time" data-finish-time="${auctionDto.finishTime}">${auctionDto.time}</span>
				</div>
				<div class="row">
					<div style="display:inline-block" style="vertical-align:middle">
						<span  style="vertical-align:middle">현재 입찰가 : </span><span class="min-bid-price" style="vertical-align:middle"></span>
					</div>
					<div style="display:inline-block" class="bid-info ms-10" style="vertical-align:middle">
						<span style="vertical-align:middle">(입찰자 : </span><img class="board-seal last-bid-seal" style="vertical-align:middle">
						<span class="last-bid-nick" style="vertical-align:middle"></span><span style="vertical-align:middle">)</span>
					</div>
				</div>
				<div class="row">
					확정 입찰가 : <span class="max-bid-price"></span>
				</div>
			</div>
		</div>
	<!-- 경매 진행 관련 끝 -->
		<!-- 본문 -->
		<div class="row w-100 board-detail-content do-not-over" style="min-height:400px; padding-left:1em; padding-right:1em">${auctionDto.auctionContent}</div>
		<div class="row">
			<a href="list?page=1&column=member_nick&keyword=${auctionDto.memberNick}" class="link">${auctionDto.memberNick}님의 게시글 더 보기</a>
		</div>
		<div class="row">
		<!-- 좋아요 -->
			<div class="left like-box" style="display:inline-block">
				<i class="fa-heart detail-like"></i>
				좋아요 :<span class="like-count" style="margin-left:0.5em">${auctionDto.auctionLike}</span>
			</div>
		<!-- 댓글 개수 댓글 span(class=reply-count)에 카운트 처리되도록 함-->
			<div class="reply-number-box" style="display:inline-block">
				댓글 :<span class="reply-count" style="margin-left:0.5em">${auctionDto.auctionReply}</span>
			</div>
		</div>
	</div>
<!-- 본문 끝 -->
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
	</div>
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row mt-30">
		<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
	</div>
<!-- 댓글 끝 -->
<!-- 마지막 줄 -->
	<div class="row flex-box">
		<div class="row">
			<a href="write" class="board-detail-btn">글쓰기</a>
		</div>
		<div class="row align-right">
			<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="board-detail-btn align-right">목록</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>