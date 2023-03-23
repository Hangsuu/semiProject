<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포켓몬스터 목록</title>
</head>
<body>
	<h1>포켓몬스터 목록</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>속성</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pocketDexDto"  items="${list}">
				<tr>
					<td>
					${pocketDexDto.monsterNo}
					</td>
					<td>${pocketDexDto.monsterName}</td>
					<td>
						<c:forEach var="pocketWithTypeDto" items="${list2}">
							${pocketWithTypeDto.monsterTypeName}
						</c:forEach>
					</td>
					<td>
						<a href="edit?monsterNo=${pocketDexDto.monsterNo}" >수정</a>
						<a href="delete?monsterNo=${pocketDexDto.monsterNo}" >삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>