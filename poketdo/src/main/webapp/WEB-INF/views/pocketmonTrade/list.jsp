<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .tradeList {
    min-height: 600px;
  }
  .a-btn {
    border: 1px solid black;
    color: black;
    text-decoration: none;
    padding: 0.3em;
  }
  .trade-row {
    display: flex;
    height: 2em;
  }
  .trade-row > * {
    width: 10%;
    text-align: center;
  }
  .trade-row > *:first-child {
    width: 13%;
  }
  .trade-row > *:nth-child(2) {
    width: 45%;
    text-align: start;
  }
  .trade-row > *:nth-child(3) {
    width: 15%;
    /* text-align: start; */
  }
  .trade-row > *:nth-child(4) {
    width: 17%;
  }
</style>

<!-- section -->
<section >

<!-- article -->
  <article class="container-800">
    <div class="row">
      <h1>포켓몬교환 게시판</h1>
    </div>
    <hr/>
    <div class="tradeList">
      <div class="trade-row row">
        <span>번호</span>
        <span>제목</span>
        <span>작성자</span>
        <span>작성일</span>
        <span>조회수</span>
      </div>
      <c:forEach var="trade" items="${trades}">
        <div class="trade-row">
          <span>${trade.getPocketmonTradeNo()}</span>
          <span>${trade.getPocketmonTradeTitle()}<c:if test="${trade.getPocketmonTradeReply()}!=0">[${trade.getPocketmonTradeReply()}]</c:if></span>
          <span>${trade.getPocketmonTradeWriter()}</span>
          <span>
            <fmt:formatDate value="${trade.getPocketmonTradeWrittenTime()}" pattern="yyyy.MM.dd."/>
          </span>
          <span>${trade.getPocketmonTradeRead()}</span>
        </div>
      </c:forEach>
    </div>
    <div class="row right">
      <a class="a-btn" href="write">글쓰기</a>
    </div>
    <div class="row">
      <div>
        페이지네이션
        <c:choose>
          <c:when test="${pageVo.isFirst()}">
            &laquo;
          </c:when>
          <c:otherwise>
            <a href="?page=1">&laquo</a>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="{pageVo.isPrev()}">
            <a href="?page=${pageVo.getPrevPage()}"></a>
          </c:when>
        </c:choose>
        &lt;
        1 2 3 4 5 6 7 8 9 10
        &gt;
        &raquo;
      </div>
      <hr/>
      <div>
        검색
      </div>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
