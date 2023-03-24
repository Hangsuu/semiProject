$(function () {
  $.ajax({
    url: "/rest/like/check",
    method: "post",
    data: likeTableDto,
    success: function (response) {
      if (response) {
        $("#pocketmonTrade-like > *:first-child").addClass("fas");
      }
    },
    error: function () {
      console.log("통신 실패");
    },
  });

  $("#pocketmonTrade-delete-btn").click(function (e) {
    if (!confirm("정말 삭제하시겠습니까?")) {
      e.preventDefault();
    }
  });

  $("#pocketmonTrade-like").click(function () {
    $.ajax({
      url: "/rest/like/count",
      method: "post",
      data: likeTableDto,
      success: function (response) {
        if (response.isLike) {
          $("#pocketmonTrade-like > *:first-child").addClass("fas");
        } else {
          $("#pocketmonTrade-like > *:first-child").removeClass("fas");
        }
        $("#pocketmonTrade-like-Cnt").text(response.likeCnt);
      },
      error: function () {
        console.log("통신 실패!!!!!!!!!!!!!!!!");
      },
    });
  });

  // summernote 세팅
  $("textarea[name=replyContent]").summernote({
    placeholder: "내용을 작성하세요",
    tabsize: 4,
    height: 200,
    toolbar: [
      ["table", ["table"]],
      ["insert", ["link", "picture"]],
      ["view", ["fullscreen", "help"]],
    ],
    disableResizeEditor: true,
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
            var imgNode = $("<img>")
              .attr("src", "/rest/attachment/download/" + response.attachmentNo)
              .width("25%");
            $("[name=replyContent]").summernote("insertNode", imgNode.get(0));
          },
          error: function () {},
        });
      },
    },
  });

  // pocketmonTrade-reply setting
  $("#pocketmonTrade-reply-btn").click(function(e){
    const data = $("form").serialize();
    e.preventDefault();
    $.ajax({
      url: "/rest/reply/test",
      method: "post",
      data: data,
      success: function(){
        // console.log(response);
      },
      error: function(){

      }

    })
    // console.log($("form").serialize());
  })
});
