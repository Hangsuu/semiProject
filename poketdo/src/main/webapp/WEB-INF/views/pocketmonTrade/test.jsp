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
    $(".select-btn").click(function(){
      const replyNo = $("input[name=selectReplyNo]").val();
      $.ajax({
        url: "/rest/message/test",
        method: "get",
        data: { replyNo: replyNo },
        success: function(response){
          console.log(response);
          const newReplyEle = $(
            $.parseHTML($("#pocketmonTrade-reply-template").html())
          );
          let replyBody = newReplyEle.eq(1).children();
          // 댓글 작성자
          replyBody.eq(0).children().eq(0).text(response.replyWriter);
          // 댓글 내용
          replyBody
            .eq(1)
            .append($("<div>" + response.replyContent + "</div>").html());
          // 시간
          replyBody.eq(2).children().eq(0).text(response.replyTime);

          let writerEle = replyBody.find(".writerTag");
          if (response.replyWriter == pocketmonTradeWriter) {
            writerEle.addClass("writer");
          } else {
            writerEle.remove();
          }
          // 댓글 작성자 본인이 아닐 경우 수정, 삭제 버튼 제거
          if (response.replyWriter != memberId) {
            replyBody.find(".pocketmonTrade-btn").remove();
          } else {
          }
          let replyNo = response.replyNo;

          // 수정 버튼 처리
          let replyConent = response.replyContent;
          replyBody
            .eq(0)
            .children()
            .eq(2)
            .click(function () {
              $("#pocketmonTrade-reply-write2");
              // const newEditEle = $.parseHTML(
              //   $("#pocketmonTrade-reply-write").html()
              // );
              // $(newEditEle).find("[name='replyContent']").val(replyConent);
              // newReplyEle.html(newEditEle);
              // newReplyEle.hide().after($("<div>").append($(newEditEle)).html());
            });
          // 삭제 버튼 처리
          replyBody
            .eq(0)
            .children()
            .eq(3)
            .click(function () {
              if (confirm("답글을 삭제하시겠습니까?")) {
                $.ajax({
                  url: "/rest/reply/" + replyNo,
                  method: "delete",
                  success: function () {
                    loadReply();
                  },
                  error: function () {
                    console.log("댓글 삭제 통신 오류!!!!");
                  },
                });
              }
            });
          replyContainer.append(newReplyEle);
        },
        error: function(){
          console.log("테스트 통신 에러");
        }
      })
    });
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
    <div class="row">
      <div class="row">
        <input type="text" name="selectReplyNo">
        <button class="select-btn">조회버튼</button>
      </div>
      <div class="row target">
      </div>
    </div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
