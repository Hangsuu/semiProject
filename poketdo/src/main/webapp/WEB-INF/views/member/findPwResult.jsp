<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.kh.poketdo.component.RandomComponent" %>




<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
  
    <style>
    
    
 	.super-center{
 			display: flex;
  flex-direction: row;
  align-items: center 
          }
 
 
 	h1 {
 		font-size: 30px}
 	
 	.form-input {
		display: block;
		
		padding: 15px;
		font-size: 20px;
		border-radius: 5px;
		border: 1px solid #ccc;
				
			}	
			
	.form-btn {
		padding: 15px;
		font-size: 20px;
	}
 
 </style>
 
  
  
  <!-- article -->
  <article>
  	  <form class="super-center" style="height:60vh;" action="findPw" method="post" autocomplete="off">
        <div class= "container-500 center mb-30">
    	
		<h3>${memberDto.memberId}님의 새로운 비밀번호는 ${newPassword}입니다.</h3>
		<a href="${pageContext.request.contextPath}/member/join"><button class="form-btn neutral w-100 mt-10 mt-50" type="button">로그인하기</button></a>
    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		
	</form>
 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
