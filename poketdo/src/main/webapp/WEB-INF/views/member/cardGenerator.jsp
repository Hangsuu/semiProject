<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>

    
    
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
		
		
		
		 <script>
		  function updatePreview() {
		    var inputText = document.getElementById("input-code").value;
		    var preview = document.getElementById("input-preview");
		    preview.innerText = inputText;
		  }
		</script>
	
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
		function saveImage() {
		  // 저장하려는 div의 id 가져오기
		  const divId = "myDiv";
		
		  // 저장할 이미지 파일 이름
		  const fileName = "myImage.png";
		
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
		top: 37px;
		left: 277px;
		font-size: 25px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.nick-overlay {
		position: absolute;
		top: 38px;
		left: 33px;
		font-size: 22px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.com1-overlay {
		position: absolute;
		top: 240px;
		left: 33px;
		font-size: 20px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	.com2-overlay {
		position: absolute;
		top: 265px;
		left: 33px;
		font-size: 20px;
		color: white;
		text-shadow: 2px 2px #000000;
		pointer-events: none;
		
	}
	
	
	#input-number {
		display: block;
	
		padding: 10px;
		font-size: 15px;
		border-radius: 5px;
		border: 1px solid #ccc;
				
			}
			
			
	#input-nick {
		display: block;
		
		padding: 10px;
		font-size: 15px;
		border-radius: 5px;
		border: 1px solid #ccc;
				
			}		
			
	#input-com1 {
	display: block;
	
	padding: 10px;
	font-size: 15px;
	border-radius: 5px;
	border: 1px solid #ccc;
			
		}	
		
		
	#input-com2 {
	display: block;
	
	padding: 10px;
	font-size: 15px;
	border-radius: 5px;
	border: 1px solid #ccc;
			
		}					
			
			
			
  </style>
    
  

  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>
<!--     <form method="post" enctype="multipart/form-data" autocomplete="off"> -->
        
      <div class= "container-500 center">
      
    
	        <h2 class="row center mt-10 mb-10">트레이너 카드 생성기</h2>
	    
	        <div class="image-container row left" id="card-container">
	             <div id="myDiv">
		           <div class="code-overlay" id="overlay-number"></div>
		           <div class="nick-overlay" id="overlay-nick"></div>
		           <div class="com1-overlay" id="overlay-com1"></div>
		           <div class="com2-overlay" id="overlay-com2"></div>
		            
		           
		            <img id="image1" src="/static/image/A.png" >
		            <img id="image2" src="/static/image/B.png" style= "display: none">
		            
		    	</div>  
		                <img id="preview" width="150px" height="150px" class="image-container image-2">
		       
		        	 <img id="preview" name="cardSlot1" width="100px" height="60px" class="image-container slot-1">
		             <img id="preview" name="cardSlot2" width="100px" height="60px" class="image-container slot-2">
		             <img id="preview" name="cardSlot3" width="100px" height="60px" class="image-container slot-3">
		             <img id="preview" name="cardSlot4" width="100px" height="60px" class="image-container slot-4">
		             <img id="preview" name="cardSlot5" width="100px" height="60px" class="image-container slot-5">
		             <img id="preview" name="cardSlot6" width="100px" height="60px" class="image-container slot-6">
	         
     		
     		
     			프로필 사진 업로드<input type="file" accept="image/*" onchange="previewImg(this);" >
     			
     		 <div class="row">
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
         
         
         	 <div class="row">    
                <label>트레이너 이름</label>
                <input type="text" name="cardNick" id="input-nick" autocomplete="off" 
                	class="form-input w-100"  oninput="updateOverlay2(this.value)">
            </div>
                
        
            
            <div class="row">
                <label>친구코드</label>
                <br>
                <input class="form-input w-100" placeholder="0000-0000-0000" type="tel" id="input-number" 
                	maxlength="14" oninput="updateOverlay1(this.value)" />
               
            </div>
            
            <div class="row">
          
                <label>포켓몬을 선택해주세요(최대6마리)</label>
                <br>
                <input type="number" name="cardNo" placeholder="포켓몬 번호">
  
                <button class="card111" type="submit">검색</button>
                
			</div>

			<div class="row">
                <label>트레이너 한마디</label>
                <input type="text" name="card-firstLength" placeholder="첫번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off"  id="input-com1" oninput="updateOverlay3(this.value)"> 
                <input type="text" name="card-secondLength" placeholder="두번째줄" maxlength="30"
                	class="form-input w-100" autocomplete="off"  id="input-com2" oninput="updateOverlay4(this.value)">
            </div>
   
                
         
        </div>
	
		
		<div class="row center">
			<button type="button" onclick="saveImage()">트레이너 카드 저장</button>
		
	
	    </div>	       
		
	    
	    </div>
	    
	   
    
    
<!--     </form> -->
   
        
    
         <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
           
  </article>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
