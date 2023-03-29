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
    <link rel="stylesheet" type="text/css" href="/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/static/css/page.css" />
    <!-- font-awesome CDN -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
    />
    <!-- 링크확인창 CDN -->
    <script src="https://cdn.jsdelivr.net/gh/hangsuu/confirm-link@latest/confirm-link.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> 
    <title>Document</title>
  </head>
  <body>
    <main>
    <div class="container-1200">
      <!-- header -->
      <header class="float-box" style="min-height:70px">
        <%-- base.css --%>
        <div class="float-left">
          <a href="/">
            <img src="/static/image/main.jpg" style="width:300px; height:auto"/>
          </a>
        </div>
        <div class="float-right mt-40">
        	<div style="display:inline-block">
				<c:choose>
					<c:when test="${empty sessionScope.memberId}">
						<a href="/member/login"><span>로그인</span></a>
					</c:when>
					<c:otherwise>
						<a href="/member/logout"><span>로그아웃</span></a>
					</c:otherwise>
				</c:choose>
        	</div>
			<div style="display:inline-block">
				<a href="#"><span>인장뽑기</span></a>
			</div>
			<div style="display:inline-block">
				<c:if test="${sessionScope.memberId != null}">
					<a href="/message/receive"><span>쪽지</span></a>
				</c:if>
			</div>
			<div style="display:inline-block">
				<c:if test="${sessionScope.memberLevel == '마스터'}">
					<a href="/admin/adminCheck"><span>관리 페이지</span></a>
				</c:if>
			</div>
			<div style="display:inline-block">
				<a href="/member/mypage"><span>마이페이지</span></a>
			</div>
			<div style="display:inline-block">
				<a href="/message/receive">쪽지</a>
			</div>
        </div>
      </header>

      <!-- nav -->
      <div class="row" style="margin-bottom: 0px;">
	      <nav>
	        <%-- base.css --%>
	        <div class="nav-bar">
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
					<div>
		              <a href="/combination/list?page=1"><span>공략 게시판</span></a>
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
	                <a href="/combination/simulator?page=1&tagList="><span>조합시뮬레이터</span></a>
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
	  <hr class="mg-0"/>
	</div>