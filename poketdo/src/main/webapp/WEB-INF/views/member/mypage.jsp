<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
   
 


    
    
    
      <script type="text/javascript">           
		function MakeCard() {
			document.location.href="/cardGenerator"; <!-- 다른페이지로 이동하는 함수 -->
		}                                      
	</script>
    
    
    
    
    <style>
    
    	#myDiv {
			width: 500px;
	      height: 300px;
	    
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
    
    
    <script>
	
		function saveImage() {
		  // 저장하려는 div의 id 가져오기
		  const divId = "myDiv";
		
		  // 저장할 이미지 파일 이름
		  const fileName = "TrainerCard.png";
		
		  // div 요소 가져오기
		  const div = document.getElementById(divId);
		  
		  // div를 이미지로 변환하기
		  html2canvas(div).then(function(canvas) {
		    // 변환된 이미지 파일로 저장하기
		    let link = document.createElement("a");
		    document.body.appendChild(link);
		    link.download = fileName;
		    link.href = canvas.toDataURL();
		    link.click();
		    document.body.removeChild(link);
		  });
		}
		
	
	</script>
	
    
    
  <jsp:include page="/WEB-INF/views/member/memberAside.jsp"></jsp:include>
  
  <!-- article -->
  <article class="flex-all-center">
     <div class= "container-500">
	    <c:choose>
	    <c:when test = "${profile != null}">
	    	<div id="myDiv">
	    		<img width="500" height="300" src="/attachment/download?attachmentNo=${profile.attachmentNo}"> 
	    	</div>
			<button type="button" class = "form-btn positive w-100 mt-30" onclick="saveImage()">카드 이미지 저장하기</button>
			<button type="button" class = "form-btn neutral w-100 mt-10 mb-30" onclick="MakeCard()">트레이너 카드 만들기</button>
			
	    	
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
