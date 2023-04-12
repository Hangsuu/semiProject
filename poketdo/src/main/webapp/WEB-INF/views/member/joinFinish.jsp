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
 




  <!-- aside -->
  <aside></aside>
  
	
  
  <!-- article -->
  <article>
        
  
     <div class="super-center"  style="height:60vh">
		<div class= "container-500 center mb-30">
			<h1 class="mb-50">회원가입을 환영합니다!</h1>
 		
 	
 	
 	   <div>
        	<a href="${pageContext.request.contextPath}/member/login"><button class="form-btn positive w-100 mb-10" type="button">로그인하기</button></a>
        	<a href="${pageContext.request.contextPath}/"><button class="form-btn neutral w-100" type="button">홈으로</button></a>
        
        </div>
			 	
 	
 	</div>	
 	
 	</div>
 	
 	  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
