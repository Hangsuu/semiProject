<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<!-- section -->
<section test>

  <!-- aside -->
  <aside>
    <div class="sample-aside">sample aside</div>
  </aside>
  
  <!-- article -->
  <article class="container-800">
    <div class="row">
        <h1>받은 쪽지함</h1>
    </div>
    <div class="row">
      <a href="/message/write">쪽지쓰기</a>
    </div>
    <div class="row">
      <a href="/message/sendStore">보낸 편지함</a>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
