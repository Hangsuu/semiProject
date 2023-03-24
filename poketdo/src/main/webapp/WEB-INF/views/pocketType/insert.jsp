<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포켓몬스터 속성 등록</title>
</head>
<body>
	<h1>등록페이지</h1>
	<form action="insertProcess" method="post">
		<label>포켓몬스터 속성 번호</label>
		<input name="pocketTypeNo">
		<br>
		<label>포켓몬스터 속성 이름</label>
		<input name="pocketTypeName">
		<br>
		<button>입력 완료</button>
	</form>
</body>
</html>