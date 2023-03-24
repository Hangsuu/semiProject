<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
	$(function(){
		var params = new URLSearchParams(location.search);
		var allboardNo = params.get("allboardNo");
		
		getMinPrice();
		getMaxPrice();
		
		function getMinPrice(){
			$.ajax({
				url:"/rest/auction/min/"+allboardNo,
				method:"get",
				success:function(response){
					$(".min-bid-price").text(response);
				}
			});			
		};
		function getMaxPrice() {
			$.ajax({
				url:"/rest/auction/max/"+allboardNo,
				method:"get",
				success:function(response){
					$(".max-bid-price").text(response);
				}
			});			
		};
		
		$(".bid-btn").click(function(){
			var data = $(".form-bid").serialize();
			var enterPrice = $("[name=auctionBidPrice]").val();
			var minPrice = $(".min-bid-price").text();
			var maxPrice = $(".max-bid-price").text();
			$(".form-bid").get(0).reset();
			if(parseInt(enterPrice)<parseInt(minPrice)){
				alert("최소 금액 이상 입찰하세요");
			}
			else if(parseInt(enterPrice)>parseInt(maxPrice)){
				alert("최대 입찰금액 이상입니다");
			}
			else{
				$.ajax({
					url:"/rest/auction/",
					method:"post",
					data:data,
					success:function(){
					},
				});
				$.ajax({
					url:"/rest/auction/min?bidPrice="+enterPrice+"&allboardNo="+allboardNo,
					method:"get",
					success:function(){
						console.log("성공");
						getMinPrice();
					}
				});
			}
		});
	});
</script>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${auctionDto.auctionWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="row reply-box">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content form-input"></div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row">
		<textarea class="row reply-edit-content form-input w-100">수정</textarea>
	</div>
	<div class="row right">
		<button class="form-btn neutral confirm-edit">수정</button>
		<button class="form-btn neutral cancle-edit">취소</button>
	</div>
</script>
<script src="/static/js/like.js"></script>
<div class="container-800 mt-50">
	<div class="row">
	제목 : ${auctionDto.auctionTitle}
	</div>
	<div class="row">
	마감 기한 : ${auctionDto.auctionFinishTime}
	</div>
	<div class="row">
	최고 입찰 가격 : <span class="min-bid-price"></span>
	</div>
	<div class="row">
	즉시 입찰 가격 : <span class="max-bid-price"></span>
	</div>
	<div class="row">
	조회수 : ${auctionDto.auctionRead}
	</div>
	<div class="row">
	내용
		<!-- 좋아요 -->
		<div class="right user-like"><i class="fa-regular fa-heart"></i></div>
		<div class="row form-input w-100" style="min-height:200px">${auctionDto.auctionContent}</div>
	</div>
	<div class="row">
	글쓴이 : ${auctionDto.auctionWriter}
	</div>
	<form class="form-bid">
		<input type="hidden" name="auctionBidOrigin" value="${auctionDto.allboardNo}">
		<input type="hidden" name="auctionBidMember" value="${sessionScope.memberId}">
		<input class="form-input" name="auctionBidPrice">
		<button type="button" class="form-btn neutral bid-btn">입찰</button>
	</form>

<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
	<hr>
		<textarea class="form-input w-100 reply-textarea"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<a href="delete?allboardNo=${auctionDto.allboardNo}&page=${param.page}" class="form-btn neutral">삭제</a>
		<a href="list?page=${param.page}" class="form-btn neutral">목록</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>