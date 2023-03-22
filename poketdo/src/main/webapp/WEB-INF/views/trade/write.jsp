<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

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
  <article class="container-800">
    <form action="#" method="post" enctype="multipart/form-data">
      <input type="hidden" name="trade_writer" />
      <div class="row">
        <h1>교환글 글쓰기</h1>
      </div>
      <div class="row">
        <div></div>
      </div>
    </form>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
