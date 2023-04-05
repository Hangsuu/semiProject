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
        
            <div class="row center mb-50">
            <h1>회원 탈퇴</h1>
            </div>
            
        <div class="center">
        	<input class="form-input w-100" type="password" name="memberPw" placeholder="비밀번호를 입력하세요" required><a></a>
        </div>
        
        
  
  	<c:if test = "${param.mode == 'error'}">
 		<h5 class="row left" style="color:red;">비밀번호가 일치하지 않습니다</h5>
 		</c:if>
  
  
  <div class="center">
        <button class="form-btn w-100 positive mt-30">탈퇴</button>
        </div>
        
        
       
        
    </form>
        	
        	
          </div> 		
 	

 
    
    
     
 		

 		
  </article>
  
   <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
