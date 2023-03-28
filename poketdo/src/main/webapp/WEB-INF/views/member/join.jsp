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
		
		 <script>
		  function updatePreview() {
		    var inputText = document.getElementById("input-code").value;
		    var preview = document.getElementById("input-preview");
		    preview.innerText = inputText;
		  }
		</script>

<style>
    .image-container {
      position: relative;
      display: inline-block;
    }
  
    .image-1 {
        
      z-index: 1;
    }
  
    .image-2 {
      position: absolute;
      top: 80px;
      left: 340px;
      z-index: 2;
    }

    .slot-1 {
      position: absolute;
      top: 87px;
      left: 10px;
      z-index: 2;
    }

    .slot-2 {
      position: absolute;
      top: 87px;
      left: 115px;
      z-index: 2;
    }

    .slot-3 {
      position: absolute;
      top: 87px;
      left: 220px;
      z-index: 2;
    }

    .slot-4 {
      position: absolute;
      top: 160px;
      left: 10px;
      z-index: 2;
    }

    .slot-5 {
      position: absolute;
      top: 160px;
      left: 115px;
      z-index: 2;
    }

    .slot-6 {
      position: absolute;
      top: 160px;
      left: 220px;
      z-index: 2;
    }

	.input-code{
	  position: absolute;
	  top: 40px;
	  left: 40px;
	  z-index: 2;
	}

	.code-overlay {
		position: absolute;
		top: 33px;
		left: 270px;
		font-size: 25px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.nick-overlay {
		position: absolute;
		top: 33px;
		left: 35px;
		font-size: 25px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.com1-overlay {
		position: absolute;
		top: 233px;
		left: 20px;
		font-size: 25px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.com2-overlay {
		position: absolute;
		top: 260px;
		left: 20px;
		font-size: 25px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	
	#input-number {
		display: block;
		margin-top: 20px;
		padding: 10px;
		font-size: 18px;
		border-radius: 5px;
		border: 1px solid #ccc;
				
			}
			
			
	#input-nick {
		display: block;
		margin-top: 20px;
		padding: 10px;
		font-size: 18px;
		border-radius: 5px;
		border: 1px solid #ccc;
				
			}		
			
	#input-com1 {
	display: block;
	margin-top: 20px;
	padding: 10px;
	font-size: 18px;
	border-radius: 5px;
	border: 1px solid #ccc;
			
		}	
		
		
	#input-com2 {
	display: block;
	margin-top: 20px;
	padding: 10px;
	font-size: 18px;
	border-radius: 5px;
	border: 1px solid #ccc;
			
		}					
			
			
			
  </style>
    
   <script>
		function updateOverlay1(value) {
			document.getElementById("overlay-number").innerHTML = value;
		
		}
	</script>
	
	 <script>
		function updateOverlay2(value) {
			
			document.getElementById("overlay-nick").innerHTML = value;
		}
	</script>
	
	 <script>
		function updateOverlay3(value) {
			
			document.getElementById("overlay-com1").innerHTML = value;
		}
	</script>
	
	 <script>
		function updateOverlay4(value) {
			
			document.getElementById("overlay-com2").innerHTML = value;
		}
	</script>

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
    
        <div class="image-container" id="card-container">
            
           <div class="code-overlay" id="overlay-number"></div>
           <div class="nick-overlay" id="overlay-nick"></div>
           <div class="com1-overlay" id="overlay-com1"></div>
           <div class="com2-overlay" id="overlay-com2"></div>
            
            <img id="image1" src="https://via.placeholder.com/500x300" >
            <img id="image2" src="/static/image/B.png"  style= "display: none" >
            
            
             <input type="file" accept="image/*" onchange="previewImg(this);" >
                <img id="preview" width="150px" height="150px" class="image-container image-2">
         
        	 <img id="preview" name="cardSlot1" width="100px" height="60px" class="image-container slot-1">
             <img id="preview" name="cardSlot2" width="100px" height="60px" class="image-container slot-2">
             <img id="preview" name="cardSlot3" width="100px" height="60px" class="image-container slot-3">
             <img id="preview" name="cardSlot4" width="100px" height="60px" class="image-container slot-4">
             <img id="preview" name="cardSlot5" width="100px" height="60px" class="image-container slot-5">
             <img id="preview" name="cardSlot6" width="100px" height="60px" class="image-container slot-6">
         
      
         
         
         	 <div>    
                <label>트레이너 이름</label>
                <input type="text" name="cardNick" id="input-nick" autocomplete="off" 
                	class="form-input w-100"  oninput="updateOverlay2(this.value)">
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
                <input class="form-input w-100" placeholder="0000-0000-0000" type="tel" id="input-number" 
                	maxlength="14" oninput="updateOverlay1(this.value)" />
               
            </div>
            
            <div>
          
                <label>포켓몬을 선택해주세요(최대6마리)</label>
                <input type="number" name="cardNo" placeholder="포켓몬 이름">
  
                <button class="card111" type="submit">검색</button>
                
			</div>

			<div>
                <label>트레이너 한마디</label>
                <input type="text" name="card-firstLength" placeholder="첫번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off"  id="input-com1" oninput="updateOverlay3(this.value)"> 
                <input type="text" name="card-secondLength" placeholder="두번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off"  id="input-com2" oninput="updateOverlay4(this.value)">
            </div>
   
                
         
        </div>


           
	
    
    </div>
    
    	<div>
        <button type="submit" class="form-btn w-100">회원가입</button>
        </div>
    
    </div>
 
    
    
    
    </form>
   
    
        
    
         <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
           
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
