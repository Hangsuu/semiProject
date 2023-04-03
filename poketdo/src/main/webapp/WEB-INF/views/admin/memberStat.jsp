<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>  

<div class = "container-1000">
	<div class="row center">
		<h2>회원 현황</h2>
	</div>

	<!--  각종 정렬과 관련된 링크들 -->
	<div class="row right">
		<a class="link" href="memberStat">등급 순</a>
		<a class="link" href="memberStat?sort=cnt desc">인원많은 순</a>
		<a class="link" href="memberStat?sort=cnt asc">인원적은 순</a>
		<a class="link" href="memberStat?sort=total desc">포인트 합계↓</a>
		<a class="link" href="memberStat?sort=total asc">포인트 합계↑</a>
	</div>

	<div class="row">
		<table class="table table-slit">
			<thead>
				<tr>
					<th>등급</th>
					<th>인원수</th>
					<th>포인트합계</th>
					<th>포인트평균</th>
					<th>최대포인트</th>
					<th>최소포인트</th>
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
</div>
			</article>
     </section>
     </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>