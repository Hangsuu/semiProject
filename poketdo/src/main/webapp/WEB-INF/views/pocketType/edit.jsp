<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/pocket-type-edit.js"></script>

<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">
	
	<form action="editProcess" method="post" enctype="multipart/form-data" class="form pocket-form">
		<div class="pocket-input-container" >
			<div>
				<h1>포켓몬스터 타입 정보 수정 페이지</h1>
			</div>
			<div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 타입 번호 : ${PocketmonTypeDto.pocketTypeNo}</span>
					</div>
					<div class="pocket-input-box">
						<input type="hidden" name="pocketTypeNo" value=" ${PocketmonTypeDto.pocketTypeNo}">
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 타입 이름</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketTypeName" value="${PocketmonTypeDto.pocketTypeName}" class="form-input" >
						<span class="valid-message">사용 가능한 이름입니다!</span>
						<span class="invalid-message">필수 입력 항목입니다!</span>						
						<span class="invalid-message2">이미 사용중인 이름입니다!</span>
					</div>
				</div>	
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 이미지(png, gif, jpg)</span>
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