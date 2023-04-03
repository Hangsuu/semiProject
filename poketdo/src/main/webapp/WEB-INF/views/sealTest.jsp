<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>
<script>
  $(function(){
    $(".button1").click(function(){
      $.ajax({
        url: "/rest/member/attachmentNo/memberId/" + $(".input1").val(),
        method: "get",
        success: function(response){
          $(".attachmentNo1").text(response);
        },
        error: function(){
          console.log("get attachmentNo by memberId error!");
        }
      })
    })

    $(".button2").click(function(){
      $.ajax({
        url: "/rest/member/attachmentNo/memberNick/" + $(".input2").val(),
        method: "get",
        success: function(response){
          $(".attachmentNo2").text(response);
        },
        error: function(){
          console.log("get attachmentNo by memberNick error!");
        }
      })
    })

    $(".button3").click(function(){
      $.ajax({
        url: "/rest/member/sealUrl/memberId/" + $(".input3").val(),
        method: "get",
        success: function(response){
          $(".target").append($("<img>").attr("src", response).css("width", "200px"));
          $(".attachmentNo3").text(response);
        },
        error: function(){
          console.log("get attachmentNo by memberId error!");
        }
      })
    })

    $(".button4").click(function(){
      $.ajax({
        url: "/rest/member/sealUrl/memberNick/" + $(".input4").val(),
        method: "get",
        success: function(response){
          $(".attachmentNo4").text(response);
        },
        error: function(){
          console.log("get attachmentNo by memberNick error!");
        }
      })
    })
  })
  </script>
<!-- section -->
<section test>

  <!-- aside -->
  <aside>
  </aside>
  
  <!-- article -->
  <article class="container-600">
    <div class="row target1">
      <h1>멤버아이디로 멤버 어태치 넘 찾기</h1>
      <input type="text" class="input1">
      <button class="button1">button1</button>
      <h1 class="attachmentNo1"></h1>
    </div>
    <div class="row">
      <h1>멤버닉네임로 멤버 어태치 넘 찾기</h1>
      <input type="text" class="input2">
      <button class="button2">button1</button>
      <h1 class="attachmentNo2"></h1>
    </div>
    <div class="row target">
      <h1>멤버아이디로 인장 유알엘 구하기</h1>
      <input type="text" class="input3">
      <button class="button3">button1</button>
      <h1 class="attachmentNo3"></h1>
    </div>
    <div class="row">
      <h1>멤버닉네임으로 인장 유알엘 구하기</h1>
      <input type="text" class="input4">
      <button class="button4">button1</button>
      <h1 class="attachmentNo4"></h1>
    </div>
    <div class="row">
      <h1>멤버아이디로 멤버 어태치 넘 찾기</h1>
      <input type="text" class="input1">
      <button class="button1">button1</button>
    </div>
    <div class="row">
      <h1>멤버아이디로 멤버 어태치 넘 찾기</h1>
      <input type="text" class="input1">
      <button class="button1">button1</button>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
