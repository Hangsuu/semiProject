<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  <aside></aside>
  
  
  
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
    	<form action="exit" method="post">
        
            <div class="row center">
            <h2>회원 탈퇴</h2>
            </div>
            
        <div>
        	비밀번호 확인: <input type="password" name="memberPw" required><a></a>
        </div>
  
        <button>탈퇴</button>
    </form>
        		
 		<c:if test = "${param.mode == 'error'}">
 		<h2>비밀번호가 일치하지 않습니다</h2>
 		</c:if>


    </div>
    
    
     
 		

 		
  </article>
  
   <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
