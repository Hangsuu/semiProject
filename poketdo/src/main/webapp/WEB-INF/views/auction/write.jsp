<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${combinationDto.combinationWriter}";
</script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<script>
	$(function(){
		var valid={
				titleValid:false,
				lastDayValid:false,
				priceValid:true,
				contentValid:false,
				memberIdValid:memberId.length>0,
				isAllValid:function(){
					return this.titleValid && this.lastDayValid && this.priceValid && this.contentValid && this.memberIdValid
				}
		};
		function checkAllValid(){
			if(valid.isAllValid()){
				$(".submit-btn").attr("type", "submit");
			}
			else {
				$(".submit-btn").attr("type", "button");
			}
		}
		//제목이 입력되었을 때
		$("[name=auctionTitle]").blur(function(){
			$(this).removeClass("invalid valid");
			var text =$(this).val().trim();
			if(text){
				$(this).addClass("valid");
				valid.titleValid=true;
			}
			else{
				$(this).addClass("invalid");
				valid.titleValid=false;
			}
			checkAllValid();
		});
		//내용이 입력되었을 때
		$('[name=auctionContent]').on('summernote.change', function(we, contents, $editable) {
			$(this).removeClass("invalid valid");
			if(contents=="<p><br></p>" || contents=="<br>"){
				$(this).addClass("invalid");
				valid.contentValid=false;
			}
			else{
				$(this).addClass("valid");
				valid.contentValid=true;
			}
			checkAllValid();
		});
		//기간이 선택되었을 때
		$("[name=lastDay]").change(function(){
			$(this).removeClass("valid invalid");
			if($(this).val()!=0){
				$(this).addClass("valid")
				valid.lastDayValid=true;
			}
			else{
				$(this).addClass("invalid")
				valid.lastDayValid=false;
			}
			checkAllValid();
		})
		//최소금액이 입력되었을 때
		$("[name=auctionMinPrice]").blur(function(){
			checkBidPrice();
		});
		//최대금액이 입력되었을 때
		$("[name=auctionMaxPrice]").blur(function(){
			checkBidPrice();
		})
		function checkBidPrice(){
			var min = $("[name=auctionMinPrice]").val();
			var max = $("[name=auctionMaxPrice]").val();
			if(min<0 || max<0){
				valid.priceValid=false;
				alert("0보다 크거나 같은 값을 입력하세요")
			}
			if(max==0){
				valid.priceValid=true;
			}
			else{
				if(min>max){
					valid.priceValid=false;
					alert("최대금액보다 작거나 같은 금액을 입력하세요");
				}
				else{
					valid.priceValid=true;
				}
			}
			checkAllValid();
		}
		//파일 미리보기를 위한 함수
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
		};
		$("[name=attach]").blur(function(){
			previewFile(this);
		});
	});
</script>
<div class="container-1200 mt-50">
<form action="write" method="post" autocomplete="off" enctype="multipart/form-data">
<input type="hidden" name="auctionWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목<input class="form-input w-100" name="auctionTitle">
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<div class="row">
		기간선택 : 
		<select name="lastDay" class="form-input neutral">
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