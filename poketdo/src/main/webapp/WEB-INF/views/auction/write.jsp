<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<script>
	$(function(){
		$("[name=attach]").change(function(){
			previewFile(this);
		});
		
		function previewFile(input){
			// 파일이 선택되지 않은 경우 함수 종료
			if (!input.files || !input.files[0]) {
				return;
			}
			
			// 파일 타입이 이미지가 아닌 경우 경고창 출력
			if (!input.files[0].type.match('image.*')) {
				alert("이미지 파일만 선택 가능합니다.");
				return;
			}
			
			// FileReader 객체를 사용하여 이미지 파일 미리보기 생성
			var reader = new FileReader();
			reader.onload = function(e) {
				$('.preview').attr('src', e.target.result);
			};
			reader.readAsDataURL(input.files[0]);
		}
	});
</script>
<div class="container-800 mt-50">
<form action="write" method="post" autocomplete="off" enctype="multipart/form-data">
<input type="hidden" name="auctionWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목<input class="form-input w-100" name="auctionTitle">
	</div>
	<div class="row">
		기간선택 : 
		<select name="lastDay" class="form-input">
			<option value="1">1일</option>
			<option value="3">3일</option>
		</select>
	</div>
	<div class="row">
	최소금액 : <input class="form-input w-40" name="auctionMinPrice">
	</div>
	<div class="row">
	최대금액 : <input class="form-input w-40" name="auctionMaxPrice">
	</div>
	<div class="row">
		대표이미지 등록<input class="form-btn neutral" name="attach" type="file">
	</div>
	<div class="row">
		<img src="https://via.placeholder.com/150x150?text=mainImg" style="max-width:150px; height:auto; max-height:150px" class="preview">
	</div>
	<div class="row w-100">
		<textarea name="auctionContent" rows="10" class="form-input w-100 summernote"></textarea>
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>