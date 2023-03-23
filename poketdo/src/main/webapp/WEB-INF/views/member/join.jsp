<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/memberLogin.js"></script>

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

  <!-- aside -->
  <aside></aside>
  
  <!-- article -->
  <article>
    <form action="join" method="post">
        
            <div>회원가입</div>
            
            
        <div><input type="text" name="memberId" placeholder="아이디" value="${memberId}" autocomplete="off" required></div>
        <div><input type="password" name="memberPw" placeholder="비밀번호" autocomplete="off" required></div>
        <div><input type="password" name="memberPwRe" placeholder="비밀번호확인" autocomplete="off" required></div>
        <div><input type="password" name="memberNick" placeholder="닉네임" autocomplete="off" required></div>
        <div><input type="date" name="memberBirth" placeholder="생년월일" autocomplete="off" required></div>
        
       
       
       
            
    
    <input type="checkbox" id="checkcheck" onclick="myFunction()">

    <div id = "target" style= "display:none">
        <h2>트레이너 카드 생성</h2>
    
            <div>
                <label>트레이너 카드 미리보기</label>



            </div>

            <div>
                <button>사진 업로드</button>
                <input type="file" accept="image/*" onchange="previewImage(event)">
            </div>


            <div>
                
                <label>트레이너 이름</label>
                <input type="text" name="cardNick"  value="${memberId}" autocomplete="off" required></div>
                
            <div>
                <label>국가</label> 
                <input type="text" name="memberPw" autocomplete="off" required></div>
            <div>
                <label>게임월드 선택</label>
                <input type="radio" id="scarlet" value="scarlet">스칼렛
                <input type="radio" id="violet" value="violet">바이올렛
            </div>
            <div>
                <label>친구코드</label>
                <input class="form-control" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
                    <span>
                    <span>-</span>
                    </span>
                <input class="form-control" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
                    <span>
                    <span>-</span>
                    </span>
                <input class="form-control" placeholder="0000" type="tel" name="Fcode" maxlength="4" />
            </div>
            <div>
                <label>포켓몬을 선택해주세요(최대6마리)</label>
                <button>검색</button>
                <input type="text" name="memberBirth"  autocomplete="off" required></div>
                
            <div>
                <label>트레이너 한마디</label>
                <input type="text" name="card-firstLength" placeholder="첫번째줄" maxlength="30">
                <input type="text" name="card-secondLength" placeholder="두번째줄" maxlength="30">
            </div>
       
        
        
        

         <div>
        <button>회원가입</button>
        </div>

    </div>
    
      <input style="display: none;" name="prevPage" value="${param.prevPage != null ? param.prevPage : header.referer}">
    </form>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
