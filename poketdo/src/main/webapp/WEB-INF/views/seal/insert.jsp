<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/seal-insert.js"></script>

<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">

	<form action="insertProcess" method="post" enctype="multipart/form-data" class="form seal-form">
		<div class="pocket-input-container" >
			<div>
				<h1>인장 신규 등록</h1>
			</div>	
			<div>	
				<div>
					<div class="pocket-input-box">
						<span>인장 번호</span>
					</div>		
					<div class="pocket-input-box">		
						<input name="sealNo" class="form-input" >
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
						<span class="invalid-message2">이미 사용중인 번호입니다!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>인장 이름</span>
					</div>
					<div class="pocket-input-box">
						<input name="sealName" class="form-input" >
						<span class="valid-message">사용 가능한 이름입니다!</span>
						<span class="invalid-message">필수 입력 항목입니다!</span>						
						<span class="invalid-message2">이미 사용중인 이름입니다!</span>						
					</div>
				</div>				
				<div>
					<div class="pocket-input-box">
						<span>인장 가격</span>
					</div>
					<div class="pocket-input-box">
						<input name="sealPrice" class="form-input" >
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>						
					</div>
				</div>				
				<div>
					<div class="pocket-input-box" >
						<span>인장 이미지(png, gif, jpg)</span>
					</div>
					<div class="pocket-input-box">
						<input type="file" name="attach" accept=".png, .gif, .jpg" class="form-input" >
					</div>
				</div>
					<div>
						<button class="form-btn positive">입력 완료</button>
					</div>
				</div>	
			</div>	
	</form>
	</article>
	
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>