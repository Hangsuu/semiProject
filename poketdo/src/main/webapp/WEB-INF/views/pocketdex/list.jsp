<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


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
			<c:forEach var="pocketmonDto"  items="${list3}">
				<tr>
					<td>
					${pocketmonDto.pocketNo}
					</td>
					<td>
						<a href="detail?pocketNo=${pocketmonDto.pocketNo}">
							${pocketmonDto.pocketName}
						</a>
					</td>
					<td>
						<c:forEach var="i" begin="0" end="${pocketmonDto.getPocketTypes().size()-1}">
							<c:choose>
								<c:when test="${i==pocketmonDto.getPocketTypes().size()-1}">
									${pocketmonDto.getPocketTypes().get(i)}
								</c:when>
								<c:otherwise>
									${pocketmonDto.getPocketTypes().get(i)},
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
					<td>
						<a href="edit?monsterNo=${pocketmonDto.pocketNo}" >수정</a>
						<a href="delete?monsterNo=${pocketmonDto.pocketNo}" >삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">포켓몬스터 신규 등록</a>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>