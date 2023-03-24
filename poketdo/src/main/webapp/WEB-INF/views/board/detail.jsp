<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

<c:if test="${sessionScope.memberId != null}">
<link rel="stylesheet" type="text/css" href="/static/css/board-like.css">
<link rel="stylesheet" type="text/css" href="/static/css/board-dislike.css">
<script src="/static/js/board-like.js"></script>
<script src="/static/js/board-dislike.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/reply.css">
<script>
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${boardDto.boardWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="reply-item">
		<div class="replyWriter">?</div>
		<div class="replyContent">?</div>
		<div class="replyTime">?</div>
	</div>
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
    		<!-- ���ƿ� ��ư -->
    		<i class="fa-heart"></i>
  			</c:if>

  			�Ⱦ��
  			<span class="bad-count">${boardDto.boardDislike}</span>

  			<c:if test="${sessionScope.memberId != null}">
    		<!-- �Ⱦ�� ��ư -->
    		<i class="fa-thumbs-down"></i>
  			</c:if>


            
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