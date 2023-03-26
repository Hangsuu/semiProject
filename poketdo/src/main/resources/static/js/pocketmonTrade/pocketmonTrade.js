$(function () {
  // 좋아요 누른 member는 채운 하트
  // loadReply();
  const newReplyEle = $.parseHTML($("#pocketmontTrade-reply-template").html());
  $("#pocketmonTrade-reply").prepend(newReplyEle);
  console.log(
    $("#pocketmonTrade-reply").prepend($("<div>").text("안녕하세요"))
  );
  console.log($("#pocketmonTrade-reply-template").html());
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

  // 댓글 목록 보이기
  function loadReply() {
    const replyEle = $("#pocketmonTrade-reply");
    $.ajax({
      url: "/rest/reply/",
      method: "get",
      data: { allboardNo: allboardNo },
      success: function (response) {},
      error: function () {
        console.log("댓글 load 통신오류!!!!");
      },
    });
  }

  // 좋아요 누르면 rest/like/ 호출, 좋아요 여부 반환
  $("#pocketmonTrade-like").click(function () {
    const heartEle = $(this).children().first();
    const likeCntEle = $(this).children().eq(1);
    // 좋아요일 때 하트 채우기, 아닐 때 비우기
    $.ajax({
      url: "/rest/like/",
      method: "post",
      data: likeTableDto,
      success: function (responseIsLike) {
        if (responseIsLike) {
          heartEle.addClass("fas");
        } else {
          heartEle.removeClass("fas");
        }
        // 좋아요 갯수 반영
        $.ajax({
          url: "/rest/like/count/",
          method: "get",
          data: { allboardNo: allboardNo },
          success: function (responseLikeCnt) {
            likeCntEle.text(responseLikeCnt);
          },
          error: function () {
            console.log("like 갯수 통신에러!!!!");
          },
        });
      },
      error: function () {
        console.log("하트 채우기 통신에러!!!!");
      },
    });
  });

  $("#pocketmonTrade-delete-btn").click(function (e) {
    if (!confirm("정말 삭제하시겠습니까?")) {
      e.preventDefault();
    }
  });

  // 포켓몬 교환 댓글 적기
  $("#pocketmonTrade-reply-btn").click(function (e) {
    e.preventDefault();
    const replyFormEle = $("#pocketmonTrade-reply").find("form");
    const data = replyFormEle.serialize();
    // 댓글 테이블에 데이터 생성
    $.ajax({
      url: "/rest/reply/",
      method: "post",
      data: data,
      success: function () {
        replyFormEle[0].reset();
        const newReplyEle = $.parseHTML(
          $("#pocketmontTrade-reply-template").html()
        );
      },
      error: function () {},
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
            var input = $("<input>")
              .attr("type", "hidden")
              .attr("name", "attachmentNo")
              .val(response.attachmentNo);
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
});
