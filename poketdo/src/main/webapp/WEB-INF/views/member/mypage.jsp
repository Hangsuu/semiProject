<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <script type="text/javascript">           
		function MakeCard() {
			document.location.href="http://localhost:8080/cardGenerator"; <!-- 다른페이지로 이동하는 함수 -->
		}                                      
	</script>
    
    
    
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
	    <c:choose>
	    <c:when test = "${profile != null}">
	    	<img width="500" height="300" src="/attachment/download?attachmentNo=${profile.attachmentNo}"> 

			<button type="button" class = "form-btn positive w-100 mt-30" onclick="MakeCard()">다시 만들기</button>
			
			<br>
	    	카카오톡으로 공유하기 :
	    	<br>
	    	트위터로 공유하기 : 
	    	
	    </c:when>
 		<c:otherwise>
 			<div class="row center mb-30"><h2>트레이너 카드 없음</h2></div>
 			
 			<button type="button" class = "form-btn positive w-100 mt-30" onclick="MakeCard()">만들기</button>
 		
 		
 		
 		</c:otherwise>
 		</c:choose>
 	</div>	
 

      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : (header.referer.endsWith('/member/joinFinish') ? '/' : header.referer)}">


 </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
