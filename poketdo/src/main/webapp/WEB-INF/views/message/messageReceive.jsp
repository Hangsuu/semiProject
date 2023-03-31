<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
  var memberId = "${sessionScope.memberId}";
</script>
<script src="/static/js/message/messageReceive.js"></script>
<script type="text/template" id="receive-message-row">
  <hr class="mg-0"/>
  <div class="flex-row-grow message-row">
    <div class="flex-all-center message-check-column">
      <input class="message-check-one" type="checkbox"/>
    </div>
    <div>
      <a class="link message-sender-col">메세지 보낸 사람</a>
    </div>
    <a class="link message-title-col">메세지 제목</a>
    <a class="link message-send-time-col">메세지 보낸 시간</a>
  </div>
</script>
<!-- section -->
<section class="container-1200">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  
  <!-- article -->
  <article class="container-1000 mg-0">
    <div class="mb-30">
        <h1>받은 쪽지함 <a class="deco-none message-not-read-cnt" href="/message/receive?mode=new" style="color:#5E78D3">${notReadCnt}</a>/<a class="deco-none message-receive-cnt" style="color:black" href="/message/receive"></a></h1>
    </div>
    <div class="row flex">
      <div class="pocketmonTrade-btn message-delete-btn"><i class="fa-solid fa-xmark" style="color:red;"></i> 삭제</div><div class="pocketmonTrade-btn ml-auto message-refresh-btn"><i class="fa-solid fa-rotate-right" style="color: gray;"></i> 새로고침</div>
    </div>
    <div class="row">
      <div class="flex-row-grow message-row message-head">
        <div class="flex-all-center message-check-column"><input class="message-check-all" type="checkbox"></div>
        <div class="flex-align-center">보낸사람</div>
        <div class="flex-align-center">제목</div>
        <div class="flex-align-center">날짜</div>
      </div>
      <div class="target">
      </div>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
