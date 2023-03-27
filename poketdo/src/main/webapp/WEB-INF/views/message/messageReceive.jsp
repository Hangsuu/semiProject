<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<!-- section -->
<section test class="flex-row-justify-center">

  <!-- aside -->
  <aside class="message-nav">
    <div class="row flex-row-grow">
        <a href="/message/write">쪽지쓰기</a>
        <a href="/message/write">내게쓰기</a>
    </div>
    <div>
      <a href="/message/receive" class="row">받은쪽지함</a>
    </div>
    <div>
      <a href="/message/send" class="row">보낸쪽지함</a>
    </div>
  </aside>
  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row">
        <h1>받은 쪽지함</h1>
    </div>
    <div class="row">
      <div class="row flex-row-grow message-row">
        <span>보낸사람</span>
        <span>제목</span>
        <span>날짜</span>
      </div>
      <c:forEach var="messageDto" items="${lists}">
        <hr class="mg-0"/>
        <div class="flex-row-grow message-row">
          <span>${messageDto.getMessageSender()}</span>
           <a href="/message/receive/detail?messageNo=${messageDto.getMessageNo()}">${messageDto.getMessageTitle()}</a>
          <span><fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/></span>
        </div>
      </c:forEach>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
