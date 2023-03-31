<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- font-awesome CDN -->
<link
rel="stylesheet"
type="text/css"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
/>

<script>
    $(function(){
        var href = window.location.href;
        if(window.location.href.endsWith("/message/receive")){
            $(".receive-store").addClass("back-dark-gray"); 
        } else if(window.location.href.endsWith("/message/send")){
            $(".send-store").addClass("back-dark-gray"); 
        }
    })
</script>
<style>
    .message-send-btn {
        text-align: center;
        text-decoration: none;
        box-shadow: 0 0 0 1px #5E78D3;
    }
    .reply-aside:hover {
        background-color: #E5E5E5;
    }
    .message-nav {
    }
</style>
<!-- section -->
<section class="container-1200 mt-50 mb-50">

<aside class="message-nav">
    <div class="row flex-row-grow">
        <a class="back-sc white-bold message-send-btn" href="/message/write">쪽지쓰기</a>
        <a class="back-sc white-bold message-send-btn" href="/message/write?recipient=${sessionScope.memberId}">내게쓰기</a>
    </div>
    <div class="row reply-aside receive-store">
      <a href="/message/receive" class="link"><i class="fa-solid fa-message" style="color: #9DACE4;"></i> 받은쪽지함</a>
    </div>
    <div class="row reply-aside send-store">
      <a href="/message/send" class="link"><i class="fa-regular fa-message" style="color: #9DACE4;"></i> 보낸쪽지함</a>
    </div>
</aside>

  <!-- article -->
  <article class="container-1000 ps-30">