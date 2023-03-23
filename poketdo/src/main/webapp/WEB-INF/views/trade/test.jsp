<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- section -->
<section test>

  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <form action="test" method="post">
        <input name="time" type="datetime-local">
        <button>등록</button>
    </form>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
