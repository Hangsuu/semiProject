<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script type="text/javascript">
	$(function () {
		
		$(".buy-point-form").submit(function(e) {
			  if (!confirm("정말 처리 완료 하시겠습니까?")) {
			    e.preventDefault();
			  }
			});
	});
</script>

<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">

	<form action="pointProcess" method="post" enctype="multipart/form-data" class="form buy-point-form">
		<div class="pocket-input-container" >
			<div>
				<c:if test="${pointDto.getPointBoardHead()!=0}">
					<h1>[처리완료]</h1>
				</c:if>
				<h1>포인트 요청서</h1>
			</div>	
			<div class="mb-50">
				<h3>입금 계좌</h3>
				<h3>KH은행 2023-04-04</h3>
				<h3>예금주 : POCKETDO</h3>
				<h2 >입금하실 금액</h2>
				<h2 >${pointDto.getRequestPoint()}원</h2>
			</div>	
			<div>
				<div>
					<div class="pocket-input-box">
						<span>글쓴이</span>
					</div>
					<div class="pocket-input-box">
						<span>
						${pointDto.getPointBoardWriter()}
						<input type="hidden" value="${pointDto.getPointBoardWriter()}" name="pointBoardWriter">  
						</span>
					</div>
				</div>	
				<div>
					<div class="pocket-input-box">
						<span>입금자 명</span>
					</div>		
					<div class="pocket-input-box">
						${pointDto.getWriterName()}		
					</div>
				</div>
				
				<div>
					<div class="pocket-input-box">
						<span>요청 포인트</span>
					</div>
					<div class="pocket-input-box">
						${pointDto.getRequestPoint()} point
						<input type="hidden" value="${pointDto.getPointBoardNo()}" name="pointBoardNo">
						<input type="hidden" value="${pointDto.getRequestPoint()}" name="requestPoint">
					</div>
				</div>
				<div>				
					<div class="pocket-input-box">
						<span>입금 하실 금액</span>
					</div>
					<div class="pocket-input-box">
						<span>${pointDto.getRequestPoint()} 원</span>
					</div>
				</div>
				<div>
				
					<div class="pocket-input-box2">
					<c:if test="${pointDto.getPointBoardHead()==0}">
						<c:if test="${sessionScope.memberLevel=='관리자'}">
								<div>
									<button type="submit" class="form-btn positive" >처리 완료</button>
								</div>
						</c:if>
					</c:if>
						<div>	
							<a href="list" class="form-btn positive" >목록</a>
						</div>
						<c:if test="${sessionScope.memberLevel=='관리자' || memberId == pointDto.getPointBoardWriter() || sessionScope.memberId != null}">
							<div>	
								<a href="${pageContext.request.contextPath}/point/delete?pointBoardNo=${pointDto.getPointBoardNo()}" class="form-btn negative confirm-delete" >삭제</a>
							</div>
						</c:if>
					</div>
				</div>	
			</div>	
			</div>
	</form>
	</article>
	
</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>