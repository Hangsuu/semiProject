<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <%-- css import --%>
    <link rel="stylesheet" type="text/css" href="/static/css/load.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/commons.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/test.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/component.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/pocketdex.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/seal.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/page.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/reply.css" />
    <!-- font-awesome CDN -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
    <!-- 링크확인창 CDN -->
    <script src="https://cdn.jsdelivr.net/gh/hangsuu/confirm-link@latest/confirm-link.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> 
    <script src="/static/js/pocketdex.js"></script>
    <title>세미프로젝트 A조 POCKETDO!</title>
  </head>
  <body>
    <main>
<header class="container-1200" style="min-height:70px;">
    <!-- header -->
<div class="right mb-30" style="background-color:#9DACE4">
   	<div style="display:inline-block; padding:10px">
		<c:choose>
			<c:when test="${empty sessionScope.memberId}">
			<!-- css:commons, base -->
				<a href="/member/login" class="link center"><span class="header-menu">로그인</span></a>
			</c:when>
			<c:otherwise>
				<a href="/member/logout" class="link center"><span class="header-menu">로그아웃</span></a>
			</c:otherwise>
		</c:choose>
     </div>
	<div style="display:inline-block">
		<c:if test="${sessionScope.memberId != null}">
			<a href="/seal/list" class="link center"><span class="header-menu">인장뽑기</span></a>
		</c:if>
	</div>
	<div style="display:inline-block">
		<c:if test="${sessionScope.memberId != null}">
			<a href="/message/receive" class="link center"><span class="header-menu">쪽지</span></a>
		</c:if>
	</div>
	<div style="display:inline-block">
		<c:if test="${sessionScope.memberLevel == '마스터'}">
			<a href="/admin/adminCheck" class="link center"><span class="header-menu">관리 페이지</span></a>
		</c:if>
	</div>
	<div style="display:inline-block" class="me-30">
		<c:if test="${sessionScope.memberId != null}">
			<a href="/member/mypage" class="link center"><span class="header-menu">마이페이지</span></a>
		</c:if>
	</div>
</div>
      <%-- base.css --%>
    <div class="float-box" style="hegith:80px">
      <div class="float-left w-30">
        <a href="/">
          <img src="/static/image/main.png" style="width:300px"/>
        </a>
      </div>
    <div class="float-right w-70">
    <!-- nav -->
     <nav class="flex-box flex-auto-width" style="hegith:80px">
       <%-- base.css --%>
       <div class="nav-bar flex-box align-center">
         <div>
           <a href="/"><span>커뮤니티</span></a>
           <div>
			<div>
			  <a href="/board/list"><span>자유 게시판</span></a>
			</div>
			<div>
			  <a href="/board/hot"><span>인기 게시판</span></a>
			</div>
			<div>
			  <a href="/auction/list?page=1"><span>굿즈 경매 게시판</span></a>
			</div>
		</div>
         </div>
         <div>
           <a href="/pocketdex/list"><span>포켓몬도감</span></a>
         </div>
         <div>
           <a href="/board/list"><span>연구실</span></a>
           <div>
             <div>
               <a href="/simulator"><span>개체값 시뮬레이터</span></a>
             </div>
             <div>
               <a href="/calculator"><span>스탯 계산기</span></a>
             </div>
			 <div>
               <a href="/combination/list?page=1&tagList=&keyword=&column="><span>공략 게시판</span></a>
             </div>
           </div>
         </div>
         <div>
           <a href="#"><span>포켓몬 게임</span></a>
           <div>
             <div>
               <a href="/raid/list?page=1"><span>레이드 참가</span></a>
             </div>
             <div>
               <a href="/pocketmonTrade"><span>포켓몬교환 게시판</span></a>
             </div>
           </div>
         </div>
         <div>
           <a href="#"><span>트레이너카드</span></a>
         </div>
       </div>
     </nav>
    </div>
    </div>
</header>

<div class="media-css" style="border-top:2px solid #9DACE4"></div>
