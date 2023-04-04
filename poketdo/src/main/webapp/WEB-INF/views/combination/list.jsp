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
	//초기 상태 구현
	var params = new URLSearchParams(location.search);
	var paramTagList = params.get("tagList");
	var tagList = new Set();
	var list = [];
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
	else{
		makeList();
	}
	
	//태그 입력 시
	var preValue = $(".tag-search-input").val();
	$(".tag-search-input").on("input", function(){
		var text = $(this).val();
		if(preValue!=text){
			var regex = /^#(.*?)#/;
			var list = text.match(regex);
			
			if(list!=null && list.length!=0){
				var textVal = list[1];
				if(!tagList.has(textVal)&&textVal){
					tagList.add(textVal);
	
					list.length=0;
					$(this).val("#");
					
					selectedTag();
					listTag();
				}
				else{
					list.length=0;
					$(this).val("#");
				}
			}
		}
		preValue = text;
	})
	$(".tag-search-input").change(function(){
		var text = $(this).val();
		text = text.replace("#", "").trim();
		if(preValue!=text){
			if(!tagList.has(text)){
				tagList.add(text);
				//set을 전송 가능한 문자열 형태로 반환
				var setList = Array.from(tagList);
				var setListString = setList.join(",");
				$("[name=tagList]").val(setListString);
	
				$(this).val("#");
				tagList.add(text);
				selectedTag();
				listTag();
			}
		}
		preValue = text;
	})	

	//선택된 태그 창 생성
	function selectedTag(){
		$(".search-tag-target").empty();
		tagList.forEach(function(value){
			var selectedTag = $("<span>").addClass("form-input hash-tag").text(value).css("margin",0)
			var cancle = $("<i>").addClass("fa-solid fa-xmark").attr("data-tag-name", value)
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
		var recommandText = $("<span>").text("추천 태그 : ");
		$(".recommand-tag-target").append(recommandText);
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		$.ajax({
			url:"/rest/combination/"+setListString,
			method:"get",
			success:function(response){
				if(response.length==0){
					var tagSpan = $("<span>").addClass("form-input")
						.text("검색결과가 없습니다.")
					$(".recommand-tag-target").append(tagSpan);
				}
				else{
					for(var i=0; i<response.length; i++){
						var tagSpan = $("<span>").addClass("hash-tag").attr("data-tag-name", response[i].tagName)
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
		var page = 1;
		var column = $("[name=column]").val();
		var keyword = $("[name=keyword]").val();
		$("[name=keyword]").val("")
		
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		$(".list-target").empty();
		$(".pagination").empty();
		$.ajax({
			url:"/rest/combination/",
			method:"post",
			data:{
				keyword:keyword,
				column:column,
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
					//작성자 검색 링크 생성
					var nickLink = $("<a>").addClass("link").attr("href","list?page=1&column=member_nick&keyword="+response.list[i].memberNick)
					var seal = $("<img>").addClass("board-seal").attr("src", response.list[i].urlLink);
					var nick = response.list[i].memberNick;
					nickLink.append(seal).append(nick);
					$(html).find(".list-writer").append(nickLink);
					$(html).find(".list-time").text(response.list[i].combinationTime);
					$(html).find(".list-like").text(response.list[i].combinationLike);
					$(html).find(".list-read").text(response.list[i].combinationRead);
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
					var a = $("<a>").attr("href", "list?page=1&"+response.vo.tagParameter);
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				if(response.vo.prev){
					var a = $("<a>").attr("href", "list?page="+response.vo.prevPage+"&"+response.vo.tagParameter);
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
						var a = $("<a>").attr("href", "list?page="+n+"&"+response.vo.tagParameter).text(n);
						target.append(a);
					}
				}
				if(response.vo.next){
					var a = $("<a>").attr("href", "list?page="+response.vo.nextPage+"&"+response.vo.tagParameter);
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
					var a = $("<a>").attr("href", "list?page="+response.vo.totalPage+"&"+response.vo.tagParameter);
					var i = $("<i>").addClass("fa-solid fa-angles-right");
					a.append(i);
					target.append(a);
				}
			},
			error:function(){
				alert("리스트 오류")
			}
		})
	});
	//리스트 생성 함수
	function makeList(){
		var column = params.get("column");
		var keyword = params.get("keyword");
		var page = params.get("page");
		
		var setList = Array.from(tagList);
		var setListString = setList.join(",");
		$(".list-target").empty();
		$(".pagination").empty();
		$.ajax({
			url:"/rest/combination/",
			method:"post",
			data:{
				keyword:keyword,
				column:column,
				tagList:setListString,
				page:page,
			},
			success:function(response){
				for(var i=0; i<response.list.length; i++){
					var template = $("#list-template").html();
					var html = $.parseHTML(template);
					var reply = ""
					if(response.list[i].combinationReply>0){
						reply = " ("+response.list[i].combinationReply+")";
					}
					$(html).find(".list-no").text(response.list[i].combinationNo);
					$(html).find(".list-title").attr("href", "detail?allboardNo="+response.list[i].allboardNo+"&page="+page+"&"+response.vo.tagParameter)
							.text("["+response.list[i].combinationType+"] "+response.list[i].combinationTitle+reply);
					//작성자 검색 링크 생성
					var nickLink = $("<a>").addClass("link").attr("href","list?page=1&column=member_nick&keyword="+response.list[i].memberNick)
					var seal = $("<img>").addClass("board-seal").attr("src", response.list[i].urlLink);
					var nick = response.list[i].memberNick;
					nickLink.append(seal).append(nick);
					$(html).find(".list-writer").append(nickLink);
					$(html).find(".list-time").text(response.list[i].combinationTime);
					$(html).find(".list-like").text(response.list[i].combinationLike);
					$(html).find(".list-read").text(response.list[i].combinationRead);
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
					var a = $("<a>").attr("href", "list?page=1&"+response.vo.tagParameter);
					var i = $("<i>").addClass("fa-solid fa-angles-left");
					a.append(i);
					target.append(a);
				}
				if(response.vo.prev){
					var a = $("<a>").attr("href", "list?page="+response.vo.prevPage+"&"+response.vo.tagParameter);
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
						var a = $("<a>").attr("href", "list?page="+n+"&"+response.vo.tagParameter).text(n);
						target.append(a);
					}
				}
				if(response.vo.next){
					var a = $("<a>").attr("href", "list?page="+response.vo.nextPage+"&"+response.vo.tagParameter);
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
					var a = $("<a>").attr("href", "list?page="+response.vo.totalPage+"&"+response.vo.tagParameter);
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
	<div class="row"><h1 style="font-size:2em">공략 게시판</h1></div>
<!-- 검색 -->
	<div class="row">
		<input class="form-input tag-search-input w-10" value="#" style="display:inline-block">
<!-- 선택한 태그 들어가는 자리 -->
		<div class="search-tag-target" style="display:inline-block">
		</div>
	</div>
	<div class="row">
		<select name="column" class="form-input neutral">
			<option value="combination_title">제목</option>
			<option value="combination_type">타입</option>
			<option value="combination_content">내용</option>
			<option value="member_nick">글쓴이</option>
		</select>
		<input name="keyword" class="form-input search-list" placeholder="공략글 검색">
		<button class="form-btn neutral select-list">검색</button>
	</div>
<!-- 추천 태그 들어가는 자리 -->
		<div class="row recommand-tag-target">
			&nbsp;
		</div>
<!-- 게시판 테이블 -->
	<div class="row table-box mt-20">
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
	<div class="row">
		<c:if test="${sessionScope.memberId!=null}">
			<a href="write" class="form-btn positive"><i class="fa-solid fa-pen-to-square me-10" style="color:white"></i>글쓰기</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>