<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%-- css import --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/home.css" />
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
    />
    <title>Document</title>
  </head>
  <body>
    <!-- main -->
    <main>
      <!-- header -->
      <header>
        <%-- base.css --%>
        <div class="favicon">
          <img src="${pageContext.request.contextPath}/static/image/monsterball.png" />
          <div>1조 홈페이지</div>
        </div>
      </header>

      <!-- nav -->
      <nav>
        <%-- base.css --%>
        <div class="nav-bar">
          <div>
            <a href="${pageContext.request.contextPath}/"><span>홈</span></a>
          </div>
          <div>
            <a href="#"><span>포켓몬도감</span></a>
            <div>
              <div>
                <a href="#"><span>포켓몬리스트</span></a>
              </div>
              <div>
                <a href="#"><span>개체값 시뮬레이터</span></a>
              </div>
              <div>
                <a href="#"><span>개체값 계산</span></a>
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
                <a href="#"><span>포켓몬교환 게시판</span></a>
              </div>
            </div>
          </div>
          <div>
            <a href="#"><span>레이드게시판</span></a>
          </div>
          <div>
            <a href="#"><span>포켓몬소설</span></a>
          </div>
          <div>
            <a href="#"><span>회원</span></a>
            <div>
              <div>
                <a href="#"><span>로그인or로그아웃</span></a>
              </div>
              <div>
                <a href="#"><span>마이페이지</span></a>
              </div>
              <div>
                <a href="#"><span>인장뽑기</span></a>
              </div>
              <div>
                <a href="#"><span>내 활동</span></a>
              </div>
            </div>
          </div>
        </div>
      </nav>     