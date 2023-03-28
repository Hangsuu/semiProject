<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



  <script type="text/javascript">

        function myFunction() {
       
            var checkbox = document.getElementById("checkcheck");
            var target = document.getElementById("target");

            if (checkbox.checked == true){
                target.style.display = "block";
            } else {
                target.style.display = "none";
            }
        }
      
        
    </script>
    
    
    <script>

    $(document).ready(function() {
        $('input[name="color"]').on('change', function() {
            var value = $(this).val();
            if (value === 'scarlet') {
            $('#image1').show();
            $('#image2').hide();
            } else if (value === 'violet') {
            $('#image1').hide();
            $('#image2').show();
            }
        });
    });
	</script>
    
    
    
		<script type="text/javascript">
		    function previewImg(input) {
		        if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function(e) {
		            document.getElementById('preview').src = e.target.result;
		        };
		        reader.readAsDataURL(input.files[0]);
		        } else {
		        document.getElementById('preview').src = "";
		        }
		    }
		
		</script>
		
		<script type="text/javascript">
		  $(function(){
		    var $card111 = $(".card111");
		    var currentInputNo = 0;
		    $card111.on("click", function(){
		      var inputNo = $("[name=cardNo]").val();
		      if(inputNo.length > 3) {
		        alert("숫자는 3자리수까지만 입력 가능합니다.");
		        return;
		      }
		      if(currentInputNo >= 6) {
		        alert("모든 칸이 채워졌습니다.");
		        return;
		      }
		      currentInputNo++;
		      $("[name=cardNo]").val("");
		      $("[name=cardSlot" + currentInputNo + "]").attr("src", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + inputNo + ".png");
		    });
		  });
		</script>

<style>
    .image-container {
      position: relative;
    }
  
    .image-1 {
        
      z-index: 1;
    }
  
    .image-2 {
      position: absolute;
      top: 360px;
      left: 340px;
      z-index: 2;
    }

    .slot-1 {
      position: absolute;
      top: 370px;
      left: 20px;
      z-index: 2;
    }

    .slot-2 {
      position: absolute;
      top: 370px;
      left: 125px;
      z-index: 2;
    }

    .slot-3 {
      position: absolute;
      top: 370px;
      left: 230px;
      z-index: 2;
    }

    .slot-4 {
      position: absolute;
      top: 445px;
      left: 20px;
      z-index: 2;
    }

    .slot-5 {
      position: absolute;
      top: 445px;
      left: 125px;
      z-index: 2;
    }

    .slot-6 {
      position: absolute;
      top: 445px;
      left: 230px;
      z-index: 2;
    }


  </style>
    

  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>
    <form class="join-form" action="join" method="post" enctype="multipart/form-data" autocomplete="off">
        
      <div class= "container-500 center">
            <div class="row center">
            <h2>회원가입</h2>
            </div>
            
	        <div class="row">
	        	<input type="text" name="memberId" placeholder="아이디" class="form-input w-100" required>
	        	<div class="left valid-message">사용 가능한 아이디입니다</div>
	        	<div class="left invalid-message">아이디는 영문소문자로 시작하며 숫자를 포함한 8~20자로 작성하세요</div>
	        	<div class="left invalid-message2">이미 사용 중인 아이디입니다</div>
	        </div>
	        <div class="row">
	        	<input type="password" name="memberPw" placeholder="비밀번호" class="form-input w-100" required>
	        	<div class="left valid-message">올바른 비밀번호 형식입니다</div>
	        	<div class="left invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요</div>
	        </div>
	        <div class="row">
    	    	<input type="password" name="memberPwRe" placeholder="비밀번호확인" class="form-input w-100" required>
    	    	<div class="left valid-message">비밀번호가 일치합니다</div>
	        	<div class="left invalid-message">비밀번호가 일치하지 않습니다</div>
	        	<div class="left invalid-message2">비밀번호를 먼저 작성하세요</div>
    	    </div>
	        <div class="row">
	        	<input type="text" name="memberNick" placeholder="닉네임" class="form-input w-100" required>
	        	<div class="left valid-message">사용가능한 닉네임입니다</div>
	        	<div class="left invalid-message">닉네임은 한글 또는 숫자 2~10글자로 작성하세요</div>
	        	<div class="left invalid-message2">이미 사용중인 닉네임입니다</div>
	        </div>
        	<div class="row">
        		<input type="date" name="memberBirth" placeholder="생년월일" class="form-input w-100" required>
        	</div>
         	<div class="row">
        		<input type="email" name="memberEmail" placeholder="이메일" class="form-input w-100" required>
        	</div>
        
        
   
    <div class="left">
    <input type="checkbox" id="checkcheck" onclick="myFunction()">트레이너 카드 생성(선택)
	</div>

    <div id = "target" style= "display:none" class="row left">
        <h2>트레이너 카드 미리보기</h2>
    
        <div>
            <img id="image1" src="/static/image/A.png" class="image-container image-1">
            <img id="image2" src="/static/image/B.png" class="image-container image-1" style= "display: none;" >
          </div>

             <div class="row">
                
                <input type="file" accept="image/*" onchange="previewImg(this);" >
                <img id="preview" width="150px" height="150px" class="image-container image-2">
                

            </div>


            <div>    
                <label>트레이너 이름</label>
                <input type="text" name="memberNick" autocomplete="off" 
                	class="form-input w-100"  >
            </div>
                
            <div>
                <label>국가</label> 
                <input type="text" name="memberPw" autocomplete="off"
                class="form-input w-100" >
            </div>
            <div>
                <label>게임월드 선택</label>
                <form>
                    <label>
                      <input type="radio" name="color" value="scarlet" checked>스칼렛
                    </label>
                    <label>
                      <input type="radio" name="color" value="violet">바이올렛
                    </label>
                </form>
            
            </div>
            <div>
                <label>친구코드</label>
                <br>
                <input class="form-input w-20" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
                    <span>
                    <span>-</span>
                    </span>
                <input class="form-input w-20" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
                    <span>
                    <span>-</span>
                    </span>
                <input class="form-input w-20" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
            </div>
            
            <div>
          
                <label>포켓몬을 선택해주세요(최대6마리)</label>
                <input type="number" name="cardNo" placeholder="포켓몬 이름">
  
                <button class="card111" type="submit">검색</button>
		
			</div>

	
                <img id="preview" name="cardSlot1" width="100px" height="60px" class="image-container slot-1">
                <img id="preview" name="cardSlot2" width="100px" height="60px" class="image-container slot-2">
                <img id="preview" name="cardSlot3" width="100px" height="60px" class="image-container slot-3">
                <img id="preview" name="cardSlot4" width="100px" height="60px" class="image-container slot-4">
                <img id="preview" name="cardSlot5" width="100px" height="60px" class="image-container slot-5">
                <img id="preview" name="cardSlot6" width="100px" height="60px" class="image-container slot-6">
                
             
   		
            
            <div>
                <label>트레이너 한마디</label>
                <input type="text" name="card-firstLength" placeholder="첫번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off" >
                <input type="text" name="card-secondLength" placeholder="두번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off" >
            </div>
   


	
    
    </div>
    
    	<div>
        <button type="submit" class="form-btn w-100">회원가입</button>
        </div>
    
    </div>
 
    
    
    
    </div>
    
    
    </form>
   
    
        
    
         <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
           
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
