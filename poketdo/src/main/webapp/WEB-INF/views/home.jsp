<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- swiper 의존성 주입 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/swiper.js"></script>
<!-- timer 의존성 주입 -->
<script src="${pageContext.request.contextPath}/static/js/timer.js"></script>
<!-- 랜덤 숫자 생성 js 주입 -->
<script src="${pageContext.request.contextPath}/static/js/random.js"></script>
<!-- section -->
<%-- base.css --%>
<section class="container-1200 flex-box align-center">
  <!-- aside -->
  <aside></aside>

  <!-- 본문(article) -->
  <article class="container-1140 mt-30">

<%-- 배너자리 --%>
    <%-- home.css / component.css --%>
    <div class="row home-raid-board center">
      <%-- home.css --%>
      <a href="http://docs.sysout.co.kr">
      	<img style="width:1100px" src="static/image/home_banner.png">
      </a>
      
    </div>
<%-- 인기글, 오늘의 포켓몬--%>
    <%-- base.css / component.css --%>
    <div class="home-sector flex-row-grow w-100">
      <%-- home.css / component.css --%>
      <div class="home-cool-monster title-body w-50">
        <%-- home.css --%>
        <div class="home-board-title">
          <h2>🔥인기글</h2>
          <a href="${pageContext.request.contextPath}/board/hot">+더보기</a>
        </div>
        <div class="home-board-list">
        	<c:forEach var="boardWithNickDto" items="${boardList}">
        	    <div class="row do-not-line-over" style="font-size:17px">
	            	<a href="${pageContext.request.contextPath}/board/detail2?allboardNo=${boardWithNickDto.allboardNo}" class="link">
	            		<span class="home-board-type">[${boardWithNickDto.boardHead}]</span>
	            		 ${boardWithNickDto.boardTitle}
	            		<span class="home-board-reply">(${boardWithNickDto.boardReply})</span>
	            	</a>
            	</div>
        	</c:forEach>
		</div>
      </div>
      <%-- home.css / component.css --%>
      <div class="home-cool-board title-body w-50">
        <%-- home.css --%>
        <div class="home-board-title">
          <h2>🦄오늘의 포켓몬</h2>
          <div class="random-a-target">
          </div>
        </div>
        <div class="home-board-list random-box">
        	<div>
        		
        	</div>
        	<div>
        		
        	</div>
        	<div style="width:100%; height:400px; " class="center flex-all-center">
        	
        	</div>
        </div>
      </div>
    </div>
<%-- 포켓몬 교환 --%>
    <%-- base.css / component.css --%>
    <div class="home-sector title-body">
      <%-- home.css --%>
      <div class="home-board-title">
        <h2>🤝교환해요</h2>
        <a href="${pageContext.request.contextPath}/pocketmonTrade">+더보기</a>
      </div>
      <div class="mt-20 flex">
        <c:if test="${pocketmonTradeList.size()!=0}">
          <c:forEach var="i" begin="0" end="${pocketmonTradeList.size()-2}">
            <div style="padding:1em; border:1px solid #F2F4FB; border-radious:2em; margin:10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.05); width: 20%;">
              <div style="width:160px; height:180px" class="flex-row">
                <div>
                  <!-- <span class="ing-tag" style="display: inline-flex; margin-bottom: 5px;">${pocketmonTradeList.get(i).getPocketmonTradeHead()}</span> -->
                  <c:choose>
                    <c:when test="${pocketmonTradeList.get(i).getPocketmonTradeHead()=='요청'}">
                      <span class="ing-tag" style="display: inline-flex; margin-bottom: 5px; align-items: center; color: navy; border-color: navy;"><i class="fa-solid fa-magnifying-glass me-5" style="color: navy;"></i>요청</span>
                    </c:when>
                    <c:when test="${pocketmonTradeList.get(i).getPocketmonTradeHead()=='교환'}">
                      <span class="ing-tag" style="display: inline-flex; margin-bottom: 5px; align-items: center;"><i class="fa-solid fa-right-left" style="color:orange"></i>교환</span>
                    </c:when>
                    <c:when test="${pocketmonTradeList.get(i).getPocketmonTradeHead()=='나눔'}">
                      <span class="ing-tag" style="display: inline-flex; margin-bottom: 5px; align-items: center; color:forestgreen; border-color: forestgreen;"><i class="fa-solid fa-handshake me-5" style="color: forestgreen"></i>나눔</span>
                    </c:when>
                  </c:choose>
                </div>
                <c:choose>
                  <c:when test="${attachmentNoList.get(i)!=null}">
                    <a href="${pageContext.request.contextPath}/pocketmonTrade/${pocketmonTradeList.get(i).getPocketmonTradeNo()}" class="link">
                      <img style="width: 100%; height:150px;" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${attachmentNoList.get(i)}">
                    </a>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/pocketmonTrade/${pocketmonTradeList.get(i).getPocketmonTradeNo()}" class="link">
                      <img style="width: 100%; height:150px;" src="${pageContext.request.contextPath}/static/image/noimage.png">
                    </a>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="row" style="width:150px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis" title="${pocketmonTradeList.get(i).getPocketmonTradeTitle()}">
                <a href="${pageContext.request.contextPath}/pocketmonTrade/${pocketmonTradeList.get(i).getPocketmonTradeNo()}" class="link bold">
                  <c:choose>
                <c:when test="${pocketmonTradeList.get(i).getPocketmonTradeComplete()==0}">
                  
                </c:when>
                <c:when test="${pocketmonTradeList.get(i).getPocketmonTradeComplete()==1}">
                  <span class="complete-tag tag-style">완료</span>
                </c:when>
              </c:choose>${pocketmonTradeList.get(i).getPocketmonTradeTitle()}
                  <c:if test="${pocketmonTradeList.get(i).getPocketmonTradeReply()!=0}">(${pocketmonTradeList.get(i).getPocketmonTradeReply()})</c:if>
                </a>
              </div>
            </div>
          </c:forEach>
        </c:if>
      </div>
    </div>
<%-- 레이드, 공략--%>
    <%-- base.css / component.css --%>
    <div class="home-sector flex-row-grow">
      <%-- home.css / component.css --%>
      <div class="home-cool-monster title-body w-50">
        <%-- home.css --%>
        <div class="home-board-title">
          <h2>👨‍👩‍👧‍👦레이드 모집중</h2>
          <a href="${pageContext.request.contextPath}/raid/list?page=1">+더보기</a>
        </div>
        <div class="home-board-list">
        	<c:forEach var="raidDto" items="${raidList}">
        	    <div class="row do-not-line-over" style="font-size:17px; max-width:494px">
	            	<a href="${pageContext.request.contextPath}/raid/detail?page=1&allboardNo=${raidDto.allboardNo}" class="link">
	            		<span class="home-board-type">[${raidDto.raidMonster}]</span>
	            		<span title="${raidDto.raidTitle}">${raidDto.raidTitle} ${raidDto.raidCount}/4</span>
	            		<span class="home-board-reply">(${raidDto.raidReply})</span>
	            	</a>
            	</div>
        	</c:forEach>
        </div>
      </div>
      <%-- home.css / component.css --%>
      <div class="home-cool-board title-body w-50">
        <%-- home.css --%>
        <div class="home-board-title">
          <h2>📝오늘의 핫 공략</h2>
          <a href="${pageContext.request.contextPath}/combination/list?page=1">+더보기</a>
        </div>
        <div class="home-board-list">
            <c:forEach var="combinationDto" items="${combinationList}">
            	<div class="row do-not-line-over" style="font-size:17px; max-width:494px">
	            	<a href="${pageContext.request.contextPath}/combination/detail?page=1&allboardNo=${combinationDto.allboardNo}" class="link">
	            		<span class="home-board-type">[${combinationDto.combinationType}]</span>
	            		<span title="${combinationDto.combinationTitle}">${combinationDto.combinationTitle}</span> 
	            		<span class="home-board-reply">(${combinationDto.combinationReply})</span>
	            	</a>
            	</div>
        	</c:forEach>
        </div>
      </div>
    </div>
    
    
<%-- 경매 --%>
    <%-- base.css / component.css --%>
    <div class="home-sector">
      <%-- home.css --%>
      <div class="home-board-title">
        <h2>⏱️hot 경매</h2>
        <a href="${pageContext.request.contextPath}/auction/list?page=1">+더보기</a>
      </div>
	<!-- 게시판 테이블(swiper) -->
		<div class="swiper mt-20">
			<div class="swiper-wrapper">
				<c:forEach var="auctionDto" items="${auctionList}">
					<div class="swiper-slide" style="padding:1em; border:1px solid #F2F4FB; border-radious:2em; margin:10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.05)">
						<div style="width:200px; height:200px" class="flex-box align-center">
							<c:choose>
								<c:when test="${auctionDto.auctionMainImg>0}">
									<a href="${pageContext.request.contextPath}/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
										<img style="max-width:200px; width:auto;  height:auto; max-height:200px;" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${auctionDto.auctionMainImg}">
									</a>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
										<img style="max-width:200px; max-height:200px; height:auto; width:auto; " src="${pageContext.request.contextPath}/static/image/noimage.png">
									</a>
								</c:otherwise>
							</c:choose>
						</div>
				<!-- 남은시간 -->
						<div class="row">
							<c:choose>
								<c:when test="${auctionDto.finish==true}">
									<span>종료된 상품</span>
								</c:when>
								<c:otherwise>
									<div class="rest-time" data-finish-time="${auctionDto.finishTime}">
										남은시간 : ${auctionDto.time}
									</div>
								</c:otherwise>
							</c:choose>
						</div>
				<!-- 제목 -->
						<div class="row" style="width:200px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis" title="${auctionDto.auctionTitle}">
							<a href="${pageContext.request.contextPath}/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
								${auctionDto.auctionTitle} 
								<c:if test="${auctionDto.auctionReply!=0}">(${auctionDto.auctionReply})</c:if>
							</a>
						</div>
					</div>
				</c:forEach>
			<!-- If we need navigation buttons -->
			</div>
			<div class="swiper-button-prev" style="color:#9DACE4"></div>
			<div class="swiper-button-next" style="color:#9DACE4"></div>
		</div>
	<!-- 테이블 끝 -->
    </div>
<!-- 경매 끝 -->
  </article>
</section>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>