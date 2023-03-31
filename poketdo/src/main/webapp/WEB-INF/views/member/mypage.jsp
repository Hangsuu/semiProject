<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <style>
    
   
   
    aside {
    	float: left;
    	width: 20%;
    
    	}
    
    article {
    	float: right;
    	width: 80%
    	}
 
    
    ul {
    	width: 200px;
    	
    	height: 1000px;
    	line-height : 30px;
    	display : block;
    	
    	font-size : 15px;
    	
    }
    
    li {
    	border : 1px solid;
    	padding : 20px 20px;
    }
    
     a {
    
     text-decoration-line: none;
     text-decoration: none;
     
     
     }
     
	    a:visited { text-decoration: none; }
	    a:hover { text-decoration: none; }
	    a:focus { text-decoration: none; }
	    a:hover, a:active { text-decoration: none; }
	    
	    
    
    </style>
    
    
    
    
    <div class= "container-1000"> 

  <!-- aside -->
  <aside>
  
  <ul class="row center mt-50">
        <li><a href="/member/edit">개인정보수정</a></li>
        <li> <a href="/member/myseal">나의 인장</a></li>
        <li> <a href="/member/exit">회원탈퇴</a></li>
       
    </ul>

  
  
  
  </aside>
  
  <!-- article -->
  <article>
     <div class= "row center mt-50">
	    <c:choose>
	    <c:when test = "${Profile != null}">
	    	<img width="500" height="300" src="/attachment/download?attachmentNo=${Profile.attachmentNo}"> 

		<img src="${image.data}" alt="">
	    	카카오톡으로 공유하기 :
	    	<br>
	    	트위터로 공유하기 : 
	    	
	    </c:when>
 		<c:otherwise>
 			트레이너 카드 없음
 			<br><br>
 			<button class = "form-btn w-50"><a href = "/cardGenerator">만들기</a></button>
 		</c:otherwise>
 		</c:choose>
 	</div>	
  </article>

      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : (header.referer.endsWith('/member/joinFinish') ? '/' : header.referer)}">



</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
