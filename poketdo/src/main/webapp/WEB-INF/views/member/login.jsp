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
 
  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>


    <form class="super-center" style="margin-top:100px; height:60vh;" action="login" method="post" autocomplete="off">
	<div class="container-500 center" >
      <div class="row center mb-50">
         <h1>로그인</h1>
         </div>
     
        <div>
        	<input class="row form-input w-100" type="text" name="memberId" placeholder="아이디" value="${memberId}" autocomplete="off" required>
        </div>
        
        <div>
        	<input class="row form-input w-100" type="password" name="memberPw" placeholder="비밀번호" autocomplete="off" required>
        </div>
        
     
       <div>
            <c:if test="${valid == 'no'}">
              <span style="color:red; font-weight:bold;">아이디 또는 비밀번호가 잘못 입력되었습니다</span>
            </c:if>
     
         </div>
        
        <div>
        	<button class="form-btn positive w-100 mt-20" type="submit">로그인</button>
        	<a href="${pageContext.request.contextPath}/member/join"><button class="form-btn neutral w-100 mt-10" type="button">회원가입</button></a>
        
        </div>
        
        
        <div class="flex-row-grow mt-10" style="margin-bottom:100px;" >
          <div class="w-50" style="border-right: 1px solid black" ><a href="${pageContext.request.contextPath}/member/find" style="text-decoration:none; font-size: 18px;">아이디 찾기   </a></div>
          <div class="w-50" ><a href="${pageContext.request.contextPath}/member/findPw" style="text-decoration:none; font-size: 18px;">   비밀번호 찾기</a></div>
          
          </div>
          
        </div> 
      
     
      
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : (header.referer.endsWith('/member/joinFinish') ? '/' : header.referer)}">
	
    </form>
    
            
  </article>
    

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
