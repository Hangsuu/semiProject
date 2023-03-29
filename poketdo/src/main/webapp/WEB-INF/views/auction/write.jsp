<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<style>
.valid-message {
  color: forestgreen;
  display: none;
}
.invalid-message {
  color: red;
  display: none;
}
.invalid-message2 {
  color: red;
  display: none;
}
.valid ~ .valid-message {
  display: block;
}
.invalid ~ .invalid-message {
  display: block;
}
.invalid2 ~ .invalid-message2 {
  display: block;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<script>
	$(function(){
		var valid={
				titleValid:false,
				lasDayValid:false,
				minPriceValid:true,
				maxPriceValid:false,
				contentValid:false,
				isAllValid:function(){
					return this.titleValid && this.lastDayValid && this.minPriceValid && this.maxPriceValid 
					&& this.contentValid
				}
		}
		$("[name=auctionTitle]").blur(function(){
			$(this).removeClass("invalid valid");
			var text =$(this).val().trim();
			if(text){
				$(this).addClass("valid");
			}
			else{
				$(this).addClass("invalid");
			}
			checkAllValid();
		});
		$('[name=auctionContent]').on('summernote.change', function(we, contents, $editable) {
			console.log(contents);
			$(this).removeClass("invalid valid");
			if(contents=="<p><br></p>" || contents=="<br>"){
				$(this).addClass("invalid");
			}
			else{
				$(this).addClass("valid");
			}
			checkAllValid();
		});
		
		
		function checkAllValid(){
			var isAllChecked =  $("[name=auctionTitle]").hasClass("valid") && $("[name=auctionContent]").hasClass("valid");
			if(isAllChecked){
				$(".submit-btn").attr("type", "submit");
			}
			else {
				$(".submit-btn").attr("type", "button");
			}
		}
		
		
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
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<div class="row">
		기간선택 : 
		<select name="lastDay" class="form-input">
			<option value="0">선택</option>
			<option value="1">1일</option>
			<option value="3">3일</option>
		</select>
	</div>
	<div class="row">
	최소금액 : <input class="form-input w-40" name="auctionMinPrice" placeholder="경매 시작가 입력(미입력시 0원)">
	</div>
	<div class="row">
	최대금액 : <input class="form-input w-40" name="auctionMaxPrice" placeholder="즉시 낙찰가 입력(미입력시 제한 없음)">
	</div>
	<div class="row">
		대표이미지 등록<input class="form-btn neutral" name="attach" type="file">
	</div>
	<div class="row">
		<img src="https://via.placeholder.com/150x150?text=mainImg" style="max-width:150px; height:auto; max-height:150px" class="preview">
	</div>
	<div class="row w-100">
		<textarea name="auctionContent" rows="10" class="form-input w-100 summernote"></textarea>
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<button type="button" class="form-btn neutral submit-btn">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>