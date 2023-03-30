<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link
  href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
  $(function(){
    .
    $("[name=pocketmonTradeContent]").summernote({
      placeholder: "내용을 작성하세요",
      tabsize: 4,
      height: 400,
      toolbar: [
        ["style", ["style"]],
        ["font", ["bold", "underline", "clear"]],
        ["color", ["color"]],
        ["para", ["ul", "ol", "paragraph"]],
        ["table", ["table"]],
        ["insert", ["link", "picture", "video"]],
        ["view", ["fullscreen", "codeview", "help"]],
      ],
      callbacks: {
        onImageUpload: function (files) {
          if (files.length != 1) return;

          var fd = new FormData();
          fd.append("attach", files[0]);

          $.ajax({
            url: "/rest/attachment/upload",
            method: "post",
            data: fd,
            processData: false,
            contentType: false,
            success: function (response) {
              //서버로 전송할 이미지 번호 정보 생성
              var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "attachmentNo")
                .val(response.attachmentNo);
              $("form").prepend(input);

              //에디터에 추가할 이미지 생성
              var imgNode = $("<img>").attr(
                "src",
                "/rest/attachment/download/" + response.attachmentNo
              );
              $("[name=pocketmonTradeContent]").summernote(
                "insertNode",
                imgNode.get(0)
              );
            },
            error: function () {},
          });
        },
      },
    });
  })
</script>
<script type="text/template" id="pocketmonTrade-reply-template">
  <div class="row">
    <div class="bold flex">
      <div>댓글작성자</div>
      <div class="writerTag">작성자</div>
      <button class="pocketmonTrade-btn ml-auto" type="button">수정</button>
      <button class="pocketmonTrade-btn" type="button">삭제</button>
    </div>
    <div></div>
    <div style="color:#979797;" class="flex">
      <div>댓글시간</div>
      <div class="ms-10">답글쓰기</div>
    </div>
  </div>
  <hr/>
</script>
<script type="text/template" id="pocketmonTrade-reply-write">
  <div class=row>
    <form action="#" method="post" enctype="multipart/form-data">
      <input type="hidden" name="replyParent" value="0">
      <input type="hidden" name="replyOrigin" value="${pocketmonTradeDto.getAllboardNo()}">
      <input type="hidden" name="replyWriter" value="${sessionScope.memberId}">
      <textarea class="summernote" name="replyContent"></textarea>
      <div class="right">
        <button class="pocketmonTrade-btn" type="submit">취소</button>
        <button class="pocketmonTrade-btn" type="submit">등록</button>
      </div>
    </form>
  </div>
</script>
<style>

</style>

<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>

  <!-- article -->
  <article>
    <div class="target">
      <div class="row">
        <label
          >내용
          <textarea
            class="summernote"
            name="pocketmonTradeContent"
            placeholder="내용을 입력하세요"
            required
          ></textarea>
        </label>
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
