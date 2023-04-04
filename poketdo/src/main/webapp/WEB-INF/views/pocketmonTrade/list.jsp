<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/static/js/pocketmonTrade/pocketmonTradeList.js"></script>
<style>
  .typeTag {
    text-decoration: none;
  }
  .ellipsis {
    display: inline-block;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap
  }
  .h-100 {
    height: 100%;
  }
</style>
<script>
  // console.log(window.location);
  console.log(window.location.origin)
  $(function(){
    $(".typeTag").click(function(e){
      e.preventDefault();
      const queryString = new URLSearchParams(location.search);
      queryString.set("type", $(this).text());
      console.log(queryString.toString());

      const newUrl = window.location.origin + location.pathname + "?" + queryString.toString();
      console.log(newUrl)
      location.href=newUrl;
    })
  })
</script>
<!-- section -->
<section>
  <article class="container-1200" style="min-height: 1000px">
    <div class="mt-50 mb-10">
      <a class="pocketmonTrade-list-banner" href="/pocketmonTrade">포켓몬교환</a>
    </div>
    <!-- 검색창 -->
    <div class="row flex">
      <form action="/pocketmonTrade" method="get" autocomplete="off">
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

      <!-- 검색옵션 -->
      <div class="ml-auto flex-all-center me-20">
        <b>검색옵션</b>
      </div>
      <select class="pocketmonTrade-type me-10 border-0">
        <option value="">구분선택</option>
        <c:choose>
          <c:when test="${param.type=='교환'}">
            <option selected>교환</option>
          </c:when>
          <c:otherwise>
            <option>교환</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.type=='나눔'}">
            <option selected>나눔</option>
          </c:when>
          <c:otherwise>
            <option>나눔</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.type=='요청'}">
            <option selected>요청</option>
          </c:when>
          <c:otherwise>
            <option>요청</option>
          </c:otherwise>
        </c:choose>
      </select>
      <select class="pocketmonTrade-isDone border-0">
        <option value="" selected>진행선택</option>
        <c:choose>
          <c:when test="${param.isDone=='0'}">
            <option value="0" selected>진행중</option>
          </c:when>
          <c:otherwise>
            <option value="0">진행중</option>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${param.isDone=='1'}">
            <option value="1" selected>완료</option>
          </c:when>
          <c:otherwise>
            <option value="1">완료</option>
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
              class="pocketmonTrade-a-link h-100"
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
          <c:choose>
            <c:when test="${trade.getPocketmonTradeHead()=='공지'}">
              <div class="flex-all-center pocketmonTrade-notice-tag">공지</div>
            </c:when>
            <c:otherwise>
              <div class="flex-all-center">${trade.getPocketmonTradeNo()}</div>    
            </c:otherwise>
          </c:choose>
          <div class="flex-all-center bold"><a class="typeTag" href="#">${trade.getPocketmonTradeHead()}</a></div>
          <div class="flex-align-center">
            <a
              class="pocketmonTrade-a-link ellipsis"
              href="/pocketmonTrade/${trade.getPocketmonTradeNo()}"
            >
            <c:if test="${trade.getPocketmonTradeHead()!='공지'}">
              <c:choose>
                <c:when test="${trade.getPocketmonTradeComplete()==0}">
                  <span class="ing-tag">진행중</span>
                </c:when>
                <c:when test="${trade.getPocketmonTradeComplete()==1}">
                  <span class="complete-tag">완료</span>
                </c:when>
              </c:choose>
            </c:if>
              &nbsp;${trade.getPocketmonTradeTitle()}
              <c:if test="${trade.getPocketmonTradeReply()!=0}">
                <span style="color: red; font-weight: 600"
                  >[${trade.getPocketmonTradeReply()}]</span
                ></c:if
              ></a
            >
          </div>
          <div class="flex-align-center">
            <img class="board-seal" src="/attachment/download?attachmentNo=${trade.getAttachmentNo()}">${trade.getMemberNick()}
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
              href="/pocketmonTrade/?page=1&${pageVo.parameter}&${pageVo.addParameter}${pageVo.getOptionQuery()}"
              ><i class="fa-solid fa-angles-left"></i
            ></a>
          </c:otherwise>
        </c:choose>
        <!-- 이전 페이지로 이동 -->
        <c:choose>
          <c:when test="${pageVo.prev}">
            <a
              href="/pocketmonTrade/?page=${pageVo.prevPage}&${pageVo.parameter}&${pageVo.addParameter}${pageVo.getOptionQuery()}"
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
                href="/pocketmonTrade/?page=${i}&${pageVo.parameter}&${pageVo.addParameter}${pageVo.getOptionQuery()}"
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
              href="/pocketmonTrade/?page=${pageVo.nextPage}&${pageVo.parameter}&${pageVo.addParameter}${pageVo.getOptionQuery()}"
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
              href="/pocketmonTrade/?page=${pageVo.totalPage}&${pageVo.parameter}&${pageVo.addParameter}${pageVo.getOptionQuery()}"
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
      
      <!-- 검색창 -->
    <div class="row flex-all-center">
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
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
