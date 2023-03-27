<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .sample-aside {
    font-size: 40px;
  }
  .sample-article {
    font-size: 100px;
  }
  .testClass {
    width: 5em;
    height: 5em;
    display: flex;
    align-items: center;
    /* justify-content: center; */
  }

  .pagination > a:hover {
    /* border-color: black; */
    color: red;
    font-weight: bold;
    box-shadow: 0 0 0 1px black;
  }
</style>

<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>

  <!-- article -->
  <article>
    <div class="sample-article">sample article</div>
    <div class="row">
      <div class="testClass">안녕</div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
