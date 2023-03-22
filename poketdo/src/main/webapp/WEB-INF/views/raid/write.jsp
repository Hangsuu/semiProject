<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
<form action="write" method="post">
<input type="hidden" name="raidWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목 : <input class="form-input" name="raidTitle">
	</div>
	<div class="row">
		내용 : <input class="form-input" name="raidContent">
	</div>
	<div class="row">
		몬스터 : <input class="form-input" name="raidMonster">
	</div>
	<div class="row">
		날짜 : <input class="form-input" type="date" name="raidStartTime">
	</div>
	<div class="row">
		레이드타입 : <input class="form-input" name="raidType">
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>