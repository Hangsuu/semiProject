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

  
  
  
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
    	<form action="findPw" method="post">
        
        	<div>
        	아이디: <input type="text" name="memberId" required> 
        	</div>
   
        	<div>
        	이메일: <input type="text" name="memberEmail" required> 
        	</div>
        
        
        
            <div class="form-btn w-100">
            <button>찾기</button>
            </div>
            
       </form>
        		
 
		<c:if test="${param.mode == 'error'}">
              <span style="color:red; font-weight:bold;">정보가 일치하지 않습니다</span>
            </c:if>

    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
 		

 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
