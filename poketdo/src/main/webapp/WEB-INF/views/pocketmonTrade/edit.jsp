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
      <div class="row center">
        <h1>포켓몬교환 글쓰기</h1>
      </div>
      <br>
      <div class="row">
        <input class="form-input w-100" type="text" name="tradeTitle" placeholder="제목을 입력해 주세요">
        <input class="form-input w-100" type="text" name="tradeContent" placeholder="내용을 입력하세요">
        <button class="form-btn positive w-100">등록</button>
      </div>
        <a href="#">교환글 상세</a>
        <a href="/trade/write">교환글 글쓰기</a>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
