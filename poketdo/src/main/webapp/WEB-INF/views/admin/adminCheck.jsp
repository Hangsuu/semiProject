<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
 
	 <style>
	 
	.super-center{
 			display: flex;
		  flex-direction: row;
		  align-items: center;
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
 
 


  <article class="center">
    <form class="flex-all-center" style="height:60vh;" action="adminCheck" method="post">
      <div class="container-400 center">
        <div>
           <h1 class="pb-30">관리자 인증</h1>
        
        <div class= "row center">
        <input class="form-input w-100" type="password" name="memberPw" placeholder="비밀번호" autocomplete="off" required>
        </div>
        <div class= "row center">
        <button class="form-btn w-100 positive" type="submit">로그인</button>
        </div>
        
          <c:choose>
            <c:when test="${valid == 'no'}">
              이메일 또는 비밀번호가 잘못 입력되었습니다
            </c:when>
            <c:otherwise>
              &nbsp;
            </c:otherwise>
          </c:choose>
        </div>
       </div>
    </form>
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>