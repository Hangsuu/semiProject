<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
  textarea[name=pocketmonTradeContent] {
    min-height: 500px;
  }
</style>

<!-- section -->
<section test>
  <!-- aside -->
  <aside></aside>
  <!-- article -->
  <article class="container-800">
    <form action="#" method="post" enctype="multipart/form-data" class="w-100">
      <input type="hidden" name="pocketmonTradeNo" value="${pocketmonTradeDto.getPocketmonTradeNo()}"/>
      <div class="row center">
        <h1>포켓몬 교환</h1>
      </div>
      <div class="row">
        <label>제목
        <input class="form-input w-100" name="pocketmonTradeTitle" value="${pocketmonTradeDto.getPocketmonTradeTitle()}" type="text" placeholder="제목을 입력하세요">
      </label>
      </div>
      <div class="row">
        <label>내용 
          <textarea class="form-input w-100" name="pocketmonTradeContent" placeholder="내용을 입력하세요">${pocketmonTradeDto.getPocketmonTradeContent()}</textarea>
        </label>
      </div>
      <div class="row">
        <label>거래일
          <input type="datetime-local" value="${formattedDate}" class="form-input w-100" name="promise">
        </label>
      </div>
      <button type="submit" class="form-btn w-100 positive">등록</button>
    </form>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
