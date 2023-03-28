<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .flex {
    display: flex;
  }
  .picOne {
    width: 33.33%;
  }
  .picCon {
    height: 300px;
  }
</style>

<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>

  <!-- article -->
  <article class="container-600">
    <div class="row flex picCon">
      <div class="w-60 flex-column-grow">
        <div class="flex-row-grow">
          <div class="picOne">첫번째사진</div>
          <div class="picOne">두번째사진</div>
          <div class="picOne">세번째사진</div>
        </div>
        <div class="flex-row-grow">
          <div class="picOne">네번째사진</div>
          <div class="picOne">다섯번째사진</div>
          <div class="picOne">여섯번째사진</div>
        </div>
      </div>
      <div class="w-40">대문사진</div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
