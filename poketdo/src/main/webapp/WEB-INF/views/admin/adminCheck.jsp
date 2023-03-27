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
            <div><h3>������ ����</h3></div>
        </div>
        <div><input type="password" name="memberPw" placeholder="��й�ȣ" autocomplete="off" required></div>
        <div><button type="submit">�α���</button></div>
        <div>
          <c:choose>
            <c:when test="${valid == 'no'}">
              �̸��� �Ǵ� ��й�ȣ�� �߸� �ԷµǾ����ϴ�
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