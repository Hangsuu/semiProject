<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- section -->
<section>
  <!-- article -->
  <article class="container-800 pt-50">
    <div class="row mb-30">
      <a class="pocketmonTrade-list-banner" href="/pocketmonTrade"
        >포켓몬교환 게시판</a
      >
    </div>
    <hr class="mg-0" />
    <div class="pocketmonTrade-list">
      <div class="bold pocketmonTrade-row h-2p5em">
        <div class="flex-all-center">번호</div>
        <div class="flex-all-center">제목</div>
        <div class="flex-align-center">작성자</div>
        <div class="flex-all-center">작성일</div>
        <div class="flex-all-center">조회수</div>
      </div>

      <!-- 공지 -->
      <c:forEach var="notice" items="${notices}">
        <div class="pocketmonTrade-row w-100 pocketmonTrade-notice">
          <div class="flex-all-center">공지</div>
          <div class="flex-align-center">
            <a
              class="pocketmonTrade-a-link"
              href="/pocketmonTrade/${notice.getPocketmonTradeNo()}"
            >
              <c:if test="${notice.getPocketmonTradeHead()!=null}">
                [${notice.getPocketmonTradeHead()}]
              </c:if>
              ${notice.getPocketmonTradeTitle()}
              <c:if test="${notice.getPocketmonTradeReply()}!=0"
                >[${notice.getPocketmonTradeReply()}]</c:if
              >
            </a>
          </div>
          <div class="flex-align-center">
            ${notice.getPocketmonTradeWriter()}
          </div>
          <div class="flex-all-center">
            <c:choose>
              <c:when
                test="${now-notice.getPocketmonTradeWrittenTime().getTime() > 60 * 60 * 24 * 1000}"
              >
                <fmt:formatDate
                  value="${notice.getPocketmonTradeWrittenTime()}"
                  pattern="yyyy.MM.dd."
                />
              </c:when>
              <c:otherwise>
                <fmt:formatDate
                  value="${notice.getPocketmonTradeWrittenTime()}"
                  pattern="hh:mm"
                />
              </c:otherwise>
            </c:choose>
          </div>
          <div class="flex-all-center">${notice.getPocketmonTradeRead()}</div>
        </div>
      </c:forEach>
      <!-- 게시물 -->
      <c:forEach var="trade" items="${trades}">
        <div class="pocketmonTrade-row">
          <div class="flex-all-center">${trade.getPocketmonTradeNo()}</div>
          <div class="flex-align-center">
            <a
              class="pocketmonTrade-a-link"
              href="/pocketmonTrade/${trade.getPocketmonTradeNo()}"
            >
              <c:if test="${trade.getPocketmonTradeHead()!=null}">
                [${trade.getPocketmonTradeHead()}]
              </c:if>
              ${trade.getPocketmonTradeTitle()}
              <c:if test="${trade.getPocketmonTradeReply()!=0}">
                <span style="color: red; font-weight: 600"
                  >[${trade.getPocketmonTradeReply()}]</span
                ></c:if
              ></a
            >
          </div>
          <div class="flex-align-center">
            ${trade.getPocketmonTradeWriter()}
          </div>
          <div class="flex-all-center">
            <c:choose>
              <c:when
                test="${now-trade.getPocketmonTradeWrittenTime().getTime() > 60 * 60 * 24 * 1000}"
              >
                <fmt:formatDate
                  value="${trade.getPocketmonTradeWrittenTime()}"
                  pattern="yyyy.MM.dd."
                />
              </c:when>
              <c:otherwise>
                <fmt:formatDate
                  value="${trade.getPocketmonTradeWrittenTime()}"
                  pattern="hh:mm"
                />
              </c:otherwise>
            </c:choose>
          </div>
          <div class="flex-all-center">${trade.getPocketmonTradeRead()}</div>
        </div>
        <hr class="mg-0" />
      </c:forEach>
    </div>
    <div class="row right mt-20">
      <c:if test="${sessionScope.memberId != null}"
        ><a class="pocketmonTrade-a-btn" href="/pocketmonTrade/write"
          ><i class="fa-solid fa-pencil"></i> 글쓰기</a
        ></c:if
      >
    </div>
    <div class="row center mt-30 back-gray pt-10">
      <!-- 포켓몬교환 페이지네이션 -->
      <div class="h-2p5em flex-all-center pocketmonTrade-pagination">
        <c:if test="${!pageVo.isFirst()}">
          <a href="?page=1${pageVo.getQueryString()}"
            ><i class="fa-solid fa-angles-left"></i
          ></a>
        </c:if>
        <c:if test="${pageVo.isPrev()}">
          <a href="?page=${pageVo.getPrevPage()}${pageVo.getQueryString()}"
            ><i class="fa-solid fa-less-than"></i
          ></a>
        </c:if>
        <c:forEach
          var="i"
          begin="${pageVo.getStartBlock()}"
          end="${pageVo.getFinishBlock()}"
        >
          <c:choose>
            <c:when test="${i == pageVo.getPage()}"
              ><div class="nowPage">${i}</div></c:when
            >
            <c:otherwise>
              <a href="?page=${i}${pageVo.getQueryString()}">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>
        <c:if test="${pageVo.isNext()}">
          <a href="?page=${pageVo.getNextPage()}${pageVo.getQueryString()}"
            ><i class="fa-solid fa-greater-than"></i
          ></a>
        </c:if>
        <c:if test="${!pageVo.isLast()}"
          ><a href="?page=${pageVo.getTotalPage()}${pageVo.getQueryString()}"
            ><i class="fa-solid fa-angles-right"></i></a
        ></c:if>
      </div>
      <hr />
      <!-- 검색 -->
      <div class="h-3em flex-all-center pb-10">
        <form class="w-100 pocketmonTrade-search-form" action="" method="get">
          <select class="w-20" name="column">
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
