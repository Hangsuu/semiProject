<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .pocketmonTrade-ing {
    border: 1px solid orange;
    color: orange;
    border-radius: 1em;
    padding: 0 0.5em;
  }
  .pocketmonTrade-request {

  }
  .pocketmonTrade-done {
    border: 1px solid forestgreen;
    color: forestgreen;
    border-radius: 1em;
    padding: 0 0.5em;
  }
  .pocketmonTrade-head {
    border-bottom: 2px #C2CCEE solid;
  }
  .pocketmonTrade-row:not(.pocketmonTrade-head) {
    border-bottom: 2px #F2F4FB solid;
  }
  .pocketmonTrade-notice-tag {
    color: red;
    border: 1px solid red;
    border-radius: 0.3em;
  }
</style>
<script>
  $(function(){
    const queryString = new URLSearchParams(location.search);
    const page = queryString.get("page") == null ? 1 : queryString.get("page");
    const column = queryString.get("column");
    const keyword = queryString.get("keyword");
    const type = queryString.get("")
    const pageVo = { page: page, column: column, keyword: keyword };
    // 포켓몬 교환 타입 설정 시 queryString 추가
    $(".pocketmonTrade-type").change(function(){
      queryString.set("type", $(this).val());
      window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
    })

    // 포켓몬 교환 isDone 설정 시 queryString 추가
    $(".pocketmonTrade-isDone").change(function(){
      queryString.set("isDone", $(this).val());
      window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
    })
  })
</script>
<!-- section -->
<section>
  <!-- article -->
  <article class="container-1200" style="min-height: 1000px">
    <div class="mt-50 mb-10">
      <a class="pocketmonTrade-list-banner" href="/pocketmonTrade">포켓몬교환</a>
    </div>
    <!-- 검색창 -->
    <div class="row flex">
      <form action="pocketmonTrade" method="get" autocomplete="off">
        <select name="column" class="form-input neutral">
          <option value="">선택</option>
          <c:choose>
            <c:when test="${pageVo.getColumn()=='pocketmon_trade_title'}">
              <option value="pocketmon_trade_title" selected>제목</option>
            </c:when>
            <c:otherwise>
              <option value="pocketmon_trade_title">제목</option>
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
          <c:choose>
            <c:when test="${pageVo.getColumn()=='member_nick'}">
              <option value="member_nick" selected>글쓴이</option>
            </c:when>
            <c:otherwise>
              <option value="member_nick">글쓴이</option>
            </c:otherwise>
          </c:choose>
        </select>
        <input name="keyword" class="form-input" placeholder="검색" value="${pageVo.getKeyword()}"/>
        <input name="page" type="hidden" value="1" />
        <button class="form-btn neutral">검색</button>
      </form>
      <div class="ml-auto flex-all-center me-20">
        <b>검색옵션</b>
      </div>
      <select class="pocketmonTrade-type me-10 border-0">
        <option value="">구분선택</option>
        <c:choose>
          <c:when test="${param.type=='trade'}">
            <option value="trade" selected>교환</option>
          </c:when>
          <c:otherwise>
            <option value="trade">교환</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.type=='share'}">
            <option value="share" selected>나눔</option>
          </c:when>
          <c:otherwise>
            <option value="share">나눔</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.type=='request'}">
            <option value="request" selected>요청</option>
          </c:when>
          <c:otherwise>
            <option value="request">요청</option>
          </c:otherwise>
        </c:choose>
      </select>
      <select class="pocketmonTrade-isDone border-0">
        <option value="">진행선택</option>
        <c:choose>
          <c:when test="${param.isDone=='ing'}">
            <option value="ing" selected>진행중</option>
          </c:when>
          <c:otherwise>
            <option value="ing">진행중</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.isDone=='done'}">
            <option value="done" selected>완료</option>
          </c:when>
          <c:otherwise>
            <option value="done">완료</option>
          </c:otherwise>
        </c:choose>
      </select>
    </div>

    <!-- 본문 -->
    <div class="pocketmonTrade-list">
      <div class="bold pocketmonTrade-row h-2p5em pocketmonTrade-head">
        <div class="flex-all-center">번호</div>
        <div class="flex-all-center">구분</div>
        <div class="flex-all-center">제목</div>
        <div class="flex-align-center">작성자</div>
        <div class="flex-all-center">작성일</div>
        <div class="flex-all-center">조회수</div>
      </div>

      <!-- 공지 -->
      <c:forEach var="notice" items="${notices}">
        <div class="pocketmonTrade-row w-100 pocketmonTrade-notice">
          <div class="flex-all-center pocketmonTrade-notice-tag">공지</div>
          <span></span>
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
            ${notice.getMemberNick()}
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
          <div class="flex-all-center bold">${trade.getPocketmonTradeHead()}</div>
          <div class="flex-align-center">
            <a
              class="pocketmonTrade-a-link"
              href="/pocketmonTrade/${trade.getPocketmonTradeNo()}"
            >
              <c:choose>
                <c:when test="${trade.getPocketmonTradeComplete()==0}">
                  <span class="pocketmonTrade-ing">진행중</span>
                </c:when>
                <c:otherwise>
                  <span class="pocketmonTrade-done">완료</span>
                </c:otherwise>
              </c:choose>
              &nbsp;${trade.getPocketmonTradeTitle()}
              <c:if test="${trade.getPocketmonTradeReply()!=0}">
                <span style="color: red; font-weight: 600"
                  >[${trade.getPocketmonTradeReply()}]</span
                ></c:if
              ></a
            >
          </div>
          <div class="flex-align-center">
            <img height="100%" src="/attachment/download?attachmentNo=${trade.getAttachmentNo()}">${trade.getMemberNick()}
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
      </c:forEach>
    </div>
    <div class="row right mt-20">
      <c:if test="${sessionScope.memberId != null}"
        ><a class="pocketmonTrade-a-btn" href="/pocketmonTrade/write"
          ><i class="fa-solid fa-pencil"></i> 글쓰기</a
        ></c:if
      >
    </div>
    <div class="row center mt-30 pt-10">
      <!-- 포켓몬교환 페이지네이션 -->
      <!-- 페이지네이션 -->
      <div class="row center pagination">
        <!-- 1페이지로 이동 -->
        <c:choose>
          <c:when test="${pageVo.first}">
            <a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
          </c:when>
          <c:otherwise>
            <a
              href="/pocketmonTrade/?page=1&${pageVo.parameter}&${pageVo.addParameter}"
              ><i class="fa-solid fa-angles-left"></i
            ></a>
          </c:otherwise>
        </c:choose>
        <!-- 이전 페이지로 이동 -->
        <c:choose>
          <c:when test="${pageVo.prev}">
            <a
              href="/pocketmonTrade/?page=${pageVo.prevPage}&${pageVo.parameter}&${pageVo.addParameter}"
              ><i class="fa-solid fa-angle-left"></i
            ></a>
          </c:when>
          <c:otherwise>
            <a class="disabled"
              ><i class="fa-solid fa-angle-left disabled"></i
            ></a>
          </c:otherwise>
        </c:choose>
        <!-- 번호들 -->
        <c:forEach
          var="i"
          begin="${pageVo.startBlock}"
          end="${pageVo.finishBlock}"
          step="1"
        >
          <c:choose>
            <c:when test="${pageVo.page==i}"
              ><a class="on disabled">${i}</a></c:when
            >
            <c:otherwise
              ><a
                href="/pocketmonTrade/?page=${i}&${pageVo.parameter}&${pageVo.addParameter}"
                class=""
                >${i}</a
              ></c:otherwise
            >
          </c:choose>
        </c:forEach>
        <!-- 다음 페이지 -->
        <c:choose>
          <c:when test="${pageVo.next}">
            <a
              href="/pocketmonTrade/?page=${pageVo.nextPage}&${pageVo.parameter}&${pageVo.addParameter}"
              class=""
              ><i class="fa-solid fa-angle-right"></i
            ></a>
          </c:when>
          <c:otherwise
            ><a class="disabled"> <i class="fa-solid fa-angle-right"></i></a>
          </c:otherwise>
        </c:choose>
        <!-- 마지막페이지로 -->
        <c:choose>
          <c:when test="${!pageVo.last}">
            <a
              href="/pocketmonTrade/?page=${pageVo.totalPage}&${pageVo.parameter}&${pageVo.addParameter}"
              class=""
              ><i class="fa-solid fa-angles-right"></i
            ></a>
          </c:when>
          <c:otherwise>
            <a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
          </c:otherwise>
        </c:choose>
      </div>
      <!-- 페이지네이션 끝 -->
      
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
            class="form-input"
            type="search"
            name="keyword"
            value="${pageVo.getKeyword()}"
            placeholder="검색어를 입력해주세요"
          />
          <button type="submit" class="form-btn neutral">검색</button>
        </form>
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
