<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote css, jQuery CDN -->
<link
  href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/pocketmonTrade/pocketmonTradeWrite.js"></script>

<!-- section -->
<section>
  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <form action="#" method="post" enctype="multipart/form-data" class="w-100">
      <input
        type="hidden"
        name="pocketmonTradeWriter"
        value="${sessionScope.memberId}"
      />
      <div class="row center">
        <h1>포켓몬 교환</h1>
      </div>
      <div class="row">
        <label>
          말머리
          <select class="form-input w-100" name="pocketmonTradeHead">
            <option value="">선택</option>
            <c:if test="${sessionScope.memberLevel == '마스터'}">
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
          ></textarea>
        </label>
      </div>
      <div class="row">
        <label
          >거래일
          <input
            type="datetime-local"
            class="form-input w-100"
            name="promise"
          />
        </label>
      </div>
      <button
        id="pocketmonTrade-insert-btn"
        type="submit"
        class="form-btn w-100 positive"
      >
        등록
      </button>
    </form>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
