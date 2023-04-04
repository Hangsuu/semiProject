<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote css, jQuery CDN -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
  .pocketmonTrade-reply-re:hover {
    cursor: pointer;
    
  }
  .pocketmonTrade-reply-form {
    position: relative;

    }
  
  .reReply {
  
    display: flex;
    align-items: start;
  }
  .reReply > *:first-child {
    margin-top: 5px;
    margin-right: 10px;
  }
  .reReply > *:last-child {
    flex-grow: 1;
  }
</style>
<!-- 모먼트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
  const memberId = "${sessionScope.memberId}";
  const memberLevel = "${sessionScope.memberLevel}";
  const allboardNo = "${pocketmonTradeMemberDto.getAllboardNo()}";
  const pocketmonTradeWriter = "${pocketmonTradeMemberDto.getPocketmonTradeWriter()}";
  const likeTableDto = {
    memberId: memberId,
    allboardNo: allboardNo,
  };
  const replyDto = {
    replyOrigin: allboardNo,
    replyWriter: memberId,
  };
  const boardWriter = "${pocketmonTradeMemberDto.getPocketmonTradeWriter()}";
</script>
<script src="/static/js/pocketmonTrade/pocketmonTradeReply.js"></script>

<!-- 댓글 템플릿 -->
<script type="text/template" id="reply-template" >
  <div class="row reply-box flex-box">
  	<div class="remove-box" style="width:5%">
  		<div class="align-center center" style="padding-top:1em">
  			<i class="fa-solid fa-reply fa-flip-both" style="font-size:16px"></i>
  		</div>
  	</div>
  	<div class="align-right remain-box" style="width:95%">
  		<div class="row flex-box" style="align-items:center">
  			<div class="reply-writer"></div>
  			<div class="reply-time ms-20" style="font-size:14px"></div>
  			<div class="align-right reply-option me-20"></div>
  			<div class="left reply-like-box">
  				<i class="fa-heart reply-like"></i>
  				<span class="reply-like-count"></span>
  			</div>
  		</div>
  		<div class="row reply-content" style="padding-left:1em"></div>
  	</div>
  </div>
</script>
<script type="text/template" id="reply-edit-template">
  <div class="row reply-edit">
  	<textarea class="row reply-edit-content form-input w-100 summernote-reply-edit"></textarea>
  </div>
</script>
<script type="text/template" id="reply-child-template">
  <div class="row reply-child">
  	<textarea class="form-input w-100 summernote-reply-child reply-textarea"></textarea>
  </div>
</script>

<!-- section -->
<section class="container-1100 mt-50 mb-30 ps-30 pe-30">
  <!-- article -->
  <article class="w-100">
    <div class="mb-10 flex">
      <div class="board-detail-origin">포켓몬교환 게시판</div>
      <a class="ml-auto">목록</a>
    </div>
    <div class="row board-detail-title">
      <c:if test="${pocketmonTradeMemberDto.getPocketmonTradeHead() != null}"> [${pocketmonTradeMemberDto.getPocketmonTradeHead()}] </c:if>
      ${pocketmonTradeMemberDto.getPocketmonTradeTitle()}
    </div>
    
    
    <div class="row flex">
      <div class="row flex">
      <div class="row flex board-nick-image">
        <img class="board-seal" src="/attachment/download?attachmentNo=${pocketmonTradeMemberDto.getAttachmentNo()}" />
        <a class="link" href="/pocketmonTrade?column=member_nick&keyword=${pocketmonTradeMemberDto.getMemberNick()}"
          >${pocketmonTradeMemberDto.getMemberNick()}</a>
        
        </div>
        <div class="board-detail-time"><fmt:formatDate value="${pocketmonTradeMemberDto.getPocketmonTradeWrittenTime()}" pattern="yyyy.MM.dd. H:m" /></div>
        <c:if test="${sessionScope.memberId == pocketmonTradeMemberDto.getPocketmonTradeWriter() || sessionScope.memberLevel == '관리자'}">
          <a class="board-detail-btn" href="/pocketmonTrade/${pocketmonTradeMemberDto.getPocketmonTradeNo()}/edit">수정</a>
          <a class="board-detail-btn" id="pocketmonTrade-delete-btn" href="/pocketmonTrade/delete/${pocketmonTradeMemberDto.getPocketmonTradeNo()}">삭제</a>
        </c:if>
      </div>
      <div class="ml-auto">조회수 ${pocketmonTradeMemberDto.getPocketmonTradeRead()}</div>
    </div>
    <%--
    <div class="row pocketmonTrade-info-head">
      <span class="pocketmonTradeRead">&nbsp;&nbsp;조회수 ${pocketmonTradeMemberDto.getPocketmonTradeRead()}</span>
      <span class="pocketmonTradeReply">댓글 <span class="pocketmonTrade-replyCnt">${pocketmonTradeMemberDto.getPocketmonTradeReply()}</span></span>
    </div>
    --%>
    <div class="row" style="border-top: 3px solid #f2f4fb; border-bottom: 3px solid #f2f4fb">
      <div class="row pocketmonTradeContent">
        <div class="row">${pocketmonTradeMemberDto.getPocketmonTradeContent()}</div>
      </div>
      <div class="row">
        <div>
          <a class="link" href="/pocketmonTrade?column=member_nick&keyword=${pocketmonTradeMemberDto.getMemberNick()}"
            ><b>${pocketmonTradeMemberDto.getMemberNick()}</b>님의 게시글 더 보기</a
          >
        </div>
      </div>

      <!-- 좋아요 댓글 신고 -->
      <div class="row flex">
        <div id="pocketmonTrade-like" class="left like-box" style="display: inline-block">
          <i class="fa-regular fa-heart fa-red" style="color: red"></i> 좋아요
          <span id="pocketmonTrade-like-Cnt">${pocketmonTradeMemberDto.getPocketmonTradeLike()}</span>
        </div>
        <div class="pocketmonTradeReply reply-number-box" style="display: inline-block">
          댓글 <span class="pocketmonTrade-replyCnt">${pocketmonTradeMemberDto.getPocketmonTradeReply()}</span>
        </div>
      </div>
    </div>

    <!-- 댓글 -->
    <div class="row reply-best-target"></div>
    <div class="row reply-target"></div>
    <!-- 신청 -->
    <div class="row mt-30">
      <textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
    </div>
    <!-- 글쓰기 & 목록 -->
    <div class="row pocketmonTrade-info-footer flex">
      <c:if test="${sessionScope.memberId != null}">
        <a class="board-detail-btn" href="write">글쓰기</a>
      </c:if>
      <a id="pocketmonTrade-list-btn" class="board-detail-btn" href="/pocketmonTrade">목록</a>
      <!-- <div>top으로</div> -->
    </div>
  </article>
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
