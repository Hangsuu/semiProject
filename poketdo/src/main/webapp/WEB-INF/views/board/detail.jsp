<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!-- 모먼트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
    const memberId = "${sessionScope.memberId}";
    const allboardNo = parseInt("${boardWithImageDto.getAllboardNo()}");
    const boardWriter = "${boardWithImageDto.getBoardWriter()}";
    const likeTableDto = {
      memberId: memberId, 
      allboardNo: allboardNo
    };
    const replyDto = {
      replyOrigin: allboardNo,
      replyWriter: memberId,
    }
    $.parseHTML()
</script>
<script src="/static/js/board/board.js"></script>
<script type="text/template" id="board-reply-template">
  <div class="row">
    <div class="bold flex">
      <div>댓글작성자</div>
      <div class="writerTag">작성자</div>
      <button class="board-btn ml-auto" type="button">수정</button>
      <button class="board-btn" type="button">삭제</button>
    </div>
    <div></div>
    <div style="color:#979797;" class="flex">
      <div>댓글시간</div>
      <div class="ms-10">답글쓰기</div>
    </div>
  </div>
  <hr/>
</script>
<script type="text/template" id="board-reply-write">
  <div class=row>
    <form action="#" method="post" enctype="multipart/form-data">
      <input type="hidden" name="replyParent" value="0">
      <input type="hidden" name="replyOrigin" value="${boardWithImageDto.getAllboardNo()}">
      <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
      <textarea class="summernote" name="replyContent"></textarea>
      <div class="right">
        <button class="board-btn" type="submit">취소</button>
        <button class="board-btn" type="submit">등록</button>
      </div>
    </form>
  </div>
</script>
<script type="text/template" id="board-reply-write2">
  <div class=row>
    <div class=row>
      <textarea class="summernote" name="replyContent"></textarea>
    </div>
    <div class="right">
      <button class="board-btn" type="submit">취소</button>
      <button class="board-btn" type="submit">등록</button>
    </div>
  </div>
</script>

<!-- section -->
<section >

  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <div class="row center">
        <h1>자유 게시판</h1>
    </div>
    <div class="row">
      <h1>
        <c:if test="${boardWithImageDto.getBoardHead() != null}">
          [${boardWithImageDto.getBoardHead()}] 
        </c:if>
        ${boardWithImageDto.getBoardTitle()}</h1>
    </div>
    <div class="row">
      <h2>${boardWithImageDto.getBoardWriter()}</h2>
    </div>
    <div class="row board-info-head">
      <span>작성시간 <fmt:formatDate value="${boardWithImageDto.getBoardTime()}" pattern="yyyy.MM.dd. H:m"/></span> 
      <span class="boardRead">&nbsp;&nbsp;조회수 ${boardWithImageDto.getBoardRead()}</span>
      <span class="boardReply">댓글 <span class="board-replyCnt">${boardWithImageDto.getBoardReply()}</span></span>
    </div>
    <hr/>
    <div class="row boardContent">
      <div>
        ${boardWithImageDto.getBoardContent()}
      </div>
    </div>
    <div class="row">
      <div>
        <a class="link" href="/board?column=board_writer&keyword=${boardWithImageDto.getBoardWriter()}"><b>${boardWithImageDto.getBoardWriter()}</b>님의 게시글 더 보기</a>
      </div>
    </div>

    <!-- 좋아요 댓글 신고 -->
    <div class="row">
      <span id="board-like">
        <i class="fa-regular fa-heart fa-red" style="color:red"></i> 좋아요 <span id="board-like-Cnt">${boardWithImageDto.getBoardLike()}</span>
      </span>
      <span class="boardReply">댓글 <span class="board-replyCnt">${boardWithImageDto.getBoardReply()}</span></span>
    </div>
    <hr>
    <c:if test="${sessionScope.memberId != null}">
        <a class="board-btn" href="write">글쓰기</a>
      </c:if>
      <c:if test="${sessionScope.memberId == boardWithImageDto.getBoardWriter()}">
      <a class="board-btn" href="/board/edit?boardNo=${boardWithImageDto.getBoardNo()}">수정</a>
      </c:if>
      <c:if test="${sessionScope.memberId == boardWithImageDto.getBoardWriter() || sessionScope.memberLevel == '관리자'}">
        <a class="board-btn" id="board-delete-btn" href="/board/delete/${boardWithImageDto.getBoardNo()}">삭제</a>
      </c:if>
      <a id="board-list-btn" class="board-btn" href="/board/list">목록</a>
      <hr>
      <div class="reply-list">
      </div>
      <div id="board-reply">
        <div class="row" id="board-replys">
        </div>
        <c:if test="${sessionScope.memberId != null}">
          <div class="row">
            <b>${sessionScope.memberId}</b>
          </div>
          <div class="row">
            <form action="#" method="post" enctype="multipart/form-data">
              <input type="hidden" name="replyParent" value="0">
              <input type="hidden" name="replyOrigin" value="${boardWithImageDto.getAllboardNo()}">
              <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
              <textarea class="summernote" name="replyContent"></textarea>
              <button id="board-reply-btn" type="submit">등록</button>
            </form>
          </div>
        </c:if>
      </div>
    </div>

  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>