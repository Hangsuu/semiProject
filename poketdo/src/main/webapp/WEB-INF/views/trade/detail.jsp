<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</style>

<!-- section -->
<section test>

  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <div class="row">
        <h1>포켓몬교환 디테일</h1>
        <h1>${pocketmonTradeDto}</h1>
    </div>
    <div class="row">
      <h1>${pocketmonTradeDto.getPocketmonTradeTitle()}</h1>
    </div>
    <div class="row">
      <h2>${pocketmonTradeDto.getPocketmonTradeWriter()}</h2>
    </div>
    <div class="row board-info-head">
      <span>작성시간 ${pocketmonTradeDto.getPocketmonTradeWrittenTime()}</span> 
      <span class="pocketmonTradeRead">조회수 ${pocketmonTradeDto.getPocketmonTradeRead()}</span>
      <span class="pocketmonTradeReply">댓글 ${pocketmonTradeDto.getPocketmonTradeReply()}</span>
    </div>
    <br>
    <div class="row pocketmonTradeContent">
      <div>
        ${pocketmonTradeDto.getPocketmonTradeContent()}
      </div>
    </div>
    <div class="row">
      <div></div>
    </div>
    <div class="row board-info-footer">

    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
