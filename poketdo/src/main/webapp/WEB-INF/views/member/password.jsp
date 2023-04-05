<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<style>
    
    
    
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
   
   
    aside {
    	float: left;
    	width: 30%;
    
    	}
    
    article {
    	float: right;
    	width: 80%
    	}
 
   
     
     .ablock {
    
     text-decoration-line: none;
     text-decoration: none;
     display: block;
     
     
     }
     
	    ablock:visited { text-decoration: none; }
	    ablock:hover { text-decoration: none; }
	    ablock:focus { text-decoration: none; }
	    ablock:hover, ablock:active { text-decoration: none; }
	    
	    
    
    </style>

    <jsp:include page="/WEB-INF/views/member/memberAside.jsp"></jsp:include>
  
  
  <!-- article -->
  <article class="flex-all-center">
     <div class= "container-500 center">
    	<form action="password" method="post">
        
      <h1 class="mb-50">비밀번호 변경</h1>
		

			<div class="left" style="height: 100px">
			<label>현재 비밀번호</label>
			<input class="form-input w-100"  type="password" name="currentPw" required> <br><br>
			</div>
			
			<div class="left">
			<label>변경 비밀번호</label>
			<input class="form-input w-100" type="password" name="changePw" required> <br><br>
			</div>
			
			
			
			<button class="form-btn positive w-100">변경</button>
		</form>
		
		<!-- 오류가 발생한 경우 보여줄 메세지 -->
		<c:if test="${param.mode == 'error'}">
			<h2>비밀번호가 일치하지 않습니다</h2>
		</c:if>

    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
