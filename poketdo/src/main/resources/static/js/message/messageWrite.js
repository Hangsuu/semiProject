$(function () {
  var messageSendForm = $("#message-send-form");
  $("#message-send-btn").click(function (e) {
    e.preventDefault();
    var isLogin =
      messageSendForm.find("input[name='messageSender']").val() != "";
    if (!isLogin) {
      alert("로그인해야 메세지를 보낼 수 있습니다.");
      return;
    }
    const isMessageRecipientNull = $("[name=messageRecipient]").val() == "";
    if (isMessageRecipientNull) {
      alert("쪽지를 받는 사람을 입력해주세요");
      return;
    }
    const isMessageTitleNull = $("[name=messageTitle]").val() == "";
    if (isMessageTitleNull) {
      alert("쪽지 제목을 입력해주세요");
      return;
    }
    const isMessageContentNull = $("[name=messageContent]").val() == "";
    if (isMessageContentNull) {
      alert("쪽지 내용을 입력해주세요");
      return;
    }
    $.ajax({
      url: "/rest/message/write",
      method: "post",
      data: messageSendForm.serialize(),
      success: function () {
        alert("쪽지를 성공적으로 보냈습니다");
        messageSendForm[0].reset();
      },
      error: function () {
        console.log("메세지 전송 통신오류");
      },
    });
  });
});
