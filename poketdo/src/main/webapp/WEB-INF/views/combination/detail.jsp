<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${combinationDto.combinationWriter}";
</script>
<script>
//색깔
$(function(){
	var tagColor = ["#F6FAFD", "#FFE5E5", "#FCF8E2", "#E4FBEB", "#E5EEFF"];
	var tagBorderColor = ["2px solid #D2EAF8", "2px solid #FFC6C6", "2px solid #FAF1C6", "2px solid #BBF5CE", "2px solid #DBE7FF"];
	$(".hash-tag").each(function(){
		var index = Math.floor(Math.random()*5);
		$(this).css("border", tagBorderColor[index]).css("background-color", tagColor[index]);
	})
	
})
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/reply.js"></script>
<!-- 댓글창 템플릿 -->
<script type="text/template" id="reply-template">
	<div class="row reply-box float-box">
		<div class="float-left remove-box" style="min-height:100px; width:5%">
			<div class="align-center">
				<i class="fa-solid fa-arrow-right-long" style="font-size:20px"></i>
			</div>
		</div>
		<div class="float-right remain-box" style="width:95%">
			<div class="row float-box">
				<div class="reply-writer float-left"></div>
				<div class="float-right left reply-like-box">
					<i class="fa-heart reply-like"></i>
					<span class="reply-like-count"></span>
				</div>
			</div>
			<div class="row reply-time"></div>
			<div class="row reply-content"></div>
		</div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row reply-edit">
		<textarea class="row reply-edit-content form-input w-100 summernote-reply-edit"></textarea>
	</div>
</script>
<script type="text/template" id="reply-child-template">
	<div class="row reply-child">
	<hr>
		<textarea class="form-input w-100 summernote-reply-child reply-textarea"></textarea>
	</div>
</script>
<script src="/static/js/like.js"></script>
<div class="container-1200 mt-50">
	<div class="row">
	제목 : [${combinationDto.combinationType}]${combinationDto.combinationTitle}
	</div>
	<div class="row">
		<div class="flex-box">
			<div class="left" style="display:inline-block">내용</div>
	<!-- 태그칸 -->
			<div class="tag-place" style="display:inline-block">
				<c:forEach var="tags" items="${tagDto}">
					<a href="list?page=1&column=tag&keyword=${tags.tagName}" class="hash-tag">${tags.tagName}</a>
				</c:forEach>
			</div>
	<!-- 좋아요 -->
			<div class="align-right like-box" style="display:inline-block">
				<i class="fa-heart detail-like"></i>
				<span class="like-count"></span>
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
		<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
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