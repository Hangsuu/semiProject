<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
</script>
<script src="/static/js/timer.js"></script>
<script src="/static/js/bookmark.js"></script>
<div class="container-1100 mt-50">
	<div class="row"><h1 style="font-size:2em">굿즈 경매</h1></div>
<!-- 검색 -->
	<div class="row flex-box ms-10 me-20">
		<div class="flex-box">
			<form action="list" method="get" autocomplete="off">
				<select name="column" class="form-input neutral">
					<option value="auction_title">제목</option>
					<option value="auction_content">내용</option>
					<option value="member_nick">글쓴이</option>
				</select>
				<input name="keyword" class="form-input" placeholder="검색">
				<input name="page" type="hidden" value="${param.page}">
				<button class="form-btn neutral">검색</button>
			</form>
		</div>
		<div class="flex-box align-right"><a class="form-btn neutral" href="list?page=1">전체보기<i class="fa-solid fa-sort ms-10"></i></a></div>
		<div class="flex-box ms-10"><a class="form-btn neutral" href="list?page=1&${vo.parameter}&item=auction_finish_time&order=asc&special=auction_finish_time>sysdate and (auction_max_price=0 or auction_min_price<auction_max_price)">종료임박<i class="fa-solid fa-sort ms-10"></i></a></div>
		<div class="flex-box ms-10"><a href="bookmark?page=1&keyword=&column=" class="form-btn neutral">즐겨찾기 보기</a></div> 
	</div>
<!-- 게시판 테이블 -->
	<div class="row flex-box" style="flex-wrap:wrap">
		<c:forEach var="auctionDto" items="${list}">
			<div style="padding:1em; border:1px solid #F2F4FB; border-radius:0.5em; margin:10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.05)" class="center">
				<div style="width:165px; height:165px" class="flex-box align-center">
					<c:choose>
						<c:when test="${auctionDto.auctionMainImg>0}">
							<a href="detail?allboardNo=${auctionDto.allboardNo}&page=${param.page}&${vo.parameter}" class="link">
								<img style="max-width:165px; width:auto;  height:auto; max-height:165px;" src="/attachment/download?attachmentNo=${auctionDto.auctionMainImg}">
							</a>
						</c:when>
						<c:otherwise>
							<a href="detail?allboardNo=${auctionDto.allboardNo}&page=${param.page}&${vo.parameter}" class="link">
								<img style="max-width:165px; max-height:165px; height:auto; width:auto; " src="/static/image/noimage.png">
							</a>
						</c:otherwise>
					</c:choose>
				</div>
		<!-- 남은시간 -->
				<div class="row flex-box">
					<div class="w-100" style="display:inline-box">
						<c:choose>
							<c:when test="${auctionDto.finish==true}">
								<span>종료된 상품</span>
							</c:when>
							<c:otherwise>
								<div class="rest-time" data-finish-time="${auctionDto.finishTime}" >
									남은시간 : ${auctionDto.time}
								</div>
							</c:otherwise>
						</c:choose>
					</div>
			<!-- 즐겨찾기 -->
					<div class="align-right">
						<i class="fa-regular fa-bookmark" style="color:gray" data-allboard-no="${auctionDto.allboardNo}" data-bookmark-type="auction"></i>
					</div>
				</div>
		<!-- 제목 -->
				<div class="row do-not-line-over" style="width:165px;" title="${auctionDto.auctionTitle}">
					<a href="detail?allboardNo=${auctionDto.allboardNo}&page=${param.page}&${vo.parameter}" class="link">
						${auctionDto.auctionTitle} 
						<c:if test="${auctionDto.auctionReply!=0}">(${auctionDto.auctionReply})</c:if>
					</a>
				</div>
		<!-- 닉네임 및 즐겨찾기 -->
				<div class="row flex-box board-nick-image">
					<div class="do-not-line-over" style="width:165px">
						<a href="list?page=1&column=member_nick&keyword=${auctionDto.memberNick}" class="link"><img class="board-seal" src="${auctionDto.urlLink}">
						<span>${auctionDto.memberNick}</span></a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
<!-- 테이블 끝 -->
<!-- 페이지네이션 -->
	<div class="row center pagination">
	<!-- 1페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.first}">
				<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.parameter}&page=1&${vo.addParameter}"><i class="fa-solid fa-angles-left"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 이전 페이지로 이동 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="list?${vo.parameter}&page=${vo.prevPage}&${vo.addParameter}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angle-left disabled"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 번호들 -->
		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}" step="1">
			<c:choose>
				<c:when test="${vo.page==i}"><a class="on disabled">${i}</a></c:when>
				<c:otherwise><a href="list?${vo.parameter}&page=${i}&${vo.addParameter}" class="">${i}</a></c:otherwise>
			</c:choose>
		</c:forEach>
	<!-- 다음 페이지 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="list?${vo.parameter}&page=${vo.nextPage}&${vo.addParameter}" class=""><i class="fa-solid fa-angle-right"></i></a>
			</c:when>
			<c:otherwise><a class="disabled">
				<i class="fa-solid fa-angle-right"></i></a>
			</c:otherwise>
		</c:choose>
	<!-- 마지막페이지로 -->
		<c:choose>
			<c:when test="${!vo.last}">
				<a href="list?${vo.parameter}&page=${vo.totalPage}&${vo.addParameter}" class=""><i class="fa-solid fa-angles-right"></i></a>
			</c:when>
			<c:otherwise>
				<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
			</c:otherwise>
		</c:choose>
	</div>
<!-- 페이지네이션 끝 -->
	<div class="row ms-10">
		<c:if test="${sessionScope.memberId!=null}">
			<a href="write" class="form-btn positive"><i class="fa-solid fa-pen-to-square me-10" style="color:white"></i>글쓰기</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>