<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
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
            placeholder: '���� �ۼ�',
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
            <!-- ���� -->
			<div class="row center">
				<h2>${boardDto.boardNo}�� �Խñ� ����</h2>
			</div>
	
			<div class="row">
		<label class="form-label w-100">���Ӹ�</label>
			<c:choose>
				<c:when test="${boardDto.boardHead == '����'}">
					<select name="boardHead" class="form-input">
						<option selected value="">����</option>
						<c:if test="${memberLevel == '������'}">
						<option>����</option>
						</c:if>
						<option>����</option>
					</select>
				</c:when>
				<c:when test="${boardDto.boardHead == '����'}">
					<select name="boardHead" class="form-input">
						<option value="">����</option>
						<c:if test="${memberLevel == '������'}">
						<option>����</option>
						</c:if>
						<option selected>����</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="boardHead" class="form-input">
						<option value="">����</option>
						<c:if test="${memberLevel == '������'}">
						<option selected>����</option>
						</c:if>
						<option>����</option>
					</select>
				</c:otherwise>
			</c:choose>
			</div>
			
			<div class="row">
		<label>����<i class="fa-solid fa-asterisk"></i></label>
		<input type="text" name="boardTitle" required class="form-input w-100" value="${boardDto.boardTitle}">
	</div>
	
	<div class="row">
		<label>����<i class="fa-solid fa-asterisk"></i></label>
		<textarea name="boardContent" required class="form-input w-100" style="min-height: 300px;">${boardDto.boardContent}</textarea>
	</div>
	
	<div class="row">
		<button type="submit" class="form-btn positive w-100">����</button>
	</div>
	
		</div>
	</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>