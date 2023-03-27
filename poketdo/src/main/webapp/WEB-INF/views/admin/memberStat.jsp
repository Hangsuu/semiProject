<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>  

<div class = "container-800">
	<div class="row center">
		<h2>ȸ�� ��Ȳ</h2>
	</div>
</div>

<!--  ���� ���İ� ���õ� ��ũ�� -->
<div class="row right">
	<a class="link" href="member">��޼�</a>
	<a class="link" href="member?sort=cnt desc">�ο����� ��</a>
	<a class="link" href="member?sort=cnt asc">�ο����� ��</a>
	<a class="link" href="member?sort=total desc">����Ʈ �հ��</a>
	<a class="link" href="member?sort=total asc">����Ʈ �հ��</a>
</div>

<div class="row">
	<table class="table table-slit">
		<thead>
			<tr>
				<th>���</th>
				<th>�ο���</th>
				<th>����Ʈ�հ�</th>
				<th>����Ʈ���</th>
				<th>�ִ�����Ʈ</th>
				<th>�ּ�����Ʈ</th>
			</tr>
		</thead>
		<tbody class="right">
			<c:forEach var="memberStatDto" items="${list}">
			<tr>
				<td class="center">${memberStatDto.memberLevel}</td>
				<td>
						<fmt:formatNumber value="${memberStatDto.cnt}" pattern="#,##0"></fmt:formatNumber>
					</td>
					<td>
						<fmt:formatNumber value="${memberStatDto.total}" pattern="#,##0"></fmt:formatNumber>
					</td>
					<td>
						<fmt:formatNumber value="${memberStatDto.average}" pattern="#,##0.00"></fmt:formatNumber>
					</td>
					<td>
						<fmt:formatNumber value="${memberStatDto.max}" pattern="#,##0"></fmt:formatNumber>
					</td>
					<td>
						<fmt:formatNumber value="${memberStatDto.min}" pattern="#,##0"></fmt:formatNumber>
					</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>