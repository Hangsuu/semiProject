<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
  var messageNo = parseInt("${messageDto.getMessageNo()}");
  var messageSender = "${messageDto.getMessageSender()}";
</script>
<script src="/static/js/message/messageSendDetail.js"></script>
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  
    <div class="row">
      <h1>${messageDto.getMessageTitle()}</h1>
    </div>
    <hr/>
    <div class="row flex">
      <div class="pocketmonTrade-btn message-delete-btn">
        <i class="fa-solid fa-xmark" style="color:red;"></i> 삭제
      </div>
      <a href="/message/send" class="pocketmonTrade-btn message-list-btn ml-auto">
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
      ${messageDto.getMessageRecipient()} <c:if test="${messageDto.getMessageReadTime()!=null}">[<fmt:formatDate value="${messageDto.getMessageReadTime()}" pattern="yyyy.MM.dd. H:m"/>]</c:if>
    </div>
    <hr/>
    <div class="row message-content">
      ${messageDto.getMessageContent()}
    </div>
    <hr/>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
