<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
    const memberId = "${sessionScope.memberId}";
    const allboardNo = parseInt("${pocketmonTradeDto.getAllboardNo()}");
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
<script src="/static/js/pocketmonTrade/pocketmonTrade.js"></script>
<script type="text/template" id="pocketmonTrade-reply-template">
  <div class="row">
    <div style="font-weight: bold;">댓글작성자</div>
    <div>댓글 내용</div>
    <div style="display: flex;">
      <span style="color:#979797; margin-right: 1em;">댓글시간</span><span style="color:#979797">답글쓰기</span><span style="margin-left: auto; margin-right: 1em;">수정</span><span>삭제</span>
    </div>
  </div>
  <hr/>
</script>
<style>
  
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
      <h1>
        <c:if test="${pocketmonTradeDto.getPocketmonTradeHead() != ''}">
          [${pocketmonTradeDto.getPocketmonTradeHead()}] 
        </c:if>
        ${pocketmonTradeDto.getPocketmonTradeTitle()}</h1>
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
        <a class="link" href="/pocketmonTrade?column=pocketmon_trade_writer&keyword=${pocketmonTradeDto.getPocketmonTradeWriter()}"><b>${pocketmonTradeDto.getPocketmonTradeWriter()}</b>님의 게시글 더 보기</a>
      </div>
    </div>

    <!-- 좋아요 댓글 신고 -->
    <div class="row">
      <span id="pocketmonTrade-like">
        <i class="fa-regular fa-heart fa-red" style="color:red"></i> 좋아요 <span id="pocketmonTrade-like-Cnt">${pocketmonTradeDto.getPocketmonTradeLike()}</span>
      </span>
      <span class="pocketmonTradeReply">댓글 ${pocketmonTradeDto.getPocketmonTradeReply()}</span>
    </div>
    <hr>
    </div>
    <div class="row pocketmonTrade-info-footer">
      <a class="pocketmonTrade-btn" href="write">글쓰기</a>
      <c:if test="${sessionScope.memberId == pocketmonTradeDto.getPocketmonTradeWriter() || sessionScope.memberLevel == '마스터'}">
        <a class="pocketmonTrade-btn" href="/pocketmonTrade/${pocketmonTradeDto.getPocketmonTradeNo()}/edit">수정</a>
        <a class="pocketmonTrade-btn" id="pocketmonTrade-delete-btn" href="/pocketmonTrade/delete/${pocketmonTradeDto.getPocketmonTradeNo()}">삭제</a>
      </c:if>
      <a id="pocketmonTrade-list-btn" class="pocketmonTrade-btn" href="/pocketmonTrade">목록</a>
      <div>top으로</div>
    </div>

    <!-- 댓글 -->
    <div class="row">
      <div id="pocketmonTrade-reply">
        
        <div class="row">
          <b>${sessionScope.memberId}</b>
        </div>
        <div class="row">
          <form action="#" method="post" enctype="multipart/form-data">
            <input type="hidden" name="replyOrigin" value="${pocketmonTradeDto.getAllboardNo()}">
            <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
            <textarea class="summernote" name="replyContent"></textarea>
            <button id="pocketmonTrade-reply-btn" type="submit">등록</button>
          </form>
        </div>
      </div>
    </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>