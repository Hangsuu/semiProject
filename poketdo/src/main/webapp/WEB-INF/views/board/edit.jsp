<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
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
            <div class="row center">
                <h1>${boardDto.boardNo}번글 수정</h1>
            </div>

            <div class="row">
                <label>말머리</label>
                <select name="boardHead">
                <option value="">없음</option>
                <c:if test="${memberLevel == '관리자'}">
                    <option>공지</option>
                </c:if>
                <option>자유</option>
                <option>인기</option>
                </select>
            </div>

            <div class="row">
            	<label>제목</label>
                <input type="text" name="boardTitle" required placeholder="제목을 입력하세요." class="form-input w-100"></div>
            <div class="row">
                <textarea name="boardContent"></textarea>
            </div>

            <div class="row">
                <button type="submit" class="form-btn positive w-100">등록</button>
            </div>
        </div>
    </form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>