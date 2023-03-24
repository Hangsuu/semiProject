<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포켓몬스터 속성 정보 수정</title>
</head>
<body>
	<h1>포켓몬스터 속성 정보 수정 페이지</h1>
	<form action="editProcess" method="post">
		<label>포켓몬스터 속성 번호 : ${pocketmonTypeDto2.pocketTypeNo}</label>
		${pocketmonTypeDto2}
		<input type="hidden" name="pocketTypeNo" value=" ${pocketmonTypeDto.pocketTypeNo}">
		<br>
		<label>포켓몬스터 속성 이름 ${pocketmonTypeDto.pocketTypeName}</label>
		<input name="pocketTypeName" value=" ${pocketmonTypeDto.pocketTypeName}">
		<br>
		<button>수정 완료</button> 
	</form>
</body>
</html>