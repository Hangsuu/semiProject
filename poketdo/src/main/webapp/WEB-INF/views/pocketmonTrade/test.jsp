<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
  $.ajax({
    url: "/rest/reply/test",
    method: "get",
    success: function (response) {
      console.log(new Date(response));
      $(".testClass").append(
        $("<div>" + "<span>test</span>" + "</div>").html()
      );
    },
  });
  $(function () {
    const newEle = $($.parseHTML($("#template").html()));
    $(newEle).children().eq(1).click();
    $(".target").append(newEle);
  });
</script>
<script type="text/template" id="template">
  <div>
    <div class="first">첫째줄</div>
    <div class="second">둘째줄</div>
  </div>
</script>
<script type="text/template" id="template2">
  <div>
    <div class="first">첫째줄</div>
    <div class="second">둘째줄</div>
  </div>
</script>
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
    <div class="target"></div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
