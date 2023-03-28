<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>상세 페이지~</h1>
<table>
	<thead>
		<tr>
			<th>이미지</th>
			<th>번호</th>
			<th>이름</th>
			<th>속성</th>
			<th>관리</th>
		</tr>
	</thead>
		<tbody>
			
				<tr>
					<td>
					<img width="200" height="200"
						src="${pocketmonWithImageDto.imageURL}">
					</td>
					<td>
					${pocketmonWithImageDto.pocketNo}
					</td>
					<td>${pocketmonWithImageDto.pocketName}</td>
					<td>
						<c:forEach var="i" begin="0" end="${pocketmonTypes.size()-1}">
							<c:choose>
								<c:when test="${i==pocketmonTypes.size()-1}">
									${pocketmonTypes.get(i)}
								</c:when>
								<c:otherwise>
									${pocketmonTypes.get(i)},
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
					<td>
						<a href="edit?pocketNo=${pocketmonWithImageDto.pocketNo}" >수정</a>
						<a href="delete?pocketNo=${pocketmonWithImageDto.pocketNo}" >삭제</a>
					</td>
				</tr>
		</tbody>
	</table>
	<a href="list">목록으로 이동</a>		
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>