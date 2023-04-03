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
 
   
     a {
    
     text-decoration-line: none;
     text-decoration: none;
     display: block;
     
     
     }
     
	    a:visited { text-decoration: none; }
	    a:hover { text-decoration: none; }
	    a:focus { text-decoration: none; }
	    a:hover, a:active { text-decoration: none; }
	    
	    
    
    </style>
    


  <jsp:include page="/WEB-INF/views/member/memberAside.jsp"></jsp:include>
  
  
  
  <!-- article -->
  <article class="flex-all-center">
    	<form style="height: 60vh" action="edit" method="post">
     	<div class="container-500 center">
        
            <div class="row center">
            <h1 class="mb-50">개인정보 변경</h1>
            </div>
            
        <div class="row left">
        	아이디 : ${memberDto.memberId}
        </div>
        <div class="row">
        	<input type="password" name="memberPw" placeholder="확인을 위한 비밀번호 입력" 
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div class="row">
        	<input type="text" name="memberNick" value="${memberDto.memberNick}"
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div class="row">
        	<input type="date" name="memberBirth" value="${memberDto.memberBirth}" 
        	class="form-input w-100" autocomplete="off" required>
        </div>
        
        <div class="row">
        	<input type="email" name="memberEmail" value="${memberDto.memberEmail}"
        	class="form-input w-100" autocomplete="off" required>
        </div>
        
        <div class="row left">
        	회원 등급 : ${memberDto.memberLevel}
        </div>
        
        
        <div>
        <button type="submit" class="form-btn w-100 positive mt-30">수정</button>
        </div>




    </div>
    
    </form>
 		
 		
 		<c:if test = "${param.mode == 'error'}">
 		<h1>비밀번호가 일치하지 않습니다</h1>
 		</c:if>
 		
  </article>
  
  
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
