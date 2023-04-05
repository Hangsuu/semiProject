<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/member-join.js"></script>


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
    <form class="super-center" style="height:80vh;" action="join" method="post" autocomplete="off">
        
      <div class= "container-500 center">
            <div class="row center">
            <h1>회원가입</h1>
            </div>
            
	        <div class="row left mt-30">
	        	<input class="form-input w-100" type="text" name="memberId" placeholder="아이디" required>
	        	<div class="valid-message">사용 가능한 아이디입니다</div>
				<div class="invalid-message">아이디는 영문소문자로 시작하며 숫자를 포함한 8~20자로 작성하세요</div>
				<div class="invalid-message2">이미 사용중인 아이디입니다</div>
			        	
	        </div>
	        <div class="row left">
	        	<input class="form-input w-100" type="password" name="memberPw" placeholder="비밀번호" required>
	        	<div class="valid-message">올바른 비밀번호 형식입니다</div>
				<div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요</div>
	        </div>
	        <div class="row left">
    	    	<input type="password" id="passwordRe" name="memberPwRe" placeholder="비밀번호 확인" class="form-input w-100" required>
    	    	<div class="valid-message">비밀번호가 일치합니다</div>
				<div class="invalid-message">비밀번호가 일치하지 않습니다</div>
				<div class="invalid-message2">비밀번호를 먼저 작성하세요</div>
    	    </div>
	        <div class="row left">
	        	<input  class="form-input w-100" type="text" name="memberNick" placeholder="닉네임" class="form-input w-100" required>
	        	<div class="valid-message">사용 가능한 닉네임입니다</div>
				<div class="invalid-message">닉네임은 한글 또는 숫자 2~10글자로 작성하세요</div>
				<div class="invalid-message2">이미 사용중인 닉네임입니다</div>
	        </div>
        	<div class="row left">
        		<input type="date" class="form-input w-100" name="memberBirth" placeholder="생년월일" required>
        	</div>
         	<div class="row left">
        		<input type="email" class="form-input w-100" name="memberEmail" placeholder="이메일" required>
        	</div>
        
    
    	<div>
        <button type="submit" class="form-btn positive w-100 mt-30 mb-30">회원가입</button>
        </div>
    
    </div>
 
    
    
    
    </form>
   
        
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
