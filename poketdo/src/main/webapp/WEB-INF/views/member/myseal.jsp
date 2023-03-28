<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="mysealSelect" method="post">
	<h2>현재 적용 인장</h2>
	<img width="96" height="96" src="${selectAttachNo}">
	<h2>보유 인장 목록</h2>
	<table>
			<thead>
				<tr>
					<th>소유 번호</th>
					<th>선택</th>
					<th>이미지</th>
					<th>인장 번호</th>
					<th>인장 이름</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>
							0
						</td>
						<td>
							<input type="checkbox" name="mySealNo" value="0">
						</td>
						<td>
							<img width="96" height="96"
									src="${basicSealDto.imageURL}">
						</td>
						<td>
							${basicSealDto.sealNo}
						</td>
						<td>
							${basicSealDto.sealName}
						</td>
					</tr>
			
				<c:forEach var="mySeal" items="${list}"  varStatus="status"> 
					<tr>
						<td>
							${status.index+1}
						</td>
						<td>
							<input type="checkbox" name="mySealNo" value="${mySeal.mySealNo}">
						</td>
						<td>
							<img width="96" height="96"
									src="${mySeal.imageURL}">
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
	<button>선택 완료</button>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>