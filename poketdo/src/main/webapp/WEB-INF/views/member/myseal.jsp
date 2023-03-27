<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>내 인장 목록</h1>
<table>
	<thead>
		<tr>
			<th>소유 번호</th>
			<th>이미지</th>
			<th>인장 번호</th>
			<th>인장 이름</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="mySeal" items="${list}" varStatus="status"> 
			<tr>
				<td>
					${status.index+1}
				</td>
				<td>
					<img width="96" height="96"
							src="/attachment/${mySeal.imageURL}">
				</td>
				<td>
					${mySeal.sealNo}
				</td>
				<td>
					${mySeal.sealName}
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>