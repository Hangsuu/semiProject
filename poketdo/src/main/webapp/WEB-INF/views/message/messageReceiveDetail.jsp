<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .message-content {
    min-height: 200px;
  }
</style>
<script>
  var messageNo = parseInt("${messageDto.getMessageNo()}");
  var messageSender = "${messageDto.getMessageSender()}";
</script>
<script>
  $(function(){
    $(".message-delete-btn").click(function(e){
      if(!confirm("정말 삭제하시겠습니까?")){
        e.preventDefault();
        return;
      }
      $.ajax({
        url: "/rest/message/receive",
        method: "put",
        data: { messageNo: messageNo },
        success: function(){
          window.location.href="/message/receive";
        },
        error: function(){
          console.log("받은 메세지 삭제 통신 에러!!!!");
        },
      })
    })
  })
</script>
<!-- section -->
<section class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row">
      <h1>${messageDto.getMessageTitle()}</h1>
    </div>
    <hr/>
    <div class="row flex">
      <div class="pocketmonTrade-btn message-delete-btn">
        <i class="fa-solid fa-xmark" style="color:red;"></i> 삭제
      </div>
      <div class="pocketmonTrade-btn message-reply-btn">
        <i class="fa-solid fa-reply" style="color: #9DACE4;"></i> 답장
      </div>
      <a href="/message/receive" class="pocketmonTrade-btn message-list-btn ml-auto">
        <i class="fa-solid fa-list" style="color: #9DACE4;"></i> 목록
      </a>
    </div>
    <hr/>
    <div class="row">
      <b>보낸사람</b> 
      ${messageDto.getMessageSender()} [<fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </div>
    <div class="row">
      <b>받은사람</b> 
      ${messageDto.getMessageRecipient()} [<fmt:formatDate value="${messageDto.getMessageReadTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </div>
    <hr/>
    <div class="row message-content">
      ${messageDto.getMessageContent()}
    </div>
    <hr/>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
