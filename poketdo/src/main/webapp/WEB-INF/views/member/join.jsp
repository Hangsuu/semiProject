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
      <div class= "container-500 center">
    	<form action="join" method="post">
        
            <div class="row center">
            <h2>회원가입</h2>
            </div>
            
        <div>
        	<input type="text" name="memberId" placeholder="아이디" 
        		class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        	<input type="password" name="memberPw" placeholder="비밀번호" 
        	class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        	<input type="password" name="memberPwRe" placeholder="비밀번호확인" 
        		class="form-input w-100" autocomplete="off" required>
        </div>
        <div>
        	<input type="text" name="memberNick" placeholder="닉네임" 
        	class="form-input w-100" autocomplete="off" required></div>
        <div>
        	<input type="date" name="memberBirth" placeholder="생년월일" 
        	class="form-input w-100" autocomplete="off" required></div>
        
   
    <div class="left">
    <input type="checkbox" id="checkcheck" onclick="myFunction()">트레이너 카드 생성(선택)
	</div>

    <div id = "target" style= "display:none" class="row left">
        <h2>트레이너 카드 미리보기</h2>
    
        <div>
            <img id="image1" src="/semi/image/A.png" class="image-container image-1">
            <img id="image2" src="/semi/image/B.png" class="image-container image-1" style= "display: none;" >
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
                <label class>게임월드 선택</label>
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
                <button>검색</button>

                <img id="preview" width="100px" height="60px" class="image-container slot-1">
                <img id="preview" width="100px" height="60px" class="image-container slot-2">
                <img id="preview" width="100px" height="60px" class="image-container slot-3">
                <img id="preview" width="100px" height="60px" class="image-container slot-4">
                <img id="preview" width="100px" height="60px" class="image-container slot-5">
                <img id="preview" width="100px" height="60px" class="image-container slot-6">
                
            <div>
                <label>트레이너 한마디</label>
                <input type="text" name="card-firstLength" placeholder="첫번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off" >
                <input type="text" name="card-secondLength" placeholder="두번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off" >
            </div>
       
        
        
        

         <div>
        <button>회원가입</button>
        </div>

    </div>
    
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
    </form>
    </div>
   
           
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
