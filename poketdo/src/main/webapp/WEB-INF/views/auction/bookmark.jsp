<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
</script>
<script src="${pageContext.request.contextPath}/static/js/timer.js"></script>
<script type="text/javascript">
$(function(){
	var params = new URLSearchParams(location.search);
	var column = params.get("column");
	var keyword = params.get("keyword");
	var page = params.get("page");
	checkList();
	
	function starClick(){
		$(".fa-bookmark").click(function(){
			console.log("클릭");
			if(confirm("정말 즐겨찾기 해제하시겠습니까?")){
				var allboardNo = $(this).data("allboard-no");
				var bookmarkType = $(this).data("bookmark-type");
				$.ajax({
					url:contextPath+"/rest/bookmark/",
					method:"post",
					data:{
						allboardNo:allboardNo,
						memberId:memberId,
						bookmarkType:bookmarkType,
					},
					success:function(){
						checkList();
					},
					error:function(){
						alert("통신에러");
					}
				});
			}
		});
	}
	
	function checkList(){
		$(".list-target").empty();
		$(".pagination").empty();
		$.ajax({
			url:contextPath+"/rest/auction/list",
			method:"post",
			data:{
				column:column,
				keyword:keyword,
				page:page,
			},
			success:function(response){
				for(var i=0; i<response.list.length; i++){
					var template = $("#list-template").html();
					var html = $.parseHTML(template);
					$(html).find(".list-no").text(response.list[i].auctionNo);
					$(html).find(".list-title").attr("href", "bookmarkDetail?allboardNo="+response.list[i].allboardNo+"&page="+page+"&"+response.vo.parameter)
							.addClass("do-not-over").text(response.list[i].auctionTitle);
					//작성자 검색 링크 생성
					var nickLink = $("<a>").addClass("link").attr("href","list?page=1&column=member_nick&keyword="+response.list[i].memberNick)
					var seal = $("<img>").addClass("board-seal").attr("src", contextPath + response.list[i].urlLink).css("vertical-align", "middle");
					var nick = $("<span>").text(response.list[i].memberNick).css("vertical-align", "middle");
					nickLink.append(seal).append(nick);
					$(html).find(".list-writer").append(nickLink);
					
					if(response.list[i].finish){
						$(html).find(".list-time").text("종료");
					}
					else{
						$(html).find(".rest-time").attr("data-finish-time", response.list[i].finishTime);
					}
					$(html).find(".list-read").text(response.list[i].auctionRead);
					$(html).find(".list-like").text(response.list[i].auctionLike);
					$(html).find(".fa-bookmark").attr("data-allboard-no", response.list[i].allboardNo).click(starClick);
					$(".list-target").append(html);
				};
				var target = $(".pagination");
				$(".pagination").empty();
				if(response.vo.first){
					var a = $("<a>").addClass("disabled");
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				else{
					var a = $("<a>").attr("href", "bookmark?page=1&"+response.vo.parameter);
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				if(response.vo.prev){
					var a = $("<a>").attr("href", "bookmark?page="+response.vo.prevPage+"&"+response.vo.parameter);
					var i = $("<i>").addClass("fa-solid fa-angle-left")
					a.append(i);
					target.append(a);
				}
				else{
					var a = $("<a>").addClass("disabled");
					var i = $("<i>").addClass("fa-solid fa-angle-left")
					a.append(i);
					target.append(a);
				}
				for(var n=response.vo.startBlock; n<=response.vo.finishBlock; n++){
					if(response.vo.page==n){
						var a = $("<a>").addClass("on disabled").text(n);
						target.append(a);
					}
					else{
						var a = $("<a>").attr("href", "bookmark?page="+n+"&"+response.vo.parameter).text(n);
						target.append(a);
					}
				}
				if(response.vo.next){
					var a = $("<a>").attr("href", "bookmark?page="+response.vo.nextPage+"&"+response.vo.parameter);
					var i = $("<i>").addClass("fa-solid fa-angle-right")
					a.append(i);
					target.append(a);
				}
				else{
					var a = $("<a>").addClass("disabled");
					var i = $("<i>").addClass("fa-solid fa-angle-right")
					a.append(i);
					target.append(a);
				}
				if(response.vo.last){
					var a = $("<a>").addClass("disabled");
					var i = $("<i>").addClass("fa-solid fa-angles-right");
					a.append(i);
					target.append(a);
				}
				else{
					var a = $("<a>").attr("href", "bookmark?page="+response.vo.totalPage+"&"+response.vo.parameter);
					var i = $("<i>").addClass("fa-solid fa-angles-right");
					a.append(i);
					target.append(a);
				}
			},
			error:function(){
				alert("리스트 오류")
			}
		})
	}
	
});
</script>
<script type="text/template" id="list-template">
	<tr>
		<td class="list-no" style="vertical-align:middle"></td>
		<td style="vertical-align:middle">
			<div class="do-not-line-over" style="width:350px">
				<a class="link list-title">
				</a>
			</div>
		</td>
		<td class="list-writer" style="vertical-align:middle"></td>
		<td class="list-time" style="vertical-align:middle">
			<div class="rest-time" data-finish-time="${auctionDto.finishTime}" >
			</div>
		</td>
		<td class="list-read" style="vertical-align:middle"></td>
		<td class="list-like" style="vertical-align:middle"></td>
		<td style="vertical-align:middle"><i class="fa-solid fa-bookmark" style="color:gray" data-bookmark-type="auction"></i></td>
	</tr>
</script>
<div class="container-1000 mt-50" style="min-height:700px">
<!-- 검색 -->
	<div class="row flex-box">
		<div class="row"><h1 style="font-size:2em">즐겨찾기 목록</h1></div>
		<div class="row align-right" style="display:inline-block; align-items:flex-end">
			<a href="list?page=1" class="form-btn neutral">전체 보기</a> 
		</div>
	</div>
<!-- 게시판 테이블 -->
	<div class="row" style="padding:1em; border:1px solid #F2F4FB; border-radius:0.5em; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.05)">
		<table class="table table-slit center">
			<thead>
				<tr>
					<th>글번호</th>
					<th class="w-40">제목</th>
					<th>글쓴이</th>
					<th>남은시간</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th></th>
				</tr>
			</thead>
			<tbody class="list-target">
			</tbody>
		</table>
	</div>
<!-- 테이블 끝 -->
<!-- 페이지네이션 -->
	<div class="row center pagination">
	</div>
<!-- 페이지네이션 끝 -->
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>