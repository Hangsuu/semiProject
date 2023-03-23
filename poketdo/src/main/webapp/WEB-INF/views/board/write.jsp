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
    
      <c:if test="${sessionScope.memberLevel == '마스터'}">
<script type="text/javascript">
	function checkAll(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
		for(var i = 0; i < checkboxes.length; i++){
			checkboxes[i].checked = allCheckbox.checked;
		}
	}
	function checkUnit(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
		var count = 0;
		for(var i = 0; i < checkboxes.length; i++){
			if(checkboxes[i].checked){
				count++;
			}
		}
		allCheckbox.checked = (checkboxes.length == count);
	}
	function formCheck(){
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]:checked")
		if(checkboxes.length == 0) return false;
		
		return confirm("정말 삭제하시겠습니까?");
	}
</script>
</c:if>

    <form action="write" method="post" autocomplete="off">
        <div class="container-800">
            <div class="row center">
                <h1>게시글 작성</h1>
            </div>

            <div class="row">
                <label>말머리</label>
                <select name="boardHead">
                <option value="">없음</option>
                <c:if test="${memberLevel == '마스터'}">
                    <option>공지</option>
                </c:if>
                <option>자유</option>
                </select>
            </div>

            <div class="row">
                <input type="text" name="boardTitle" required placeholder="제목을 입력하세요." class="form-input w-100">
            </div>
            <div class="row">
                <textarea name="boardContent"></textarea>
            </div>

            <div class="row">
                <button type="submit" class="form-btn positive w-100">등록</button>
            </div>
            <div class="row">
            <a class="form-btn neutral w-100" href="list">목록</a>
        	</div>
        </div>
    </form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>