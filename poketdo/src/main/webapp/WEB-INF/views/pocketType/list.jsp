<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<h1>포켓몬스터 속성 목록</h1>
	<table>
		<thead>
			<tr>
				<th>이미지</th>
				<th>번호</th>
				<th>이름</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="pocketmonTypeWithImageDto" items="${list}">
				<tr>
					<td style="background-color:gray;">
						<img width="200" height="200"
							src="/attachment/${pocketmonTypeWithImageDto.imageURL}">
					</td>
					<td>
					${pocketmonTypeWithImageDto.pocketTypeNo}
					</td>
					<td>
						<a href="detail?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}">
							${pocketmonTypeWithImageDto.pocketTypeName}
						</a>
					</td>
					<td>
						<a href="edit?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}">수정</a>
						<a href="delete?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">포켓몬스터 속성 신규 등록</a>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>