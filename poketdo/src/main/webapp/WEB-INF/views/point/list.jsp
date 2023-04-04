<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .pocketmonTrade-ing {
    border: 1px solid orange;
    color: orange;
    border-radius: 1em;
    padding: 0 0.5em;
  }
  .pocketmonTrade-request {

  }
  .pocketmonTrade-done {
    border: 1px solid forestgreen;
    color: forestgreen;
    border-radius: 1em;
    padding: 0 0.5em;
  }
  .pocketmonTrade-head {
    border-bottom: 2px #C2CCEE solid;
  }
  .pocketmonTrade-row:not(.pocketmonTrade-head) {
    border-bottom: 2px #F2F4FB solid;
  }
  .pocketmonTrade-notice-tag {
    color: red;
    border: 1px solid red;
    border-radius: 0.3em;
  }
</style>
<script>
  $(function(){
    const queryString = new URLSearchParams(location.search);
    const page = queryString.get("page") == null ? 1 : queryString.get("page");
    const column = queryString.get("column");
    const keyword = queryString.get("keyword");
    const type = queryString.get("")
    const pageVo = { page: page, column: column, keyword: keyword };
    // 포켓몬 교환 타입 설정 시 queryString 추가
    $(".pocketmonTrade-type").change(function(){
      queryString.set("type", $(this).val());
      window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
    })

    // 포켓몬 교환 isDone 설정 시 queryString 추가
    $(".pocketmonTrade-isDone").change(function(){
      queryString.set("isDone", $(this).val());
      window.location.href = window.location.origin + window.location.pathname + "?" + queryString.toString();
    })
  })
</script>
<!-- section -->
<section>
  <!-- article -->
  <article class="container-1200" style="min-height: 1000px">
    <div class="mt-50 mb-10">
      <h1>포인트 요청</h1>
    </div>

    <!-- 본문 -->
    <div class="pocketmonTrade-list">
      <div class="bold pocketmonTrade-row h-2p5em pocketmonTrade-head">
        <div class="flex-all-center">
      <c:if test="${sessionScope.memberLevel=='관리자'}">
        번호
       </c:if>
        </div>
        <div class="flex-all-center">구분</div>
        <div class="flex-all-center">제목</div>
        <div class="flex-align-center">작성자</div>
        <div class="flex-all-center">작성일</div>
      </div>

      <!-- 게시물 -->
      <c:forEach var="list" items="${list}">
        <div class="pocketmonTrade-row">
          <div class="flex-all-center">
        <c:if test="${sessionScope.memberLevel=='관리자'}">
          ${list.getPointBoardNo()}
         </c:if>
          </div>
          <div class="flex-all-center bold">
          <c:choose>
          	<c:when test="${list.getPointBoardHead()==0}">
          		[처리중]
          	</c:when>
          	<c:otherwise>[처리완료]</c:otherwise>
          </c:choose>
          
          </div>
          <div class="flex-align-center" >
          
          <c:choose>
			<c:when test="${sessionScope.memberLevel=='관리자' || sessionScope.memberId== list.getPointBoardWriter() }">

            <a
              class="pocketmonTrade-a-link"
              href="detail?pointBoardNo=${list.getPointBoardNo()}">
              포인트 충전 요청!
              </a>
              
			</c:when>
			<c:otherwise>
			비밀글입니다 <i class="fa-solid fa-lock"></i>
			</c:otherwise>              
          </c:choose>
              
          </div>
          <div class="flex-align-center">
          <c:choose>
			<c:when test="${sessionScope.memberLevel=='관리자' || sessionScope.memberId == list.getPointBoardWriter() }">
          
            	<img height="100%" src="/attachment/download?attachmentNo=${trade.getAttachmentNo()}">${list.getPointBoardWriter()}
 	        </c:when>
 	        <c:otherwise>
 	        	포인트 구매자
 	        </c:otherwise>   
           </c:choose> 
          </div>
          <div class="flex-all-center">
            ${list.getPointBoardTime()}
          </div>
        </div>
      </c:forEach>
    </div>
    <div class="row right mt-20">
      <c:if test="${sessionScope.memberId != null}">
        <a class="form-btn positive" href="requestPoint">
          💰 충전 요청</a>
        <a class="form-btn positive" href="list?column=point_board_writer&keyword=${sessionScope.memberId}">
          <i class="fa-solid fa-magnifying-glass" style="color:white"></i> 내가 쓴 글</a>
        <a class="form-btn positive" href="list">
         <i class="fa-solid fa-bars" style="color:white"></i> 전체 목록</a>
          
          </c:if>
    </div>
    
    
    	<!-- 페이지 네이션 -->
	<c:if test="${!list3.isEmpty()}">
		<div class="row pagination mb-30 mt-50" >
		
			<c:choose>
			
				<c:when test="${vo.first }">
					<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?page=1"><i class="fa-solid fa-angles-left"></i></a>
				</c:otherwise>
				
			</c:choose>
				
			<c:choose>
			
				<c:when test="${!vo.prev }">
					<a class="disabled"> <i class="fa-solid fa-angle-left"></i></a>
				</c:when>
				
				<c:otherwise>
					<a href="list?${vo.parameter}&page=${vo.prevPage}"> <i class="fa-solid fa-angle-left"></i> </a>
				</c:otherwise>
				
			</c:choose>
	
				<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
					<c:choose>
					
						<c:when test="${vo.page==i }">
							<a class="on">${i}</a>
						</c:when>
						
						<c:otherwise>
							<a href="list?${vo.parameter}&page=${i}">${i}</a>
						</c:otherwise>
						
					</c:choose>
				</c:forEach>
	
				<c:choose>
					<c:when test="${!vo.next }">
						<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.nextPage }"> <i class="fa-solid fa-angle-right"></i></a>
					</c:otherwise>
				</c:choose>
	
				<c:choose>
					<c:when test="${vo.last }">
						<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
					</c:when>
					<c:otherwise>
						<a href="list?${vo.parameter}&page=${vo.totalPage}"> <i class="fa-solid fa-angles-right"></i></a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
			<!-- 검색창  -->
			<div class="row center mb-30" >
				<form action="list" method="get">
							<select name="column" class="form-input">
								<option value="point_board_writer" selected>작성자</option>
							</select>
					<input type="search" name="keyword" placeholder="검색어" required
						value="${vo.keyword}" class="form-input">
					<button type="submit" class="form-btn neutral">검색</button>
		
				</form>
			</div>
  </article>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</section>
