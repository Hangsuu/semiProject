<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포켓몬스터 속성 목록</title>
</head>
<body>
	<h1>포켓몬스터 속성 목록</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pocketmonTypeDto" items="${list}">
				<tr>
					<td>
					${pocketmonTypeDto.pocketTypeNo}
					</td>
					<td>
					${pocketmonTypeDto.pocketTypeName}
					</td>
					<td>
						<a href="edit?pocketTypeNo=${pocketmonTypeDto.pocketTypeNo}">수정</a>
						<a href="delete?pocketTypeNo=${pocketmonTypeDto.pocketTypeNo}">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">포켓몬스터 속성 신규 등록</a>
</body>
</html>