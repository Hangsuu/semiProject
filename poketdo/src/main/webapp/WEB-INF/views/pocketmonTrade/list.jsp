<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style></style>
<style>
  .pocketmonTrade-notice {
    background-color: #f9f9f8;
    /* color: #ff4e59; */
  }
  .pocketmonTrade-notice a {
    color: #ff4e59;
    font-weight: bold;
  }
</style>

<!-- section -->
<section>
  <!-- article -->
  <article class="container-800">
    <div class="row">
      <a class="pocketmonTrade-list-banner" href="/pocketmonTrade"
        >포켓몬교환 게시판</a
      >
    </div>
    <hr />
    <div class="pocketmonTrade-list">
      <div class="pocketmonTrade-row row">
        <span>번호</span>
        <span>제목</span>
        <span>작성자</span>
        <span>작성일</span>
        <span>조회수</span>
      </div>
      <!-- 공지 -->
      <c:forEach var="notice" items="${notices}">
        <div class="pocketmonTrade-row pocketmonTrade-notice">
          <span>공지</span>
          <span
            ><a
              class="pocketmonTrade-a-link"
              href="/pocketmonTrade/${notice.getPocketmonTradeNo()}"
            >
              <c:if test="${notice.getPocketmonTradeHead()!=''}">
                [${notice.getPocketmonTradeHead()}]
              </c:if>
              ${notice.getPocketmonTradeTitle()}</a
            ><c:if test="${notice.getPocketmonTradeReply()}!=0"
              >[${notice.getPocketmonTradeReply()}]</c:if
            ></span
          >
          <span>${notice.getPocketmonTradeWriter()}</span>
          <span>
            <fmt:formatDate
              value="${notice.getPocketmonTradeWrittenTime()}"
              pattern="yyyy.MM.dd."
            />
          </span>
          <span>${notice.getPocketmonTradeRead()}</span>
        </div>
      </c:forEach>
      <!-- 게시물 -->
      <c:forEach var="trade" items="${trades}">
        <div class="pocketmonTrade-row">
          <span>${trade.getPocketmonTradeNo()}</span>
          <span
            ><a
              class="pocketmonTrade-a-link"
              href="/pocketmonTrade/${trade.getPocketmonTradeNo()}"
            >
              <c:if test="${trade.getPocketmonTradeHead()!=''}">
                [${trade.getPocketmonTradeHead()}]
              </c:if>
              ${trade.getPocketmonTradeTitle()}</a
            ><c:if test="${trade.getPocketmonTradeReply()}!=0"
              >[${trade.getPocketmonTradeReply()}]</c:if
            ></span
          >
          <span>${trade.getPocketmonTradeWriter()}</span>
          <span>
            <fmt:formatDate
              value="${trade.getPocketmonTradeWrittenTime()}"
              pattern="yyyy.MM.dd."
            />
          </span>
          <span>${trade.getPocketmonTradeRead()}</span>
        </div>
      </c:forEach>
    </div>
    <div class="row right">
      <a class="pocketmonTrade-a-btn" href="pocketmonTrade/write">글쓰기</a>
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
              <c:when test="${pageVo.getColumn()=='pocketmon_trade_head'}">
                <option value="pocketmon_trade_head" selected>말머리</option>
              </c:when>
              <c:otherwise>
                <option value="pocketmon_trade_head">말머리</option>
              </c:otherwise>
            </c:choose>
            <c:choose>
              <c:when test="${pageVo.getColumn()=='pocketmon_trade_writer'}">
                <option value="pocketmon_trade_writer" selected>
                  글작성자
                </option>
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
          <input
            type="search"
            name="keyword"
            value="${pageVo.getKeyword()}"
            placeholder="검색어를 입력해주세요"
          />
          <button type="submit" class="positive">검색</button>
        </form>
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
