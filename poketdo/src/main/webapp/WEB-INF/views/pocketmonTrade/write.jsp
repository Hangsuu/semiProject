<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<!-- summernote css, jQuery CDN -->
<link
  href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/pocketmonTrade/pocketmonTradeWrite.js"></script>
<script>
  const memberId = "${sessionScope.memberId}";
  const memberLevel = "${sessionScope.memberLevel}";
</script>
<!-- section -->
<section class="mt-50 mb-30">
  <!-- article -->
  <article class="container-1200">
    <form
      action="/pocketmonTrade/write"
      method="post"
      enctype="multipart/form-data"
      class="w-100"
    >
      <input
        type="hidden"
        name="pocketmonTradeWriter"
        value="${sessionScope.memberId}"
        required
      />
      <div class=" center">
        <h1>포켓몬 교환</h1>
      </div>
      <div class="row">
        <label>
          말머리
          <select class="form-input w-100" name="pocketmonTradeHead">
            <option value="">선택</option>
            <c:if test="${sessionScope.memberLevel == '관리자'}">
              <option>공지</option>
            </c:if>
            <option>교환</option>
            <option>요청</option>
            <option>나눔</option>
          </select>
        </label>
      </div>
      <div class="row">
        <label>
          제목
          <input
            class="form-input w-100"
            name="pocketmonTradeTitle"
            type="text"
            placeholder="제목을 입력하세요"
            required
          />
        </label>
      </div>
      <div class="row">
        <label
          >내용
          <textarea
            class="summernote"
            name="pocketmonTradeContent"
            placeholder="내용을 입력하세요"
            required
          ></textarea>
        </label>
      </div>
      <div class="row flex-row">
        <label
          >거래시간
          <input
            type="datetime-local"
            class="form-input w-50"
            name="promise"
          />
        </label>
        <button type="button" class="plus-1h-btn form-input">
          <i class="fa-solid fa-plus"></i>1시간
        </button>
        <button type="button" class="plus-6h-btn form-input">
          <i class="fa-solid fa-plus"></i>6시간
        </button>
        <button type="button" class="plus-1d-btn form-input">
          <i class="fa-solid fa-plus"></i>1일
        </button>
      </div>
      <div class="w-100 right">
        <button
          class="white-bold pocketmonTrade-cancle-btn w-20 form-btn"
          type="button"
        >
          취소
        </button>
        <button
          id="pocketmonTrade-insert-btn"
          type="submit"
          class="white-bold form-btn w-20 back-sc"
        >
          등록
        </button>
      </div>
    </form>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
