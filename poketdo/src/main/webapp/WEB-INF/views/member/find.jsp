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
  <article>
   <form class="super-center" style="height:60vh;" action="find" method="post" autocomplete="off">
     <div class= "container-500 center mb-30">
   		     <h1 class="mb-50">아이디 찾기</h1>
        
			
        	<div class="left">
 
        	<input class="form-input w-100" type="text" name="memberEmail" placeholder="이메일을 입력하세요" required > 
        	</div>
        
        
        	<c:if test = "${param.mode == 'error'}">
 			<h2>정보가 일치하지 않습니다</h2>
 			</c:if>
        
        
        
            <div>
            	<button class="form-btn positive w-100 mt-30" type="submit">찾기</button>
            </div>
            
     
        		
 	


    </div>
    
      </form>
      
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
