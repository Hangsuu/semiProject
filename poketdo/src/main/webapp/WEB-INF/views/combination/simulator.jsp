<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
</script>
<script src="/static/js/timer.js"></script>
<script type="text/javascript">
$(function(){
	$(".table").hide();
	var params = new URLSearchParams(location.search);
	var paramTagList = params.get("tagList");
	var tagList = new Set();
	//파라미터에 tagList를 달고 왔을 시
	if(paramTagList){
		var arr = paramTagList.split(",");
		$.each(arr, function(index, value){
			tagList.add(value);
		});
		selectedTag();
		listTag();
		makeList();
	}
	var page = params.get("page");
	//태그 버튼 누를 시
	$(".tag-search-btn").click(function(){
		var text = $(".tag-search-input").val();
		if(!text) return;
		$(".tag-search-input").val("");
		//set에 추가하고 전송가능한 배열 형태로 변경
		tagList.add(text);
		selectedTag();
		listTag();
	});
	//선택된 태그 창 생성
	function selectedTag(){
		$(".search-tag-target").empty();
		tagList.forEach(function(value){
			var selectedTag = $("<span>").addClass("form-input me-10 hash-tag").text(value)
			var cancle = $("<i>").addClass("fa-solid fa-xmark ms-10").attr("data-tag-name", value)
					.click(removeTag);
			selectedTag.append(cancle);
			$(".search-tag-target").append(selectedTag);
		});
	}
	//태그 검색 함수
	function searchTag(){
		tagList.add($(this).data("tag-name"));
		selectedTag();
		listTag();
	}
	//태그 삭제 함수
	function removeTag(){
		tagList.delete($(this).data("tag-name"));
		if(tagList.length==0) return;
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		selectedTag();
		listTag();
	}
	//추천 태그 목록 생성 함수
	function listTag(){
		$(".recommand-tag-target").empty();
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		$.ajax({
			url:"/rest/combination/"+setListString,
			method:"get",
			success:function(response){
				if(response.length==0){
					var tagSpan = $("<span>").addClass("form-input me-10")
						.text("검색결과가 없습니다.")
					$(".recommand-tag-target").append(tagSpan);
				}
				else{
					for(var i=0; i<response.length; i++){
						var tagSpan = $("<span>").addClass("form-input me-10 hash-tag").attr("data-tag-name", response[i].tagName)
								.text(response[i].tagName+"("+response[i].tagCount+")").click(searchTag);
						$(".recommand-tag-target").append(tagSpan);
					}
				}
			},
			error:function(){
				
			},
		});
	}
	//리스트 검색 버튼 클릭 시
	$(".select-list").click(function(){
		makeList();
	});
	//검색시 리스트 생성 함수
	function makeList(){
		$(".table").show();
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		$(".list-target").empty();
		$(".pagination").empty();
		$.ajax({
			url:"/rest/combination/",
			method:"post",
			data:{
				tagList:setListString,
				page:page,
			},
			success:function(response){
				for(var i=0; i<response.list.length; i++){
					var template = $("#list-template").html();
					var html = $.parseHTML(template);
					$(html).find(".list-no").text(response.list[i].combinationNo);
					$(html).find(".list-title").attr("href", "detail?allboardNo="+response.list[i].allboardNo+"&page="+page+"&"+response.vo.tagParameter)
							.text(response.list[i].combinationTitle);
					$(html).find(".list-writer").text(response.list[i].combinationWriter);
					$(html).find(".list-time").text(response.list[i].combinationTime);
					$(html).find(".list-like").text(response.list[i].combinationLike);
					$(html).find(".list-read").text(response.list[i].combinationRead);
					$(".list-target").append(html);
				};
				var target = $(".pagination");
				if(response.vo.first){
					var a = $("<a>").addClass("disabled");
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				else{
					var a = $("<a>").attr("href", "simulator?page=1&"+response.vo.tagParameter);
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				if(response.vo.prev){
					var a = $("<a>").attr("href", "simulator?page="+response.vo.prevPage+"&"+response.vo.tagParameter);
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
						var a = $("<a>").attr("href", "simulator?page="+n+"&"+response.vo.tagParameter).text(n);
						target.append(a);
					}
				}
				if(response.vo.next){
					var a = $("<a>").attr("href", "simulator?page="+response.vo.nextPage+"&"+response.vo.tagParameter);
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
					var a = $("<a>").attr("href", "simulator?page="+response.vo.totalPage+"&"+response.vo.tagParameter);
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
		<td class="list-no"></td>
		<td>
			<a class="link list-title">
			</a>
		</td>
		<td class="list-writer"></td>
		<td class="list-time"></td>
		<td class="list-like"></td>
		<td class="list-read"></td>
	</tr>
</script>
<div class="container-1200 mt-50" style="min-height:1200px">
	<div class="row"><h1 style="font-size:2em">조합 시뮬레이터</h1></div>
<!-- 검색 -->
	<div class="row">
		<input class="form-input tag-search-input">
		<button class="form-btn neutral tag-search-btn">검색</button>
	</div>
<!-- 선택한 태그 들어가는 자리 -->
	<div class="row search-tag-box mt-50">
		<div class="row ">
			선택 몬스터	<button class="form-btn neutral select-list">조합글 검색</button>
		</div>
		<div class="row search-tag-target mt-30">
		</div>
	</div>
<!-- 추천 태그 들어가는 자리 -->
	<div class="row recommand-tag-box mt-50" style="line-height:4em">
		<div class="row">
			추천 몬스터(선택)
		</div>
		<div class="row recommand-tag-target mt-30">
		</div>
	</div>
<!-- 게시판 테이블 -->
	<div class="row mt-50">
		<table class="table table-slit center">
			<thead>
				<tr>
					<th>글번호</th>
					<th class="w-40">제목</th>
					<th>글쓴이</th>
					<th>게시시간</th>
					<th>좋아요</th>
					<th>조회수</th>
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