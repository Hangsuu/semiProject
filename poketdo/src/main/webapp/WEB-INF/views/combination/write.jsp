<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<script>
	$(function(){
		var tagList=[];
		var list=[];
		$(".tag-input").on("input", function(){
			var text = $(this).val();
			var regex = /^#(.*?)#/;
			var list = text.match(regex);
			if(list!=null && list.length!=0){
				tagList.push(list[1]);
				list.length=0;
				$(this).val("#");
				selectTag();
			}
		})
		
		function selectTag(){
			var target = $(".tag-box")
			target.empty();
			for(var i=0; i<tagList.length; i++){
				var inputTag = $("<span>").addClass("form-input").text(tagList[i]);
				var xmark = $("<i>").addClass("fa-solid fa-xmark").click()
				target.append(inputTag);
			}
		};
		
		
	});
</script>
<div class="container-800 mt-50">
<form action="write" method="post" autocomplete="off">
<input type="hidden" name="combinationWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목 : <input class="form-input" name="combinationTitle">
	</div>
	<div class="row">
		타입 : <select class="form-input" name="combinationType">
			<option>일반</option>
			<option>몬스터</option>
			<option>필드</option>
			<option>체육관</option>
			<option>기타</option>
		</select>
<!-- 태그박스 -->
		<div class="tag-box" style="display:inline-block">
		</div>
	</div>
	<div class="row w-100">
		<textarea name="combinationContent" rows="10" class="form-input w-100 summernote"></textarea>
	</div>
	<div class="row">
		<input class="form-input w-100 tag-input" value="#" placeholder="#태그 입력">
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>