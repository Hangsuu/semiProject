<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<!-- section -->
<section class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row">
        <h1>보낸 쪽지함</h1>
    </div>
    <div class="row">
      <div class="row flex-row-grow message-row">
        <span>받은사람</span>
        <span>제목</span>
        <span>날짜</span>
      </div>
      <c:forEach var="messageDto" items="${lists}">
        <hr class="mg-0"/>
        <div class="flex-row-grow message-row">
          <span>${messageDto.getMessageRecipient()}</span>
           <a href="/message/send/detail?messageNo=${messageDto.getMessageNo()}">${messageDto.getMessageTitle()}</a>
          <span><fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/></span>
        </div>
      </c:forEach>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>