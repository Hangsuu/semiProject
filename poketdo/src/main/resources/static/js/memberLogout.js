$(function () {
  $(".logout-btn").click(function (e) {
    if (window.location.href.endsWith("pocketmonTrade/write")) {
      e.preventDefault();
      window.location.href = contextPath + "/pocketmonTrade";
      window.location.href = contextPath + "/member/logout";
    }
  });
});
