<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<h1>인장 정보 수정 페이지</h1>
	
	<form action="editProcess" method="post" enctype="multipart/form-data">
		<label>인장 번호 : ${sealDto.sealNo}</label>
		<input type="hidden" name="sealNo" value=" ${sealDto.sealNo}">
		<br>
		<label>인장 이름</label>
		<input name="sealName" value="${sealDto.sealName}">
		<br>
		<label>인장 가격</label>
		<input name="sealPrice" value="${sealDto.sealPrice}">
		<br>
		<label>인장 이미지(png, gif, jpg)</label>
		<input type="file" name="attach" accept=".png, .gif, .jpg">
		<br>
		<button>수정 완료</button> 
	</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>