<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  <aside></aside>
  
	
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
		<h1>개인정보 변경 완료</h1>
 	</div>	
  </article>
  
  
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
