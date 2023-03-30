$(function () {
  const queryString = new URLSearchParams(location.search);
  const page = queryString.get("page") == null ? 1 : queryString.get("page");
  const column =
    queryString.get("column") == null ? "" : queryString.get("column");
  const keyword =
    queryString.get("keyword") == null ? "" : queryString.get("keyword");
  const mode = queryString.get("mode") == null ? "" : queryString.get("mode");
  const data = { page: page, column: column, keyword: keyword };

  loadList();

  // 메세지 모두 선택 체크박스
  var checkAllEle = $(".message-check-all");
  // 메세지 개별 선택 체크박스
  var checkOneBtn = $(".message-check-one");

  // 메세지 check-all과 모든 버튼 동기화
  checkAllEle.change(function () {
    $("input[type=checkbox]").prop("checked", $(this).prop("checked"));
  });

  // 메세지 개별 버튼과 check-all 동기화
  checkOneBtn.change(function () {
    var checkedOneBtn = $(".message-check-one:checked");
    var checkOneCnt = checkOneBtn.length;
    var checkedCnt = checkedOneBtn.length;
    checkAllEle.prop("checked", checkOneCnt == checkedCnt);
    // 첫번 째 다 눌리면 check-all도 체크
  });

  // 메세지 삭제 버튼 클릭 event 등록
  $(".message-delete-btn").click(function () {
    var checkedOneBtn = $("input.message-check-one:checked");
    var checkedCnt = checkedOneBtn.length;
    if (checkedCnt == 0) {
      alert("삭제하실 쪽지를 선택하세요");
    } else {
      // 확인
      if (!confirm(checkedCnt + "개의 쪽지를 삭제하시겠습니까?")) {
        return;
      }

      // 체크 된 메세지의 messageNo를 list에 저장
      var list = [];
      checkedOneBtn.each(function () {
        list.push(parseInt($(this).val()));
      });

      // for문으로 delete 실행
      for (var i = 0; i < list.length; i++) {
        $.ajax({
          url: "/rest/message/receive",
          method: "put",
          data: { messageNo: list[i] },
          success: function () {
            loadList();
          },
          error: function () {},
        });
      }
    }
  });
  // 새로고침 비동기 로드
  $(".message-refresh-btn").click(function () {
    loadList();
    $(".fa-rotate-right").addClass("custom-spin");
    setTimeout(function () {
      $(".fa-rotate-right").removeClass("custom-spin");
    }, 500);
  });

  // 로드 테스트
  function loadList() {
    $.ajax({
      url: "/rest/message/receive/",
      method: "get",
      data: data,
      success: function (response) {
        var messageList = response.list;
        var sendTimeList = response.sendTimeList;
        const pageVo = response.pageVoList[0];
        console.log(pageVo);

        // target 비우고 다시 로드
        $(".target").empty();
        for (let i = 0; i < messageList.length; i++) {
          const message = messageList[i];
          if (mode === "new" && message.messageReadTime != null) {
            continue;
          }
          const sendTime = sendTimeList[i];

          var newReceiveMsgRow = $.parseHTML($("#receive-message-row").html());

          // 체크박스의 value=messageNo
          $(newReceiveMsgRow)
            .find("input.message-check-one")
            .val(message.messageNo);

          // 보낸사람 기입
          const messageSender = message.messageSender;
          $(newReceiveMsgRow)
            .find(".message-sender-col")
            .text(
              message.messageSenderNick +
                `(${
                  messageSender.length >= 4
                    ? messageSender.substring(0, 4) +
                      "*".repeat(messageSender.length - 4)
                    : messageSender
                })`
            )
            .attr("href", "/message/write?recipient=" + message.messageSender);

          // 메세지 제목
          $(newReceiveMsgRow)
            .find(".message-title-col")
            .text(message.messageTitle)
            .attr(
              "href",
              "/message/receive/detail?messageNo=" + message.messageNo
            );

          // 현재시간 연월일 추출
          const now = new Date();
          const nowYear = now.getFullYear();
          const nowMonth = now.getMonth();
          const nowDay = now.getDate();

          // 보낸시간 연월일 추출
          const sendTimeDate = new Date(sendTime);
          const sendYear = sendTimeDate.getFullYear();
          const sendMonth = sendTimeDate.getMonth();
          const sendDay = sendTimeDate.getDate();

          const isToday =
            nowYear === sendYear &&
            nowMonth === sendMonth &&
            nowDay === sendDay;

          // 메세지 보낸 시간(오늘 보냈으면 시간만 출력)
          $(newReceiveMsgRow)
            .find(".message-send-time-col")
            .text(isToday ? sendTime.slice(-5) : sendTime)
            .attr(
              "href",
              "/message/receive/detail?messageNo=" + message.messageNo
            );

          // 메세지 색상 설정 (읽은 메세지는 회색, 안 읽은 메세지는 블루)
          if (message.messageReadTime != null) {
            $(newReceiveMsgRow).find("a").addClass("gray");
          } else {
            $(newReceiveMsgRow).find("a").addClass("blue");
          }
          $(".target").append(newReceiveMsgRow);
        }

        // h1태그 옆 숫자 반영
        // 받은 메세지 전체 숫자
        $(".message-receive-cnt").text(messageList.length);
        // 받은 메세지 중 안 읽은 숫자
        $.ajax({
          url: "/rest/message/receive/notReadCount",
          method: "get",
          data: { memberId: memberId },
          success: function (response) {
            $(".message-not-read-cnt").text(response);
          },
          error: function () {
            console.log("안 읽은 메세지 count 통신에러 !!!!");
          },
        });
      },
      error: function () {
        console.log("받은 편지함 테스트 통신오류");
      },
    });
  }
});
