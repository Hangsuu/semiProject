<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
  $(function () {
    $(".image-btn").click(function () {
      const targetEle = $(".target");
      targetEle.empty();
      const imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" +
        $(".input-no").val() +
        ".png";
      console.log(imageUrl);
      const imageEle = $("<img>").attr("src", imageUrl).css("width", "200px");
      console.log(imageEle);
      targetEle.append(imageEle);
    });
  });
</script>
<!-- section -->
<section>
  <!-- aside -->
  <aside></aside>

  <!-- article -->
  <article>
    <div class="container-600">
      <div class="row center">
        <h1>이미지</h1>
      </div>
      <div class="row">
        <label>
          번호
          <input class="input-no" type="text" placeholder="" />
          <button class="image-btn">사진</button>
        </label>
      </div>
      <div class="row target"></div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
