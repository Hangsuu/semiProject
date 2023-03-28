<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  <aside></aside>
  
  
  
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
    	<form action="find" method="post">
        
        	<div>
        	이메일 확인: <input type="text" name="memberEmail" required> 
        	</div>
        
        
        
            <div class="form-btn w-100">
            <button>찾기</button>
            </div>
            
       </form>
        		
 		<c:if test = "${param.mode == 'error'}">
 			<h2>정보가 일치하지 않습니다</h2>
 		</c:if>


    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
