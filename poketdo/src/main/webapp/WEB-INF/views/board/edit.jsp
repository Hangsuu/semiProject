<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    
    
    <!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
	$(function(){
		$('[name=boardContent]').summernote({
            placeholder: '내용 작성',
            tabsize: 4,
            height: 250,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
            ]
        });
	});	
    </script>

    <form action="edit" method="post">
        <div class="container-800">
            <!-- 제목 -->
			<div class="row center">
				<h2>${boardDto.boardNo}번 게시글 수정</h2>
			</div>
	
			<div class="row">
		<label class="form-label w-100">말머리</label>
			<c:choose>
				<c:when test="${boardDto.boardHead == '없음'}">
					<select name="boardHead" class="form-input">
						<option selected value="">없음</option>
						<c:if test="${memberLevel == '관리자'}">
						<option>공지</option>
						</c:if>
						<option>자유</option>
					</select>
				</c:when>
				<c:when test="${boardDto.boardHead == '자유'}">
					<select name="boardHead" class="form-input">
						<option value="">없음</option>
						<c:if test="${memberLevel == '관리자'}">
						<option>공지</option>
						</c:if>
						<option selected>자유</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="boardHead" class="form-input">
						<option value="">없음</option>
						<c:if test="${memberLevel == '관리자'}">
						<option selected>공지</option>
						</c:if>
						<option>자유</option>
					</select>
				</c:otherwise>
			</c:choose>
			</div>
			
			<div class="row">
		<label>제목<i class="fa-solid fa-asterisk"></i></label>
		<input type="text" name="boardTitle" required class="form-input w-100" value="${boardDto.boardTitle}">
	</div>
	
	<div class="row">
		<label>내용<i class="fa-solid fa-asterisk"></i></label>
		<textarea name="boardContent" required class="form-input w-100" style="min-height: 300px;">${boardDto.boardContent}</textarea>
	</div>
	
	<div class="row">
		<button type="submit" class="form-btn positive w-100">변경</button>
	</div>
	
		</div>
	</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>