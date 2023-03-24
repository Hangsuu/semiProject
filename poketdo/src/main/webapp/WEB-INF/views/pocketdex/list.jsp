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
			<c:forEach var="pocketDexDto"  items="${list3}">
				<tr>
					<td>
					${pocketDexDto.pocketNo}
					</td>
					<td>${pocketDexDto.pocketName}</td>
					<td>
						<c:forEach var="i" begin="0" end="${pocketDexDto.getPocketTypes().size()-1}">
							<c:choose>
								<c:when test="${i==pocketDexDto.getPocketTypes().size()-1}">
									${pocketDexDto.getPocketTypes().get(i)}
								</c:when>
								<c:otherwise>
									${pocketDexDto.getPocketTypes().get(i)},
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
					<td>
						<a href="edit?monsterNo=${pocketDexDto.pocketNo}" >수정</a>
						<a href="delete?monsterNo=${pocketDexDto.pocketNo}" >삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">포켓몬스터 신규 등록</a>
</body>
</html>