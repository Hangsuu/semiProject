<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/seal-insert.js"></script>

<script type="text/javascript">
	$(function () {
		$(".selectPoint").change(function(){
			var selectValue = $(this).val();
			$(".selectTarget2").text("입금 하실 금액");
			$(".selectTarget").text(selectValue+"원");
		});

	});
</script>

<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">

	<form action="requestPoint" method="post" enctype="multipart/form-data" class="form point-form">
		<div class="pocket-input-container" >
			<div>
				<h1>포인트 요청서</h1>
			</div>	
			<div class="mb-50">
				<h3>입금 계좌</h3>
				<h3>KH은행 2023-04-04</h3>
				<h3>예금주 : POCKETDO</h3>
				<h2 class="selectTarget2"></h2>
				<h2 class="selectTarget"></h2>
			</div>	
			<div>
				<div>
					<div class="pocket-input-box">
						<span>글쓴이</span>
					</div>
					<div class="pocket-input-box">
						<span>${sessionScope.memberId}</span>
					</div>
				</div>	
				<div>
					<div class="pocket-input-box">
						<span>입금자 명</span>
					</div>		
					<div class="pocket-input-box">
						<input name="writerName" class="form-input" >
						<input type="hidden" name="point_board_head" class="form-input" value="0">		
					</div>
				</div>
				
				<div>
					<div class="pocket-input-box">
						<span>요청 포인트</span>
					</div>
					<div class="pocket-input-box">
						<select name="requestPoint" class="form-input neutral selectPoint">
							  <option value="0" selected>0</option>
							  <option value="10000" >10000</option>
							  <option value="30000">30000</option>
							  <option value="50000">50000</option>
							  <option value="100000">100000</option>
						</select>
					</div>
				</div>
				<div>				
					<div class="pocket-input-box">
						<span>입금 하실 금액</span>
					</div>
					<div class="pocket-input-box">
						<span class="selectTarget"></span>
					</div>
				</div>
				<div>
					<div>
						<button class="form-btn positive">입력 완료</button>
					</div>
				</div>	
			</div>	
			</div>
	</form>
	</article>
	
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>