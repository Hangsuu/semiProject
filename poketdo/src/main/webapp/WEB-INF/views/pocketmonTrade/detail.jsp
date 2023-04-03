<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<style>
  .pocketmonTrade-reply-re:hover {
    cursor: pointer;
  }
  .pocketmonTrade-reply-form {
    position: relative;
  }
</style>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!-- 모먼트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
    const memberId = "${sessionScope.memberId}";
    const memberLevel = "${sessionScope.memberLevel}"
    const allboardNo = parseInt("${pocketmonTradeMemberDto.getAllboardNo()}");
    const pocketmonTradeWriter = "${pocketmonTradeMemberDto.getPocketmonTradeWriter()}";
    const likeTableDto = {
      memberId: memberId, 
      allboardNo: allboardNo
    };
    const replyDto = {
      replyOrigin: allboardNo,
      replyWriter: memberId,
    }
</script>
<script src="/static/js/pocketmonTrade/pocketmonTrade.js"></script>

<script type="text/template" id="pocketmonTrade-reply-template">
  <div class="row">
    <div>
      <div class="bold flex">
        <div class="pocketmonTrade-reply-writer">댓글작성자</div>
        <div class="writerTag">작성자</div>
        <button class="pocketmonTrade-reply-edit-btn ml-auto" type="button">수정</button>
        <button class="pocketmonTrade-reply-delete-btn" type="button">삭제</button>
      </div>
      <div class="pocketmonTrade-reply-content"></div>
      <div style="color:#979797;" class="flex">
        <div class="pocketmonTrade-reply-time">댓글시간</div>
        <div class="ms-10 pocketmonTrade-reply-re">답글쓰기</div>
      </div>
    </div>
    <hr/>
  </div>
</script>

<script type="text/template" id="pocketmonTrade-reply-write">
  <div class="row pocketmonTrade-reply-reply">
    <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
    <textarea class="summernote" name="replyContent"></textarea>
    <div class="right">
      <button class="pocketmonTrade-reply-cancle-btn" type="button">취소</button>
      <button class="pocketmonTrade-reply-update-btn" type="button">수정</button>
    </div>
  </div>
</script>

<!-- section -->
<section class="container-1200 mt-50 mb-30 ps-30 pe-30">
  <!-- article -->
  <article class="w-100">
    <div class="mb-30">
      <h1>
        <c:if test="${pocketmonTradeMemberDto.getPocketmonTradeHead() != null}">
          [${pocketmonTradeMemberDto.getPocketmonTradeHead()}] 
        </c:if>
        ${pocketmonTradeMemberDto.getPocketmonTradeTitle()}</h1>
    </div>
    <div class="row">
      <h3>${pocketmonTradeMemberDto.getMemberNick()}<c:choose><c:when test="${sessionScope.memberLevel == '관리자'}">(${pocketmonTradeMemberDto.getPocketmonTradeWriter()})</c:when><c:otherwise>(${pocketmonTradeMemberDto.getPocketmonTradeWriter().length() < 5 ?pocketmonTradeMemberDto.getPocketmonTradeWriter() : pocketmonTradeMemberDto.getPocketmonTradeWriter().substring(0,4).concat("*".repeat(pocketmonTradeMemberDto.getPocketmonTradeWriter().length()-4))})</c:otherwise></c:choose></h3>
    </div>
    <div class="row pocketmonTrade-info-head">
      <span>작성시간 <fmt:formatDate value="${pocketmonTradeMemberDto.getPocketmonTradeWrittenTime()}" pattern="yyyy.MM.dd. H:m"/></span> 
      <span class="pocketmonTradeRead">&nbsp;&nbsp;조회수 ${pocketmonTradeMemberDto.getPocketmonTradeRead()}</span>
      <span class="pocketmonTradeReply">댓글 <span class="pocketmonTrade-replyCnt">${pocketmonTradeMemberDto.getPocketmonTradeReply()}</span></span>
    </div>
    <hr/>
    <div class="row pocketmonTradeContent">
      <div>
        ${pocketmonTradeMemberDto.getPocketmonTradeContent()}
      </div>
    </div>
    <div class="row">
      <div>
        <a class="link" href="/pocketmonTrade?column=pocketmon_trade_writer&keyword=${pocketmonTradeMemberDto.getPocketmonTradeWriter()}"><b>${pocketmonTradeMemberDto.getPocketmonTradeWriter()}</b>님의 게시글 더 보기</a>
      </div>
    </div>

    <!-- 좋아요 댓글 신고 -->
    <div class="row">
      <span id="pocketmonTrade-like">
        <i class="fa-regular fa-heart fa-red" style="color:red"></i> 좋아요 <span id="pocketmonTrade-like-Cnt">${pocketmonTradeMemberDto.getPocketmonTradeLike()}</span>
      </span>
      <span class="pocketmonTradeReply">댓글 <span class="pocketmonTrade-replyCnt">${pocketmonTradeMemberDto.getPocketmonTradeReply()}</span></span>
    </div>
    <hr>
    <div class="row pocketmonTrade-info-footer">
      <c:if test="${sessionScope.memberId != null}">
        <a class="pocketmonTrade-btn" href="write">글쓰기</a>
      </c:if>
      <c:if test="${sessionScope.memberId == pocketmonTradeMemberDto.getPocketmonTradeWriter() || sessionScope.memberLevel == '관리자'}">
        <a class="pocketmonTrade-btn" href="/pocketmonTrade/${pocketmonTradeMemberDto.getPocketmonTradeNo()}/edit">수정</a>
        <a class="pocketmonTrade-btn" id="pocketmonTrade-delete-btn" href="/pocketmonTrade/delete/${pocketmonTradeMemberDto.getPocketmonTradeNo()}">삭제</a>
      </c:if>
      <a id="pocketmonTrade-list-btn" class="pocketmonTrade-btn" href="/pocketmonTrade">목록</a>
      <!-- <div>top으로</div> -->
    </div>

    <!-- 댓글 -->
    <div class="row">
      <div id="pocketmonTrade-reply">
        <div class="row" id="pocketmonTrade-replys">
        </div>
        <c:if test="${sessionScope.memberId != null}">
          <div class="row">
            <b>${sessionScope.memberId}</b>
          </div>
          <div class="row">
            <form class="pocketmonTrade-reply-form" action="#" method="post" enctype="multipart/form-data">
              <input type="hidden" name="replyParent" value="0">
              <input type="hidden" name="replyOrigin" value="${pocketmonTradeMemberDto.getAllboardNo()}">
              <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
              <textarea class="summernote" name="replyContent"></textarea>
              <button class="pocketmonTrade-btn" style="position: relative; left: 96.5%; bottom: -5px;" id="pocketmonTrade-reply-btn" type="submit">등록</button>
            </form>
          </div>
        </c:if>
      </div>
    </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>