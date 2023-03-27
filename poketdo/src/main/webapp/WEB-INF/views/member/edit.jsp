<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    

  <!-- aside -->
  <aside></aside>
  
  
  
  
  <!-- article -->
  <article>
     <div class= "container-500 center">
    	<form action="edit" method="post">
        
            <div class="row center">
            <h2>개인정보 변경</h2>
            </div>
            
        <div>
        	${memberDto.memberId}
        </div>
        <div>
        	<input type="password" name="memberPw" placeholder="확인을 위한 비밀번호 입력" 
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        	<input type="text" name="memberNick" value="${memberDto.memberNick}"
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        	<input type="date" name="memberBirth" value="${memberDto.memberBirth}" 
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        <button>수정</button>
        </div>




    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
    </form>
 		
 		
 		<c:if test = "${param.mode == 'error'}">
 		<h2>비밀번호가 일치하지 않습니다</h2>
 		</c:if>
 		
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
