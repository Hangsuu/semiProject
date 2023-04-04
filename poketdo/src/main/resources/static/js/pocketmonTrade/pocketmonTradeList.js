$(function () {
  const queryString = new URLSearchParams(location.search);
  const page = queryString.get("page") == null ? 1 : queryString.get("page");
  const column = queryString.get("column");
  const keyword = queryString.get("keyword");
  const type = queryString.get("type");
  const isDone = queryString.get("isDone");
  const pageVo = { page: page, column: column, keyword: keyword, type: type, isDone: isDone };
  // 포켓몬 교환 타입 설정 시 queryString 추가
  $(".pocketmonTrade-type").change(function () {
    queryString.set("type", $(this).val());
    queryString.set("page", 1);
    window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
  });

  // 포켓몬 교환 isDone 설정 시 queryString 추가
  $(".pocketmonTrade-isDone").change(function () {
    queryString.set("isDone", $(this).val());
    queryString.set("page", 1);
    window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
  });

  $(".typeTag").click(function (e) {
    e.preventDefault();
    const queryString = new URLSearchParams(location.search);
    queryString.set("type", $(this).text());
    console.log(queryString.toString());

    const newUrl = window.location.origin + location.pathname + "?" + queryString.toString();
    console.log(newUrl);
    location.href = newUrl;
  });
});
