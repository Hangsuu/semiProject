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
     <div class= "container-500">
    	<form action="exit" method="post">
        
            <div class="row center mb-30">
            <h1>회원 탈퇴</h1>
            </div>
            
        <div class="center mb-50">
        	비밀번호 확인: <input class="input-form" type="password" name="memberPw" required><a></a>
        </div>
        
        <div class="center">
  
        <button class="form-btn w-70 positive">탈퇴</button>
        </div>
        
        
    </form>
        		
 		<c:if test = "${param.mode == 'error'}">
 		<h2>비밀번호가 일치하지 않습니다</h2>
 		</c:if>


    </div>
    
    
     
 		

 		
  </article>
  
   <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
