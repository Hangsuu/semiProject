<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<section>
  <!-- article -->
  <article class="container-800">
    <div class="row">
      <h1>포켓몬교환 게시판</h1>
    </div>
    <hr />
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
          <span
            ><a href="/pocketmonTrade/${trade.getPocketmonTradeNo()}">${trade.getPocketmonTradeTitle()}</a
            ><c:if test="${trade.getPocketmonTradeReply()}!=0">[${trade.getPocketmonTradeReply()}]</c:if></span
          >
          <span>${trade.getPocketmonTradeWriter()}</span>
          <span>
            <fmt:formatDate value="${trade.getPocketmonTradeWrittenTime()}" pattern="yyyy.MM.dd." />
          </span>
          <span>${trade.getPocketmonTradeRead()}</span>
        </div>
      </c:forEach>
    </div>
    <div class="row right">
      <a class="a-btn" href="pocketmonTrade/write">글쓰기</a>
    </div>
    <div class="row center">
      <div>
        페이지네이션
        <c:choose>
          <c:when test="${pageVo.isFirst()}"> &laquo; </c:when>
          <c:otherwise>
            <a href="?page=1">&laquo</a>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="{pageVo.isPrev()}">
            <a href="?page=${pageVo.getPrevPage()}">&lt;</a>
          </c:when>
          <c:otherwise> &lt; </c:otherwise>
        </c:choose>
        <c:forEach var="i" begin="1" end="${pageVo.getFinishBlock()}">
          <c:choose>
            <c:when test="${i == pageVo.getPage()}"> ${i} </c:when>
            <c:otherwise>
              <a href="?page=${i}">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <c:choose>
          <c:when test="${pageVo.isNext()}">
            <a href="?page=${pageVo.getNextPage()}">&gt;</a>
          </c:when>
          <c:otherwise> &gt; </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${pageVo.isLast()}"> &raquo; </c:when>
          <c:otherwise>
            <a href="?page=${pageVo.getTotalPage()}">&raquo;</a>
          </c:otherwise>
        </c:choose>
      </div>
      <hr />
      <div class="row">
        <form action="" method="get">
          <select name="column">
            <option value="pocketmon_trade_title">선택</option>
            <c:choose>
              <c:when test="${pageVo.getColumn()=='pocketmon_trade_title'}">
                <option value="pocketmon_trade_title" selected>제목</option>
              </c:when>
              <c:otherwise>
                <option value="pocketmon_trade_title">제목</option>
              </c:otherwise>
            </c:choose>
            <c:choose>
              <c:when test="${pageVo.getColumn()=='pocketmon_trade_writer'}">
                <option value="pocketmon_trade_writer" selected>글작성자</option>
              </c:when>
              <c:otherwise>
                <option value="pocketmon_trade_writer">글작성자</option>
              </c:otherwise>
            </c:choose>
            <c:choose>
              <c:when test="${pageVo.getColumn()=='pocketmon_trade_content'}">
                <option value="pocketmon_trade_content" selected>내용</option>
              </c:when>
              <c:otherwise>
                <option value="pocketmon_trade_content">내용</option>
              </c:otherwise>
            </c:choose>
          </select>
          <input type="search" name="keyword" value="${pageVo.getKeyword()}" placeholder="검색어를 입력해주세요" />
          <button type="submit" class="positive">검색</button>
        </form>
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
