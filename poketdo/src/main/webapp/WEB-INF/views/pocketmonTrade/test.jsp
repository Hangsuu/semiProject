<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .sample-aside {
    font-size: 40px;
  }
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
    <div class="sample-article">sample article</div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
