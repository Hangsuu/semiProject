<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!-- 모먼트 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${boardWithNickDto.boardWriter}";
	var allboardNo = "${boardWithNickDto.allboardNo}";
</script>

<script>
$(function(){
	$(".delete-btn").click(function(event){
		if(!confirm("정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
			event.preventDefault();
			return;
		}
		else{
			window.location.href=$(this).attr("href");
		}
	})	
});
</script>
 <script src="${pageContext.request.contextPath}/static/js/timer.js"></script> 
 <script src="${pageContext.request.contextPath}/static/js/board/board-like.js"></script> 
 <script src="${pageContext.request.contextPath}/static/js/board/board-reply.js"></script> 
 <!-- 댓글장 템플릿 -->
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

<!-- section -->
<section>

	<!-- aside -->
	<aside></aside>
	<!-- article -->
	<article class="container-900">
		<div class="row flex-box">
			<h1>자유 게시판</h1>
			<a href="${pageContext.request.contextPath}/board/list" class="board-detail-btn align-right">목록</a>
		</div>
		<div class="row flex-box">
			<h1>
				<c:if test="${boardWithNickDto.boardHead != null}">
          [${boardWithNickDto.boardHead}] 
        </c:if>
				${boardWithNickDto.boardTitle}
			</h1>
		</div>
		<div class="row flex-box">
			<div>
				<a class="link"
					href="${pageContext.request.contextPath}/board/list?column=member_nick&keyword=${boardWithNickDto.memberNick}">
					<img class="board-seal" src="${boardWithNickDto.urlLink}">${boardWithNickDto.memberNick} </a>
				<span>/</span>
				<fmt:formatDate value="${boardWithNickDto.boardTime}"
					pattern="yyyy.MM.dd.H:m" />
				<!-- 작성자와 memberId가 같으면 수정, 삭제 버튼 생김 -->
				<c:if test="${sessionScope.memberId==boardWithNickDto.boardWriter}">
					<a
						href="${pageContext.request.contextPath}/board/edit?allboardNo=${boardWithNickDto.allboardNo}"
						class="board-detail-btn">수정</a>
					<a
						href="${pageContext.request.contextPath}/board/delete?allboardNo=${boardWithNickDto.allboardNo}"
						class="board-detail-btn">삭제</a>
				</c:if>
			</div>
			<div class="board-detail-count align-right">
				조회수 : <span class="board-detail-read-count">${boardWithNickDto.boardRead}</span>
			</div>
		</div>
		<hr />
		<div class="row boardContent w-100" style="min-height: 400px">
			<div>${boardWithNickDto.boardContent}</div>
		</div>
		<div class="row">
			<div>
				<a class="link"
					href="${pageContext.request.contextPath}/board/list?column=member_nick&keyword=${boardWithNickDto.memberNick}"><b>${boardWithNickDto.memberNick}</b>님의게시글 더 보기</a>
			</div>
		</div>

		<!-- 좋아요 댓글 신고 -->
		<div class="row">
			<!-- 좋아요 -->
			<div class="left like-box" style="display: inline-block">
				<i class="fa-heart detail-like"></i> 좋아요 :<span class="like-count"
					style="margin-left: 0.5em">${boardWithNickDto.boardLike}</span>
			</div>
			<!-- 댓글 개수 댓글 span(class=reply-count)에 카운트 처리되도록 함-->
			<div class="reply-number-box" style="display: inline-block">
				댓글 :<span class="reply-count" style="margin-left: 0.5em">${boardWithNickDto.boardReply}</span>
			</div>
		</div>
		<hr>
		<!-- 댓글 -->
		<!-- 표시 -->
		<div class="row reply-best-target"></div>
		<div class="row reply-target"></div>
		<!-- 쓰기 -->
		<div class="row mt-30">
			<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
		</div>
		<!-- 댓글 끝 -->
		<!-- 마지막 줄 -->
		<div class="row flex-box">
			<div class="row">
				<a href="write" class="board-detail-btn">글쓰기</a>
			</div>
			<div class="row align-right">
				<a href="list"
					class="board-detail-btn align-right">목록</a>
			</div>
		</div>
	</article>
</section>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>