<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  <article class="flex-all-center">
     <div class= "container-500 center" style="height:60vh;">
    	<h1 class="mb-50">아이디 찾기 결과</h1>

		<h2 class="mb-50">아이디는 ${requestScope.findId} 입니다</h2>
		<a href="${pageContext.request.contextPath}/member/login"><button class="form-btn neutral w-100 mt-10" type="button">로그인하기</button></a>
    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
