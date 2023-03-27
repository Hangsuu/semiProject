$(function () {
  // summernote 세팅
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

  // 등록제한
  $("#pocketmonTrade-insert-btn").click(function (e) {
    const isPromiseNull = $("input[name=promise]").val() == "";
    // 거래 시간 등록해야만 작성 가능
    if (isPromiseNull) {
      e.preventDefault();
      alert("거래일을 입력해주세요");
      return;
    }
    // 로그인 해야만 작성가능
    if (memberId == "") {
      e.preventDefault();
      alert("로그인 해야만 글 작성 가능합니다");
      return;
    }
  });
});
