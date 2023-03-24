<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .board-info-head, 
  .board-info-footer
  {
    display: flex;
  }
  
  .pocketmonTradeReply {
    margin-left: auto;
  }
  .pocketmonTradeContent {
    min-height: 400px;
  }
  .to-list-btn {
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
    <div class="row board-info-head">
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
      <span>
        좋아요 ${pocketmonTradeDto.getPocketmonTradeLike()}
      </span>
      <span class="pocketmonTradeReply">댓글 ${pocketmonTradeDto.getPocketmonTradeReply()}</span>
      <!-- 공유, 신고 -->
    </div>
    <hr>
    </div>
    <div class="row">
      <!-- 댓글 -->
    </div>
    <div class="row board-info-footer">
      <a href="write">글쓰기</a>
      <c:if test="${sessionScope.memberId == pocketmonTradeDto.getPocketmonTradeWriter()}">
        <a href="/pocketmonTrade/edit/${pocketmonTradeDto.getPocketmonTradeNo()}">수정</a>
        <a class="pocketmonTrade-btn" id="pocketmonTrade-delete-btn" href="#">삭제</a>
      </c:if>
      <a class="to-list-btn" href="/pocketmonTrade">목록</a>
      <div>top으로</div>
    </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
