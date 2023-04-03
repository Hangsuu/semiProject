$(function () {
  // 좋아요 누른 member는 채운 하트

  // console.log($("<div>").html("<hr/>"));
  loadReply();
  summernote();
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
    $.ajax({
      url: "/rest/reply/" + String(allboardNo),
      method: "get",
      // data: { allboardNo: allboardNo },
      success: function (response) {
        console.log(response);
        let replyContainer = $("#pocketmonTrade-replys");
        replyContainer.empty();
        for (let i = 0; i < response.replyDto.length; i++) {
          const replyDto = response.replyDto[i];
          console.log(replyDto)
          const newReplyEle = $(
            $.parseHTML($("#pocketmonTrade-reply-template").html())
          );
          // 댓글 전체에 replyOrigin data attr 추가
          newReplyEle.attr("data-replygroup", replyDto.replyNo)
          // 댓글 작성자
          newReplyEle.find(".pocketmonTrade-reply-writer").text(replyDto.replyWriter);

          // 댓글 내용
          newReplyEle.find(".pocketmonTrade-reply-content").append($("<div>" + replyDto.replyContent + "</div>").html());
          // 시간
          newReplyEle.find(".pocketmonTrade-reply-time").text(replyDto.replyTime);

          // 글쓴이 표기
          let writerEle = newReplyEle.find(".writerTag");
          const replyWriter = newReplyEle.find(".pocketmonTrade-reply-writer").text();
          if (replyWriter == pocketmonTradeWriter) {
            writerEle.addClass("writer");
          } else {
            writerEle.remove();
          }

          // 댓글 작성자 본인이 아닐 경우 수정, 삭제 버튼 제거
          if (replyWriter != memberId) {
            newReplyEle.find(".pocketmonTrade-reply-edit-btn").remove();
            newReplyEle.find(".pocketmonTrade-reply-delete-btn").remove();
          } 

          // 답글쓰기 처리
          newReplyEle.find(".pocketmonTrade-reply-re").click(function(){
            if(!removeNewReply()) return;
            const newReReplyEle = $.parseHTML($("#pocketmonTrade-reply-write").html());
            const reRelyContent = $(newReReplyEle).find("[name=replyContent]");
            // 대댓글은 마진 처리
            $(newReReplyEle).addClass("ms-50");

            // 취소버튼 처리
            $(newReReplyEle).find(".pocketmonTrade-reply-cancle-btn").click(function(){
              let isEmpty = reRelyContent.summernote('isEmpty');
              if(!isEmpty && !confirm("등록되지 않은 내용은 삭제됩니다\n댓글 등록을 취소하시겠습니까?")){
                return;
              }
              $(this).parent().parent().remove();
            });

            // 등록버튼 처리
            $(newReReplyEle).find(".pocketmonTrade-reply-update-btn").text("등록").click(function(){
              if (memberId == "") {
                alert("로그인을 해야만 댓글을 작성할 수 있습니다.");
                return;
              }
              if(reRelyContent.summernote('isEmpty')){
                return;
              }

              // replyNo; replyOrigin; replyWriter; replyContent; replyTime; replyGroup; replyLike;
              console.log($(this).parent().parent().parent().data("replygroup"));
              console.log(memberId);
              console.log(reRelyContent.summernote("code"));
              console.log(allboardNo);
              // let data = $(replyFormEle).serialize();

              // $.ajax({

              // })
              // loadReply();
            });

            $("#pocketmonTrade-reply-btn").click(function (e) {
              e.preventDefault();
              if(!removeNewReply()) return;
          
              if (memberId == "") {
                alert("로그인을 해야만 댓글을 작성할 수 있습니다.");
                return;
              }
              // 댓글 데이터 추출
              let replyFormEle = document.querySelector(".pocketmonTrade-reply-form");
              let data = $(replyFormEle).serialize();
          
              // 댓글창 비우기
              let summernoteEle = $(replyFormEle).find(".summernote");
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



            $(this).parent().parent().after(newReReplyEle);
            summernote();
          })

          // 수정 버튼 처리
          newReplyEle.find(".pocketmonTrade-reply-edit-btn").click(function () {
            if(!removeNewReply()) return;

            const newReReplyEle = $.parseHTML($("#pocketmonTrade-reply-write").html());

            // reply content 옮기기
            const replyEle = $(this).parent().parent();
            const writtenContent = replyEle.find(".pocketmonTrade-reply-content").html();
            $(newReReplyEle).find("textarea[name=replyContent]").val($("<div>"+(writtenContent)+"</div>").html());
            
            // 취소 버튼 처리
            $(newReReplyEle).find(".pocketmonTrade-reply-cancle-btn").click(function () {
                if (confirm("댓글 수정을 취소하시겠습니까?")) {
                  replyEle.show().next().remove();
                }
            });

            // 수정 버튼 처리
            $(newReReplyEle).find(".pocketmonTrade-reply-update-btn").click(function () {
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
          newReplyEle.find(".pocketmonTrade-reply-delete-btn").click(function () {
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
        $(".pocketmonTrade-replyCnt").text(response.length);
      },
      error: function () {
        console.log("댓글 load 통신오류!!!!");
      },
    });
  }

  // 대댓글 & 댓글 수정이 존재 할 시 제거
  function removeNewReply(){
    const isReplyEle = $(".pocketmonTrade-reply-reply");
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
  $("#pocketmonTrade-like").click(function (e) {
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
    if(!removeNewReply()) return;

    if (memberId == "") {
      alert("로그인을 해야만 댓글을 작성할 수 있습니다.");
      return;
    }
    // 댓글 데이터 추출
    let replyFormEle = document.querySelector(".pocketmonTrade-reply-form");
    let data = $(replyFormEle).serialize();

    // 댓글창 비우기
    let summernoteEle = $(replyFormEle).find(".summernote");
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
