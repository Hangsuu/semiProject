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
<script src="${pageContext.request.contextPath}/static/js/reply.js"></script>
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
<script src="${pageContext.request.contextPath}/static/js/like.js"></script>

<!-- 내용 시작 -->
<div class="container-1000 mt-50">
	<div class="row flex-box">
		<span class="board-detail-origin">공략 게시판</span>
		<a href="${pageContext.request.contextPath}list?page=${param.page}&${vo.tagParameter}" class="board-detail-btn align-right">목록</a>
	</div>
	<div class="row board-detail-title">
		[${combinationDto.combinationType}] ${combinationDto.combinationTitle}
	</div>
	<div class="row flex-box">
		<div class="row" style="vertical-align:center; display:inline-block">
			<span class="combination-writer">
			<!-- 작성자 검색 링크 -->
				<a href="${pageContext.request.contextPath}list?page=1&column=member_nick&keyword=${combinationDto.memberNick}" class="link">
					<img class="board-seal" src="${pageContext.request.contextPath}${combinationDto.urlLink}" style="vertical-align:middle"><span style="vertical-align:middle">${combinationDto.memberNick}</span>
				</a>
			</span>
			<span class="board-detail-time" style="vertical-align:middle">${combinationDto.boardTime}</span>
			<!-- 작성자와 memberId가 같으면 수정, 삭제 버튼 생김 -->
			<c:if test="${sessionScope.memberId==combinationDto.combinationWriter}">
				<a href="${pageContext.request.contextPath}edit?page=${param.page}&allboardNo=${combinationDto.allboardNo}&tagList=${tagList}" class="board-detail-btn" style="vertical-align:middle">수정</a>
				<a href="${pageContext.request.contextPath}delete?page=${param.page}&allboardNo=${combinationDto.allboardNo}" class="board-detail-btn delete-btn" style="vertical-align:middle">삭제</a>
			</c:if>
			<c:if test="${sessionScope.memberLevel=='관리자'}">
				<a href="${pageContext.request.contextPath}delete?page=${param.page}&allboardNo=${combinationDto.allboardNo}" class="board-detail-btn delete-btn" style="vertical-align:middle">삭제</a>
			</c:if>
		</div>
		<div class="row align-right">
			조회수 : ${combinationDto.combinationRead}
		</div>
	</div>
<!-- 본문 시작 -->
	<div class="row" style="border-top:3px solid #f2f4fb; border-bottom: 3px solid #f2f4fb">
	<!-- 태그칸 -->
		<div class="tag-place mt-10" style="display:inline-block">
			<c:forEach var="tags" items="${tagDto}">
				<a href="${pageContext.request.contextPath}list?page=1&column=tag&keyword=${tags.tagName}" class="hash-tag">#${tags.tagName}</a>
			</c:forEach>
		</div>
		<!-- 본문 -->
		<div class="row w-100 do-not-over mt-20" style="min-height:400px; padding-left:1em; padding-right:1em">${combinationDto.combinationContent}</div>
		<div class="row">
			<a href="${pageContext.request.contextPath}list?page=1&column=member_nick&keyword=${combinationDto.memberNick}" class="link">${combinationDto.memberNick}님의 게시글 더 보기</a>
		</div>
		<div class="row">
		<!-- 좋아요 -->
			<div class="left like-box" style="display:inline-block">
				<i class="fa-heart detail-like"></i>
				좋아요 :<span class="like-count" style="margin-left:0.5em">${combinationDto.combinationLike}</span>
			</div>
		<!-- 댓글 개수 댓글 span(class=reply-count)에 카운트 처리되도록 함-->
			<div class="reply-number-box" style="display:inline-block">
				댓글 :<span class="reply-count" style="margin-left:0.5em">${combinationDto.combinationReply}</span>
			</div>
		</div>
	</div>
<!-- 본문 끝 -->
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
<!-- 마지막 줄 -->
	<div class="row flex-box">
		<div class="row">
			<a href="${pageContext.request.contextPath}write" class="board-detail-btn">글쓰기</a>
		</div>
		<div class="row align-right">
			<a href="${pageContext.request.contextPath}list?page=${param.page}&${vo.tagParameter}" class="board-detail-btn align-right">목록</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>