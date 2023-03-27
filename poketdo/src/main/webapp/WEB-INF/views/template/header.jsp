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
    <main class="container-1200">
      <!-- header -->
      <header>
        <%-- base.css --%>
        <div class="favicon">
          <a href="/">
            <img src="/static/image/monsterball.png" />
            <div>1조 홈페이지</div>
          </a>
        </div>
      </header>

      <!-- nav -->
      <nav>
        <%-- base.css --%>
        <div class="nav-bar">
          <div>
            <a href="/"><span>홈</span></a>
          </div>
          <div>
            <a href="#"><span>포켓몬도감</span></a>
            <div>
              <div>
                <a href="#"><span>포켓몬리스트</span></a>
              </div>
              <div>
                <a href="/simulator"><span>개체값 시뮬레이터</span></a>
              </div>
              <div>
                <a href="/calculator"><span>개체값 계산</span></a>
              </div>
            </div>
          </div>
          <div>
            <a href="#"><span>게시판</span></a>
            <div>
              <div>
                <a href="#"><span>자유게시판</span></a>
              </div>
              <div>
                <a href="#"><span>인기게시판</span></a>
              </div>
              <div>
                <a href="/pocketmonTrade"><span>포켓몬교환 게시판</span></a>
              </div>
              <div>
                <a href="/auction/list?page=1"><span>굿즈 경매 게시판</span></a>
              </div>
            </div>
          </div>
          <div>
            <a href="/raid/list?page=1"><span>레이드게시판</span></a>
          </div>
          <div>
            <a href="#"><span>포켓몬소설</span></a>
          </div>
          <div>
            <a href="#"><span>회원</span></a>
            <div>
              <div>
                <c:choose>
                  <c:when test="${empty sessionScope.memberId}">
                    <a href="/member/login"><span>로그인</span></a>
                  </c:when>
                  <c:otherwise>
                    <a href="/member/logout"><span>로그아웃</span></a>
                  </c:otherwise>
                </c:choose>
              </div>
              <div>
                <a href="/member/mypage"><span>마이페이지</span></a>
              </div>
              <div>
                <a href="#"><span>인장뽑기</span></a>
              </div>
              <div>
                <a href="#"><span>내 활동</span></a>
              </div>
              <div>
                <c:if test="${sessionScope.memberId != null}">
                  <a href="/message/receive"><span>쪽지</span></a>
                </c:if>
              </div>
            </div>
          </div>
        </div>
      </nav>
