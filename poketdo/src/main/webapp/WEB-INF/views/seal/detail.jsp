<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>인장 상세페이지</h1>
<table>
	<thead>
		<tr>
			<th>이미지</th>
			<th>인장 번호</th>
			<th>인장 이름</th>
			<th>가격</th>
		</tr>
	</thead>
	<tbody>
		<tr>
					<td>
					<img width="96" height="96"
						src="${sealWithImageDto.imageURL}">
					</td>
					<td>
					${sealWithImageDto.sealNo}
					</td>
					<td>${sealWithImageDto.sealName}</td>
					<td>${sealWithImageDto.sealPrice}</td>
					<td>
						<a href="edit?sealNo=${sealWithImageDto.sealNo}" >수정</a>
						<a href="delete?sealNo=${sealWithImageDto.sealNo}" >삭제</a>
					</td>
				</tr>
	</tbody>
</table>
<a href="list">목록으로 이동</a>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>