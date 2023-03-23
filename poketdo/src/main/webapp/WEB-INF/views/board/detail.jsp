<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
    
	<div class="container-800">
        <div class="row center">
            <h2>${boardDto.boardNo}�� �Խñ�</h2>
        </div>
        
        <div class="row">
            <h3 style="color:gray;">${boardDto.boardHead}</h3>
        </div>
        
        <div class="row">
            <h3>${boardDto.boardTitle}</h3>
        </div>
        <hr>
        <div class="row">
            ${boardDto.boardWriter}
        </div>
        <hr>
        <div class="row">
            <fmt:formatDate value="${boardDto.boardTime}" 
                                            pattern="y�� M�� d�� H�� m�� s��"/>
                    ��ȸ ${boardDto.boardRead}
        </div>
        <hr>
        <div class="row" style="min-height:200px;">
            ${boardDto.boardContent}
        </div>
        <hr>
        <div class="row">
            ���ƿ� 
            <span class="heart-count">${boardDto.boardLike}</span>
            
            <c:if test="${sessionScope.memberId != null}">
            <!-- ��Ʈ�ڸ� -->
            <i class="fa-heart"></i>
            </c:if>
            
            �Ⱦ��
            <span class="bad-count">${boardDto.boardDislike}</span>
            
            ��� 
            <span class="reply-count">${boardDto.boardReply}</span>
        </div>
        <hr>
        <div class="row reply-list">
            ��۸�� ��ġ
        </div>
        <hr>
        
        <!-- ��� �ۼ��� -->
        <div class="row">
            
            <div class="row">
                <c:choose>
                    <c:when test="${sessionScope.memberId != null}">
                        <textarea name="replyContent" class="form-input w-100"
                                placeholder="��� ������ �ۼ��ϼ���"></textarea>	
                    </c:when>
                    <c:otherwise>
                        <textarea name="replyContent" class="form-input w-100"
                                placeholder="�α��� �Ŀ� ��� �ۼ��� �����մϴ�" disabled></textarea>	
                    </c:otherwise>
                </c:choose>
                
            </div>
            <c:if test="${sessionScope.memberId != null}">		
            <div class="row right">
                <button type="submit" class="form-btn positive reply-insert-btn">��� �ۼ�</button>
            </div>
            </c:if>
    
        </div>
        
        <hr>
        
        <div class="row right">
            <a class="form-btn positive" href="/board/write">�۾���</a>
            
            <c:if test="${owner}">
            <!-- ���� �ۼ��� ���̶�� ������ ���� �޴��� ��� -->
            <a class="form-btn negative" href="/board/edit?boardNo=${boardDto.boardNo}">����</a>
            </c:if>
            
            <c:if test="${owner || admin}">
            <!-- �Ķ���� ����� ����� ��ũ -->
            <a class="form-btn negative" href="/board/delete?boardNo=${boardDto.boardNo}">����</a>
            <!-- ��� ���� ����� ����� ��ũ -->
        <%-- 				<a href="/board/delete/${boardDto.boardNo}">����</a> --%>
            </c:if>
            <a class="form-btn neutral" href="/board/list">��Ϻ���</a>
        </div>
        
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>