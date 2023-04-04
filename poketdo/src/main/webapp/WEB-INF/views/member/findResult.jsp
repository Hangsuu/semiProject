<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  
  
  <!-- article -->
  <article class="flex-all-center">
     <div class= "container-500 center">
    	<h1>아이디 찾기 결과</h1>

		<h2>아이디: ${requestScope.findId}</h2>
		<button>로그인하기</button>
    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
