<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>
<script>
  $(function(){
    $(".message-delete-btn").click(function(e){
      if(!confirm("정말 삭제하시겠습니까?")){
        e.preventDefault();
        return;
      }
    })
  })
</script>
<!-- section -->
<section test class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row">
        <h1>쪽지 상세</h1>
    </div>
    <div class="row">
      <h1>${messageDto}</h1>
    </div>
    <div class="row flex-row">
        <a class="message-delete-btn" href="/message/receive/delete?messageNo=${messageDto.getMessageNo()}">삭제</a>
        <a href="/message/write">답장</a>
    </div>
    <div><b>보낸사람</b> ${messageDto.getMessageSender()} [<fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/>]</div>
    <div><b>받은사람</b> ${messageDto.getMessageRecipient()} [<fmt:formatDate value="${messageDto.getMessageReceiveTime()}" pattern="yyyy.MM.dd. H:m"/>]</div>
    <div><b>제목:</b> ${messageDto.getMessageTitle()}</div>
    <hr/>
    <div class="row">
        ${messageDto.getMessageContent()}
    </div>
    
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
