<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/member-join.js"></script>

  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>
    <form class="join-form mt-50" action="join" method="post"  autocomplete="off">
        
      <div class= "container-500 center">
            <div class="row center">
            <h1>회원가입</h1>
            </div>
            
	        <div class="row left mt-50">
	        	<input type="text" name="memberId" placeholder="아이디" class="form-input w-100" required>
	        	<div class="valid-message">사용 가능한 아이디입니다</div>
				<div class="invalid-message">아이디는 영문소문자로 시작하며 숫자를 포함한 8~20자로 작성하세요</div>
			        	
	        </div>
	        <div class="row left">
	        	<input type="password" name="memberPw" placeholder="비밀번호" class="form-input w-100" required>
	        	<div class="valid-message">올바른 비밀번호 형식입니다</div>
				<div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요</div>
	        </div>
	        <div class="row left">
    	    	<input type="password" name="memberPwRe" placeholder="비밀번호 확인" class="form-input w-100" required>
    	    	<div class="valid-message">비밀번호가 일치합니다</div>
				<div class="invalid-message">비밀번호가 일치하지 않습니다</div>
				<div class="invalid-message2">비밀번호를 먼저 작성하세요</div>
    	    </div>
	        <div class="row left">
	        	<input type="text" name="memberNick" placeholder="닉네임" class="form-input w-100" required>
	        	<div class="valid-message">사용 가능한 닉네임입니다</div>
				<div class="invalid-message">닉네임은 한글 또는 숫자 2~10글자로 작성하세요</div>
				<div class="invalid-message2">이미 사용중인 닉네임입니다</div>
	        </div>
        	<div class="row left">
        		<input type="date" name="memberBirth" placeholder="생년월일" class="form-input w-100" required>
        	</div>
         	<div class="row left">
        		<input type="email" name="memberEmail" placeholder="이메일" class="form-input w-100" required>
        	</div>
        
    
    	<div>
        <button type="submit" class="form-btn w-100">회원가입</button>
        </div>
    
    </div>
 
    
    
    
    </form>
   
        
    
         <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
           
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
