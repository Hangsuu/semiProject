<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${combinationDto.combinationWriter}";
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="row reply-box">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content form-input"></div>
	</div>
</script>
<!-- 댓글창 템플릿 -->
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
	제목 : [${combinationDto.combinationType}]${combinationDto.combinationTitle}
	</div>
	<div class="row">
		<div class="float-box">
			<div class="left" style="display:inline-block">내용</div>
	<!-- 좋아요 -->
			<div class="float-right user-like ms-30" style="display:inline-block"><i class="fa-regular fa-heart"></i></div>
	<!-- 태그칸 -->
			<div class="float-right tag-place" style="display:inline-block">
				<c:forEach var="tags" items="${tagDto}">
					<a href="list?page=1&column=tag&keyword=${tags.tagName}" class="link"><i class="form-input">${tags.tagName}</i></a>
				</c:forEach>
			</div>
		</div>
		<div class="row form-input w-100" style="min-height:150px">
		${combinationDto.combinationContent}
		</div>
	</div>

<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
	<hr>
		<textarea class="form-input w-100 summernote-reply"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<c:choose>
			<c:when test="${param.tagList.length()>=0}">
				<a href="simulator?page=${param.page}&tagList=${param.tagList}" class="form-btn neutral">조합시뮬레이터로 이동</a>
			</c:when>
			<c:otherwise>
				<a href="list?page=${param.page}" class="form-btn neutral">목록</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${sessionScope.memberId==combinationDto.combinationWriter}">
			<a href="delete?page=${param.page}&allboardNo=${combinationDto.allboardNo}" class="form-btn neutral">삭제</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>