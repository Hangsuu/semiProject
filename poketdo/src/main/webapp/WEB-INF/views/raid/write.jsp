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
				contentValid:false,
				monsterValid:false,
				codeValid:false,
				timeValid:false,
				memberIdValid:memberId.length>0,
				isAllValid:function(){
					return this.codeValid && this.titleValid && this.contentValid && this.monsterValid && this.timeValid && this.memberIdValid
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
		$("[name=raidTitle]").blur(function(){
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
		$('[name=raidContent]').on('summernote.change', function(we, contents, $editable) {
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
		//몬스터 이름이 입력되었을 때
		$("[name=raidMonster]").blur(function(){
			$(this).removeClass("invalid valid");
			var text =$(this).val().trim();
			if(text){
				$(this).addClass("valid");
				valid.monsterValid=true;
			}
			else{
				$(this).addClass("invalid");
				valid.monsterValid=false;
			}
			checkAllValid();
		})
		//코드 입력되었을 때
		$("[name=raidCode]").blur(function(){
			$(this).removeClass("invalid valid");
			var text =$(this).val().trim();
			if(text){
				$(this).addClass("valid");
				valid.codeValid=true;
			}
			else{
				$(this).addClass("invalid");
				valid.codeValid=false;
			}
			checkAllValid();
		});
		
		//시간 입력 처리
		$(".set-date").blur(function(){
			var correctTime = $(".set-date").val();
			if(correctTime){
				$("[name=raidStartTime]").val(correctTime.replace("T", " ")+":00.000");
			}
			valid.timeValid=correctTime;
			checkAllValid();
		});
	});
</script>
<div class="container-1200 mt-50">
<form action="write" method="post" autocomplete="off">
<input type="hidden" name="raidWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목 : <input class="form-input" name="raidTitle">
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<div class="row">
		몬스터 : <input class="form-input" name="raidMonster">
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<div class="row">
		날짜 : <input class="form-input set-date" type="datetime-local">
		<div class="invalid-message">필수 입력 항목입니다</div>
		<input type="hidden" name="raidStartTime">
	</div>
	<div class="row">
		레이드타입 : <select class="form-input" name="raidType">
			<option value='0'>모집</option>
			<option value='1'>선착순</option>
		</select>
	</div>
	<div class="row">
		레이드코드 : <input class="form-input" name="raidCode">
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<div class="row w-100">
		<textarea name="raidContent" rows="10" class="form-input w-100 summernote"></textarea>
		<div class="invalid-message">필수 입력 항목입니다</div>
	</div>
	<button class="form-btn neutral submit-btn">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>