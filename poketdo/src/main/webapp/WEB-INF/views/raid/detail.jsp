<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${raidDto.raidWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="row reply-box">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content form-input"></div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row">
		<textarea class="row reply-edit-content form-input w-100">수정</textarea>
	</div>
	<div class="row right">
		<button class="form-btn neutral confirm-edit">수정</button>
		<button class="form-btn neutral cancle-edit">취소</button>
	</div>
</script>
<script src="/static/js/like.js"></script>
<div class="container-800 mt-50">
	<div class="row">
	제목 : [${raidDto.raidMonster}]${raidDto.raidTitle}
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
		<div class="float-box">
			<div class="left">내용</div>
	<!-- 좋아요 -->
			<div class="right user-like"><i class="fa-regular fa-heart"></i></div>
		</div>
		<div class="row form-input w-100" style="min-height:150px">
		${raidDto.raidContent}
		</div>
	</div>

<!-- 레이드 참가 신청 -->
	<div class="row">
		<form action="join" method="post">
			<input type="hidden" name="raidJoinRaid" value="${raidDto.allboardNo}">
			<input type="hidden" name="raidJoinParticipant" value="${sessionScope.memberId}">
			<input type="hidden" name="raidJoinConfirm" value="${raidDto.raidType}">
			<input type="hidden" name="allboardNo" value="${raidDto.allboardNo}">
			<input class="form-input w-100" name="raidJoinContent">
			<button class="form-bnt neutral">참가</button>
		</form>
		<hr>
	</div>
<!-- 레이드 참가 신청 끝 -->
<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
	<hr>
		<textarea class="form-input w-100 reply-textarea"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<a href="list?page=${param.page}" class="form-btn neutral">목록</a>
		<a href="delete?page=${param.page}&allboardNo=${raidDto.allboardNo}" class="form-btn neutral">삭제</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>