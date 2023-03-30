<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- section -->
<section class="member-login-section">

  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>
    <form action="login" method="post">
      <div class="login-form">
        <div>
          <a href="/">
            <img src="/static/image/monsterball.png">
            <div>1조홈페이지</div>
          </a>
        </div>
        <div><input type="text" name="memberId" placeholder="아이디" value="${memberId}" autocomplete="off" required></div>
        <div><input type="password" name="memberPw" placeholder="비밀번호" autocomplete="off" required></div>
        <div><button type="submit">로그인</button></div>
        <div>
          <c:choose>
            <c:when test="${valid == 'no'}">
              이메일 또는 비밀번호가 잘못 입력되었습니다
            </c:when>
            <c:otherwise>
              &nbsp;
            </c:otherwise>
          </c:choose>
        </div>
        <div class="flex-row-grow">
          <div><a href="/member/find">아이디 찾기</a></div>
          <div><a href="/member/join">회원가입</a></div>
        </div>
      </div>
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : (header.referer.endsWith('/member/joinFinish') ? '/' : header.referer)}">
    </form>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
