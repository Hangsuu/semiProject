<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .sample-article {
    font-size: 100px;
  }
</style>

<!-- section -->
<section test>

  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article>
    <div class="container-800">
        <h1>교환글 리스트</h1>
        <a href="#">교환글 상세</a>
        <a href="/trade/write">교환글 글쓰기</a>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
