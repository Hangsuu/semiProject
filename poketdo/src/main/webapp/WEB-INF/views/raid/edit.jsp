<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${raidDto.raidWriter}";
</script>
<script src="${pageContext.request.contextPath}/static/js/timer.js"></script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/summernote.js"></script>
<div class="container-900 mt-50">
<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="allboardNo" value="${raidDto.allboardNo}">
	<!-- 제목 -->
	<div class="row">
		<input class="form-input center neutral" readonly value="제목" style="width:100px"><input class="form-input" name="raidTitle" value="${raidDto.raidTitle}" style="width:88%">
	</div>
	<!-- 타입 -->
	<div class="row">
		<select class="form-input neutral center" name="raidType" style="width:100px">
			<option value='0'>모집</option>
			<option value='1'>선착순</option>
		</select>
	<!-- 시간 -->
		<input class="form-input set-date" type="datetime-local">
	</div>
	<!-- 몬스터 -->
	<div class="row">
		<input class="form-input center neutral" readonly value="몬스터" style="width:100px"><input class="form-input w-40" name="raidMonster" value="${raidDto.raidMonster}">
	</div>
	<!-- 레이드코드 -->
	<div class="row">
		<input class="form-input center neutral" readonly value="레이드코드" style="width:100px"><input class="form-input w-40" name="raidCode" value="${raidDto.raidCode}">
	</div>
	<!-- 내용 -->
	<div class="row">
		<textarea class="row form-input w-100 summernote" style="min-height:200px" name="raidContent">${raidDto.raidContent}</textarea>
	</div>
	<button class="form-btn neutral w-20"><i class="fa-solid fa-pen-to-square me-10"></i>수정</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>