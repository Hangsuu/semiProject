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
            <div class="row center">
                <h1>${boardDto.boardNo}���� ����</h1>
            </div>

            <div class="row">
                <label>���Ӹ�</label>
                <select name="boardHead">
                <option value="">����</option>
                <c:if test="${memberLevel == '������'}">
                    <option>����</option>
                </c:if>
                <option>����</option>
                <option>�α�</option>
                </select>
            </div>

            <div class="row">
            	<label>����</label>
                <input type="text" name="boardTitle" required placeholder="������ �Է��ϼ���." class="form-input w-100"></div>
            <div class="row">
                <textarea name="boardContent"></textarea>
            </div>

            <div class="row">
                <button type="submit" class="form-btn positive w-100">���</button>
            </div>
        </div>
    </form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>