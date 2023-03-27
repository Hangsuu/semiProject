<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<h1>등록페이지</h1>
	<form action="insertProcess" method="post" enctype="multipart/form-data">
		<label>인장 번호</label>
		<input name="sealNo">
		<br>
		<label>인장 이름</label>
		<input name="sealName">
		<br>
		<label>인장 이미지(png, gif, jpg)</label>
		<input type="file" name="attach" accept=".png, .gif, .jpg">
		<br>
		<button>입력 완료</button>
	</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>