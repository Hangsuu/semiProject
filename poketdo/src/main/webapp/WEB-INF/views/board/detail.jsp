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
    
	<div class="container-800">
        <div class="row center">
            <h2>${boardDto.boardNo}번 게시글</h2>
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
                                            pattern="y년 M월 d일 H시 m분 s초"/>
                    조회 ${boardDto.boardRead}
        </div>
        <hr>
        <div class="row" style="min-height:200px;">
            ${boardDto.boardContent}
        </div>
        <hr>
        <div class="row">
            좋아요 
            <span class="heart-count">${boardDto.boardLike}</span>
            
            <c:if test="${sessionScope.memberId != null}">
            <!-- 하트자리 -->
            <i class="fa-heart"></i>
            </c:if>
            
            싫어요
            <span class="bad-count">${boardDto.boardDislike}</span>
            
            댓글 
            <span class="reply-count">${boardDto.boardReply}</span>
        </div>
        <hr>
        <div class="row reply-list">
            댓글목록 위치
        </div>
        <hr>
        
        <!-- 댓글 작성란 -->
        <div class="row">
            
            <div class="row">
                <c:choose>
                    <c:when test="${sessionScope.memberId != null}">
                        <textarea name="replyContent" class="form-input w-100"
                                placeholder="댓글 내용을 작성하세요"></textarea>	
                    </c:when>
                    <c:otherwise>
                        <textarea name="replyContent" class="form-input w-100"
                                placeholder="로그인 후에 댓글 작성이 가능합니다" disabled></textarea>	
                    </c:otherwise>
                </c:choose>
                
            </div>
            <c:if test="${sessionScope.memberId != null}">		
            <div class="row right">
                <button type="submit" class="form-btn positive reply-insert-btn">댓글 작성</button>
            </div>
            </c:if>
    
        </div>
        
        <hr>
        
        <div class="row right">
            <a class="form-btn positive" href="/board/write">글쓰기</a>
            
            <c:if test="${owner}">
            <!-- 내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
            <a class="form-btn negative" href="/board/edit?boardNo=${boardDto.boardNo}">수정</a>
            </c:if>
            
            <c:if test="${owner || admin}">
            <!-- 파라미터 방식일 경우의 링크 -->
            <a class="form-btn negative" href="/board/delete?boardNo=${boardDto.boardNo}">삭제</a>
            <!-- 경로 변수 방식일 경우의 링크 -->
        <%-- 				<a href="/board/delete/${boardDto.boardNo}">삭제</a> --%>
            </c:if>
            <a class="form-btn neutral" href="/board/list">목록보기</a>
        </div>
        
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>