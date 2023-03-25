<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
  textarea[name="pocketmonTradeContent"] {
    min-height: 500px;
  }
</style>

<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <form action="#" method="post" enctype="multipart/form-data" class="w-100">
      <input type="hidden" name="pocketmonTradeNo" value="${pocketmonTradeDto.getPocketmonTradeNo()}" />
      <div class="row center">
        <h1>포켓몬 교환</h1>
      </div>
      <div class="row">
        <label
          >제목
          <input
            class="form-input w-100"
            name="pocketmonTradeTitle"
            value="${pocketmonTradeDto.getPocketmonTradeTitle()}"
            type="text"
            placeholder="제목을 입력하세요"
          />
        </label>
      </div>
      <div class="row">
        <label
          >내용
          <textarea class="summernote" name="pocketmonTradeContent" placeholder="내용을 입력하세요">${pocketmonTradeDto.getPocketmonTradeContent()}</textarea>
        </label>
      </div>
      <div class="row">
        <label
          >거래일
          <input type="datetime-local" value="${formattedDate}" class="form-input w-100" name="promise" />
        </label>
      </div>
      <button type="submit" class="form-btn w-100 positive">등록</button>
    </form>
  </article>
  <script>
    $(function () {
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
                var input = $("<input>").attr("type", "hidden").attr("name", "attachmentNo").val(response.attachmentNo);
                $("form").prepend(input);

                //에디터에 추가할 이미지 생성
                var imgNode = $("<img>").attr("src", "/rest/attachment/download/" + response.attachmentNo);
                $("[name=pocketmonTradeContent]").summernote("insertNode", imgNode.get(0));
              },
              error: function () {},
            });
          },
        },
      });
    });
  </script>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
