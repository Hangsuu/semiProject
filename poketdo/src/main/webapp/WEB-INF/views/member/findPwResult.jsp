<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.kh.poketdo.component.RandomComponent" %>




<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  
  
  <!-- article -->
  <article class="flex-all-center">
  	<form action="findPw" method="post">
     <div class= "container-500 center">
    	
		<h2>${memberDto.memberId}님의 새로운 비밀번호는 ${newPassword}입니다.</h2>
		<button>로그인하기</button>
    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		
	</form>
 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
