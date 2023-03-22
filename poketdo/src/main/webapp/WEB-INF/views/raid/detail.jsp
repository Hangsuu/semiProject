<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-800 mt-50">
	<div class="row">
	제목 : [${raidDto.raidMonster}]${raidDto.raidTitle}
	</div>
	<div class="row">
	내용 : ${raidDto.raidContent}
	</div>
	<div class="row">
	글쓴이 : ${raidDto.raidWriter}
	</div>
	<div class="row">
	타입 : ${raidDto.raidType}
	</div>
	<div class="row">
	참가자 : ${count}/4
	</div>
	<div class="row">
		<form action="join" method="post">
			<input type="hidden" name="raidJoinRaid" value="${raidDto.seqNo}">
			<input type="hidden" name="raidJoinParticipant" value="${sessionScope.memberId}">
			<input type="hidden" name="raidJoinConfirm" value="${raidDto.raidType}">
			<input type="hidden" name="seqNo" value="${raidDto.seqNo}">
			<input class="form-input w-100" name="raidJoinContent">
			<button class="form-bnt neutral">참가</button>
		</form>
	</div>
	<div class="row">
		<a href="list?page=${param.page}" class="form-btn neutral">목록</a>
		<a href="delete?page=${param.page}&seqNo=${raidDto.seqNo}" class="form-btn neutral">삭제</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>