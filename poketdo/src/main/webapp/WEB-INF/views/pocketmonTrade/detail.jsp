<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
    const memberId = "${sessionScope.memberId}";
    const allboardNo = "${pocketmonTradeDto.getAllboardNo()}";
    const likeTableDto = {
      memberId: memberId, 
      allboardNo: allboardNo
    }
</script>
<script src="/static/js/pocketmonTrade.js"></script>
<!-- <script src="/static/js/reply.js"></script> -->
<style>
  .pocketmonTrade-info-head, 
  .pocketmonTrade-info-footer
  {
    display: flex;
  }
  
  .pocketmonTradeReply {
    margin-left: auto;
  }
  .pocketmonTradeContent {
    min-height: 400px;
  }
  #pocketmonTrade-list-btn {
    margin-left: auto;
  }
  .pocketmonTrade-btn {
    /* ba */
    font-weight: bold;
    padding: 0.25em 0.5em;
    color: black;
    text-decoration: none;
    border: 1px black solid;
  }
  #pocketmonTrade-like {
    font-weight: bold;
  }
  #pocketmonTrade-like:hover {
    cursor: pointer;
  }
  #pocketmonTrade-reply {
    border: 1px solid #E5E5E5;
  }
  textarea[name=replyContent] {
    resize: none;
  }
</style>

<!-- section -->
<section >

  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <div class="row">
        <h1>포켓몬교환 디테일</h1>
    </div>
    <div class="row">
      <h1>제목: ${pocketmonTradeDto.getPocketmonTradeTitle()}</h1>
    </div>
    <div class="row">
      <h2>${pocketmonTradeDto.getPocketmonTradeWriter()}</h2>
    </div>
    <div class="row pocketmonTrade-info-head">
      <span>작성시간 <fmt:formatDate value="${pocketmonTradeDto.getPocketmonTradeWrittenTime()}" pattern="yyyy.MM.dd. H:m"/></span> 
      <span class="pocketmonTradeRead">&nbsp;&nbsp;조회수 ${pocketmonTradeDto.getPocketmonTradeRead()}</span>
      <span class="pocketmonTradeReply">댓글 ${pocketmonTradeDto.getPocketmonTradeReply()}</span>
    </div>
    <hr/>
    <div class="row pocketmonTradeContent">
      <div>
        ${pocketmonTradeDto.getPocketmonTradeContent()}
      </div>
    </div>
    <div class="row">
      <div>
        <a href="#">${pocketmonTradeDto.getPocketmonTradeWriter()}님의 게시글 더 보기</a>
      </div>
    </div>
    <div class="row">
      <span id="pocketmonTrade-like">
        <i class="fa-regular fa-heart fa-red" style="color:red"></i> 좋아요 <span id="pocketmonTrade-like-Cnt">${pocketmonTradeDto.getPocketmonTradeLike()}</span>
      </span>
      <span class="pocketmonTradeReply">댓글 ${pocketmonTradeDto.getPocketmonTradeReply()}</span>
      <!-- 공유, 신고 -->
    </div>
    <hr>
    </div>
    <div class="row">
      <!-- 댓글 -->
    </div>
    <div class="row pocketmonTrade-info-footer">
      <a class="pocketmonTrade-btn" href="write">글쓰기</a>
      <c:if test="${sessionScope.memberId == pocketmonTradeDto.getPocketmonTradeWriter()}">
        <a class="pocketmonTrade-btn" href="/pocketmonTrade/${pocketmonTradeDto.getPocketmonTradeNo()}/edit">수정</a>
        <a class="pocketmonTrade-btn" id="pocketmonTrade-delete-btn" href="/pocketmonTrade/delete/${pocketmonTradeDto.getPocketmonTradeNo()}">삭제</a>
      </c:if>
      <a id="pocketmonTrade-list-btn" class="pocketmonTrade-btn" href="/pocketmonTrade">목록</a>
      <div>top으로</div>
    </div>
    <div class="row">
      <div id="pocketmonTrade-reply">
        <div class="row">
          ${sessionScope.memberId}
        </div>
        <form action="#" method="post" enctype="multipart/form-data">
          <input type="hidden" name="replyOrigin" value="${pocketmonTradeDto.getAllboardNo()}">
          <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
          <textarea class="summernote" name="replyContent"></textarea>
          <button id="pocketmonTrade-reply-btn" type="submit">등록</button>
        </form>
      </div>
    </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>