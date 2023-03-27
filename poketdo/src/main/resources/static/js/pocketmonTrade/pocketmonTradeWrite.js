$(function () {
  var promiseEle = $("input[name=promise]");
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
    var titleEle = $("input[name=pocketmonTradeTitle]");
    var contentEle = $("input[name=pocketmonTradeContent]");

    var isEmptyTitle = titleEle.val() == "";
    var isEmptyContent = contentEle.val() == "";
    var isEmptyPromise = promiseEle.val() == "";
    // 로그인시에만 작성가능

    if (memberId == "") {
      e.preventDefault();
      alert("로그인 해야만 글 작성 가능합니다");
      return;
    }
    // 제목 입력 확인
    if (isEmptyTitle) {
      e.preventDefault();
      alert("제목을 입력해주세요");
      return;
    }
    // 내용 입력 확인
    if (isEmptyContent) {
      e.preventDefault();
      alert("내용을 입력해주세요");
      return;
    }
    // 약속시간 입력 확인
    if (isEmptyPromise) {
      e.preventDefault();
      alert("거래일을 입력해주세요");
      return;
    }
    if (new Date(promiseEle.val()) < new Date()) {
      e.preventDefault();
      alert("현재 시간보다 이후 시간을 입력해주세요");
      return;
    }
  });

  // 날짜 default 현재시간
  var now = new Date();
  var offset = new Date().getTimezoneOffset() * 60000;
  var dateOffset = new Date(now.getTime() - offset);
  promiseEle.val(dateOffset.toISOString().slice(0, 16));

  // promise 1시간 추가
  $(".plus-1h-btn").click(function () {
    console.log();
    var exTime = promiseEle.val();
    var plus1h = new Date(new Date(exTime).getTime() + 60 * 60 * 1000);
    var dateOffset = new Date(plus1h.getTime() - offset);
    promiseEle.val(dateOffset.toISOString().slice(0, 16));
  });

  // promise 6시간 추가
  $(".plus-6h-btn").click(function () {
    var exTime = promiseEle.val();
    var plus1h = new Date(new Date(exTime).getTime() + 6 * 60 * 60 * 1000);
    var dateOffset = new Date(plus1h.getTime() - offset);
    promiseEle.val(dateOffset.toISOString().slice(0, 16));
  });

  // promise 1일 추가
  $(".plus-1d-btn").click(function () {
    var exTime = promiseEle.val();
    var plus1h = new Date(new Date(exTime).getTime() + 24 * 60 * 60 * 1000);
    var dateOffset = new Date(plus1h.getTime() - offset);
    promiseEle.val(dateOffset.toISOString().slice(0, 16));
  });

  // 날짜 입력칸 클릭 시 date 설정 생기기
  $("input[name=promise]").click(function (e) {
    this.showPicker();
  });

  // 포켓몬교환 write 취소 버튼
  $(".pocketmonTrade-cancle-btn").click(function () {
    console.log("짜루짜루 진짜루?");
    if (confirm("글 작성을 취소하시겠습니까?")) {
      window.history.back();
    }
  });
});
