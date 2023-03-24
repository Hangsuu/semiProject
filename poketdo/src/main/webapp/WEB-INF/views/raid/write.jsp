<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>

<div class="container-800 mt-50">
<form action="write" method="post" autocomplete="off">
<input type="hidden" name="raidWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목 : <input class="form-input" name="raidTitle">
	</div>
	<div class="row">
		몬스터 : <input class="form-input" name="raidMonster">
	</div>
	<div class="row">
		날짜 : <input class="form-input" type="date" name="raidStartTime">
	</div>
	<div class="row">
		레이드타입 : <select class="form-input" name="raidType">
			<option value='0'>모집</option>
			<option value='1'>선착순</option>
		</select>
	</div>
	<div class="row w-100">
		<textarea name="raidContent" rows="10" class="form-input w-100 summernote"></textarea>
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>