<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<h1>인장 목록</h1>
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
			<c:forEach var="sealWithImageDto" items="${list}">
				<tr>
					<td>
						<img width="200" height="200"
							src="/attachment/${sealWithImageDto.imageURL}">
					</td>
					<td>
					${sealWithImageDto.sealNo}
					</td>
					<td>
						<a href="detail?sealNo=${sealWithImageDto.sealNo}">
							${sealWithImageDto.sealName}
						</a>
					</td>
					<td>
						<a href="edit?sealNo=${sealWithImageDto.sealNo}">수정</a>
						<a href="delete?sealNo=${sealWithImageDto.sealNo}">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="insert">인장 신규 등록</a>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>