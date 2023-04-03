$(function () {
  // 좋아요 누른 member는 채운 하트

  console.log($("<div>").html("<hr/>"));
  loadReply();
  summernote();
  $.ajax({
    url: "/rest/like/check",
    method: "post",
    data: likeTableDto,
    success: function (response) {
      if (response) {
        $("#board-like > *:first-child").addClass("fas");
      }
    },
    error: function () {
      console.log("통신 실패");
    },
  });

  // 댓글 목록 보이기
  function loadReply() {
    $.ajax({
      url: "/rest/reply/" + String(allboardNo),
      method: "get",
      data: { allboardNo: allboardNo },
      success: function (response) {
        let replyContainer = $("#board-replys");
        replyContainer.empty();
        for (let i = 0; i < response.length; i++) {
          const replyDto = response[i];

          const newReplyEle = $(
            $.parseHTML($("#board-reply-template").html())
          );

          // 댓글 작성자
          newReplyEle.find(".board-reply-writer").text(replyDto.replyWriter);

          // 댓글 내용
          newReplyEle.find(".board-reply-content").append($("<div>" + replyDto.replyContent + "</div>").html());
          // 시간
          newReplyEle.find(".board-reply-time").text(replyDto.replyTime);

          // 글쓴이 표기
          let writerEle = newReplyEle.find(".writerTag");
          const replyWriter = newReplyEle.find(".board-reply-writer").text();
          if (replyWriter == boardWriter) {
            writerEle.addClass("writer");
          } else {
            writerEle.remove();
          }

          // 댓글 작성자 본인이 아닐 경우 수정, 삭제 버튼 제거
          if (replyWriter != memberId) {
            newReplyEle.find(".board-reply-edit-btn").remove();
            newReplyEle.find(".board-reply-delete-btn").remove();
          } 

          // 답글쓰기 처리
          newReplyEle.find(".board-reply-re").click(function(){
            if(!removeNewReply()) return;
            const newReReplyEle = $.parseHTML($("#board-reply-write").html());
            $(this).parent().parent().after(newReReplyEle);
            summernote();
          })

          // 수정 버튼 처리
          newReplyEle.find(".board-reply-edit-btn").click(function () {
            if(!removeNewReply()) return;

            const newReReplyEle = $.parseHTML($("#board-reply-write").html());

            // reply content 옮기기
            const replyEle = $(this).parent().parent();
            const writtenContent = replyEle.find(".board-reply-content").html();
            $(newReReplyEle).find("textarea[name=replyContent]").val($("<div>"+(writtenContent)+"</div>").html());
            
            // 취소 버튼 처리
            $(newReReplyEle).find(".board-reply-cancle-btn").click(function () {
                if (confirm("댓글 수정을 취소하시겠습니까?")) {
                  replyEle.show().next().remove();
                }
            });

            // 수정 버튼 처리
            $(newReReplyEle).find(".board-reply-update-btn").click(function () {
              const newReplyContent = $(newReReplyEle).find("textarea[name=replyContent]").val();
              $.ajax({
                url: "/rest/reply/",
                method: "put",
                data: { replyNo: replyDto.replyNo, replyContent: newReplyContent },
                success: function(){
                  loadReply();
                },
                error: function(){
                  console.log("댓글 수정 통신 에러!!!!")
                }
              })
            });
            replyEle.hide().after(newReReplyEle);
            summernote();
          });
          // 삭제 버튼 처리
          newReplyEle.find(".board-reply-delete-btn").click(function () {
            if (confirm("댓글을 삭제하시겠습니까?\n(댓글을 삭제하면, 완료하지 않은 대댓글, 수정한 내용이 사라집니다)")) {
              $.ajax({
                url: "/rest/reply/" + replyDto.replyNo,
                method: "delete",
                success: function(){
                  loadReply();
                },
                error: function(){
                  console.log("댓글 삭제 통신오류!!!!");
                }
              })
            }
          });
          replyContainer.append(newReplyEle);
        }
        // 댓글 갯수 반영
        $(".board-replyCnt").text(response.length);
      },
      error: function () {
        console.log("댓글 load 통신오류!!!!");
      },
    });
  }

  // 대댓글 & 댓글 수정이 존재 할 시 제거
  function removeNewReply(){
    const isReplyEle = $(".board-reply-reply");
    if(isReplyEle.length >= 1){
      if(confirm("완료하지 않은 대댓글, 수정한 내용이 사라집니다. \n계속 하시겠습니까?")){
        isReplyEle.prev().show().next().remove();
        return true;
      } else {
        return false;
      }
    }
    isReplyEle.prev().show().next().remove();
    return true;
  }
  
  // 좋아요 누르면 rest/like/ 호출, 좋아요 여부 반환
  $("#board-like").click(function (e) {
    if (memberId == "") {
      e.preventDefault();
      if (
        confirm(
          "로그인을 한 회원만 사용할 수 있는 기능입니다. 로그인하시겠습니까?"
        )
      ) {
        location.href = "/member/login";
      }
    }
    let heartEle = $(this).children().first();
    let likeCntEle = $(this).children().eq(1);
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
          url: "/rest/like/count",
          method: "get",
          data: { allboardNo : allboardNo},
          success: function (responseLikeCnt) {
            likeCntEle.text(responseLikeCnt);
          },
          error: function () {
            console.log("like 갯수 통신에러!!!!");
          },
        });
      },
    });
  });

  $("#board-delete-btn").click(function (e) {
    if (!confirm("정말 삭제하시겠습니까?")) {
      e.preventDefault();
    }
  });

  // 자유게시판, 인기게시판 댓글 적기
  $("#board-reply-btn").click(function (e) {
    e.preventDefault();
    if(!removeNewReply()) return;

    if (memberId == "") {
      alert("로그인을 해야만 댓글을 작성할 수 있습니다.");
      return;
    }
    let replyFormEle = document.querySelector(".board-reply-form");
    let summernoteEle = $(replyFormEle).find(".summernote");
    let data = $(replyFormEle).serialize();
    if(summernoteEle.summernote("isEmpty")){
      alert("댓글 내용을 작성해주세요");
      return;
    }
    // 댓글 테이블에 데이터 생성
    $.ajax({
      url: "/rest/reply/",
      method: "post",
      data: data,
      success: function () {
        // 폼 초기화
        replyFormEle.reset();
        summernoteEle.summernote("code","");
        loadReply();
      },
      error: function () {},
    });
  });

  //

  // summernote 세팅
  function summernote() {
    $("textarea[name=replyContent]").summernote({
      placeholder: "내용을 작성하세요",
      tabsize: 4,
      height: 200,
      toolbar: [
        ["table", ["table"]],
        ["insert", ["picture"]],
      ],
      disableResizeEditor: true,
      callbacks: {
        onImageUpload: function (files) {
          if (files.length != 1) return;

          let fd = new FormData();
          fd.append("attach", files[0]);
          $.ajax({
            url: "/rest/attachment/upload",
            method: "post",
            data: fd,
            processData: false,
            contentType: false,
            success: function (response) {
              //서버로 전송할 이미지 번호 정보 생성
              let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "attachmentNo")
                .val(response.attachmentNo);
              $("form").prepend(input);

              //에디터에 추가할 이미지 생성
              let imgNode = $("<img>")
                .attr(
                  "src",
                  "/rest/attachment/download/" + response.attachmentNo
                )
                .width("25%");
              $("[name=replyContent]").summernote("insertNode", imgNode.get(0));
            },
            error: function () {},
          });
        },
      },
    });
  }
});