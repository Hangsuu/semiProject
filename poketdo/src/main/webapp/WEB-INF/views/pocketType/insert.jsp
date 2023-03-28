<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<h1>등록페이지</h1>
	<form action="insertProcess" method="post" enctype="multipart/form-data">
		<label>포켓몬스터 속성 번호</label>
		<input name="pocketTypeNo">
		<br>
		<label>포켓몬스터 속성 이름</label>
		<input name="pocketTypeName">
		<br>
		<label>포켓몬스터 속성 이미지(png, gif, jpg)</label>
		<input type="file" name="attach" accept=".png, .gif, .jpg">
		<br>
		<button>입력 완료</button>
	</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>