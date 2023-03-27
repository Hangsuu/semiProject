<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  <aside></aside>
  
  <div>
  <a href="#">내활동</a>
  </div>
  <div>
  <a href="/member/edit">개인정보수정</a>
  </div>
  <div>
  <a href="#">트레이너카드</a>
  </div>
  <div>
  <a href="/member/exit">회원탈퇴</a>
  </div>
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
	    <c:choose>
	    <c:when test = "${Profile != null}">
	    	<img width="500" height="300" src="/attachment/download?attachmentNo=${profile.attachmentNo}">
	    	<
	    	
	    	
	    </c:when>
 		<c:otherwise>
 			트레이너 카드 없음
 			<br>
 			<a href = "#">만들기</a>
 		</c:otherwise>
 		</c:choose>
 	</div>	
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
