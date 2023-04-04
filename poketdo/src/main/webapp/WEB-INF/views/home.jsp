<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- swiper 의존성 주입 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<script src="/static/js/swiper.js"></script>
<!-- timer 의존성 주입 -->
<script src="/static/js/timer.js"></script>
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
          <a href="/board/hot">+더보기</a>
         
        </div>
        <div class="home-board-list">내용</div>
      </div>
      <%-- home.css / component.css --%>
      <div class="home-cool-board title-body w-50">
        <%-- home.css --%>
        <div class="home-board-title">
          <h2>🦄오늘의 포켓몬</h2>
          <a href="#">+더보기</a>
        </div>
        <div class="home-board-list">내용</div>
      </div>
    </div>
<%-- 포켓몬 교환 --%>
    <%-- base.css / component.css --%>
    <div class="home-sector home-raid-board title-body">
      <%-- home.css --%>
      <div class="home-board-title">
        <h2>🤝교환해요</h2>
        <a href="/auction/list?page=1">+더보기</a>
      </div>
      <div>
        <div>
          <div>오늘 레이드 뛰실분</div>
          <div>
            <ul>
              <li>날짜: 2023/03/04</li>
              <li>시간: 17:00</li>
            </ul>
          </div>
          <div>
            <%-- home.css --%>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="pool"></div>
          </div>
        </div>
        <div>
          <div>오늘 레이드 뛰실분</div>
          <div>
            <ul>
              <li>날짜: 2023/03/04</li>
              <li>시간: 17:00</li>
            </ul>
          </div>
          <div>
            <%-- home.css --%>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="pool"></div>
          </div>
        </div>
        <div>
          <div>오늘 레이드 뛰실분</div>
          <div>
            <ul>
              <li>날짜: 2023/03/04</li>
              <li>시간: 17:00</li>
            </ul>
          </div>
          <div>
            <%-- home.css --%>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="pool"></div>
          </div>
        </div>
        <div>
          <div>오늘 레이드 뛰실분</div>
          <div>
            <ul>
              <li>날짜: 2023/03/04</li>
              <li>시간: 17:00</li>
            </ul>
          </div>
          <div>
            <%-- home.css --%>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="party pool"></div>
            <div class="pool"></div>
          </div>
        </div>
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
          <a href="/raid/list?page=1">+더보기</a>
        </div>
        <div class="home-board-list">
        	<c:forEach var="raidDto" items="${raidList}">
        	    <div class="row" style="font-size:17px">
	            	<a href="/raid/detail?page=1&allboardNo=${raidDto.allboardNo}" class="link">
	            		<span class="home-board-type">[${raidDto.raidMonster}]</span>
	            		 ${raidDto.raidTitle} ${raidDto.raidCount}/4
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
          <a href="/combination/list?page=1">+더보기</a>
        </div>
        <div class="home-board-list">
            <c:forEach var="combinationDto" items="${combinationList}">
            	<div class="row" style="font-size:17px">
	            	<a href="/combination/detail?page=1&allboardNo=${combinationDto.allboardNo}" class="link">
	            		<span class="home-board-type">[${combinationDto.combinationType}]</span>
	            		 ${combinationDto.combinationTitle} 
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
        <a href="/auction/list?page=1">+더보기</a>
      </div>
	<!-- 게시판 테이블(swiper) -->
		<div class="swiper mt-20">
			<div class="swiper-wrapper">
				<c:forEach var="auctionDto" items="${auctionList}">
					<div class="swiper-slide" style="padding:1em; border:1px solid #F2F4FB; border-radious:2em; margin:10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.05)">
						<div style="width:200px; height:200px" class="flex-box align-center">
							<c:choose>
								<c:when test="${auctionDto.auctionMainImg>0}">
									<a href="/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
										<img style="max-width:200px; width:auto;  height:auto; max-height:200px;" src="/attachment/download?attachmentNo=${auctionDto.auctionMainImg}">
									</a>
								</c:when>
								<c:otherwise>
									<a href="/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
										<img style="max-width:200px; max-height:200px; height:auto; width:auto; " src="/static/image/noimage.png">
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
							<a href="/auction/detail?allboardNo=${auctionDto.allboardNo}&page=1" class="link">
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