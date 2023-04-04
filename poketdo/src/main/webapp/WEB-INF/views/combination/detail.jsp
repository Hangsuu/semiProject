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
	
	$(".delete-btn").click(function(event){
		if(!confirm("정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
			event.preventDefault();
			return;
		}
		else{
			window.location.href=$(this).attr("href");
		}
	})	
})
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/reply.js"></script>
<!-- 댓글창 템플릿 -->
<script type="text/template" id="reply-template">
	<div class="row reply-box flex-box">
		<div class="remove-box" style="width:5%">
			<div class="align-center center" style="padding-top:1em">
				<i class="fa-solid fa-reply fa-flip-both" style="font-size:16px"></i>
			</div>
		</div>
		<div class="align-right remain-box" style="width:95%">
			<div class="row flex-box" style="align-items:center">
				<div class="reply-writer"></div>
				<div class="reply-time ms-20" style="font-size:14px"></div>
				<div class="align-right reply-option me-20"></div>
				<div class="left reply-like-box">
					<i class="fa-heart reply-like"></i>
					<span class="reply-like-count"></span>
				</div>
			</div>
			<div class="row reply-content" style="padding-left:1em"></div>
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
	<div class="row reply-best-target">
	</div>
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row mt-30">
		<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<a href="list?page=${param.page}&tagList=${param.tagList}&column=${param.column}&keyword=${param.keyword}" class="form-btn neutral"><i class="fa-solid fa-rectangle-list me-10"></i>목록으로</a>
		<c:if test="${sessionScope.memberId==combinationDto.combinationWriter}">
			<a href="delete?page=${param.page}&allboardNo=${combinationDto.allboardNo}" class="form-btn negative delete-btn"><i class="fa-solid fa-trash-can me-10" style="color:white"></i>삭제</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>