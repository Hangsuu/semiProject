<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
 
	<!-- section -->
<section class="member-login-section">

  <article>
    <form action="adminCheck" method="post">
      <div class="login-form">
        <div>
            <div><h3>관리자 인증</h3></div>
        </div>
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
       </div>
    </form>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>