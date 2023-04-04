<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${combinationDto.combinationWriter}";
</script>
<script>
//-------------------전송할 수 있는 상태인지 판단-------------------------
	$(function(){
		var valid={
				titleValid:true,
				contentValid:true,
				isAllValid:function(){
					return this.titleValid && this.contentValid
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
		$("[name=combinationTitle]").blur(function(){
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
		$('[name=combinationContent]').on('summernote.change', function(we, contents, $editable) {
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
//-------------------------------태그기능 -------------------------------------		
		//초기 상태 구현
		var params = new URLSearchParams(location.search);
		var paramTagList = params.get("tagList");
		var tagList = new Set();
		var list = [];
		var preValue = $(".tag-input").val();

		//파라미터에 tagList를 달고 왔을 시
		if(paramTagList.length>0){
			var arr = paramTagList.split(",");
			$.each(arr, function(index, value){
				tagList.add(value);
			});
			selectedTag();
		}
		else{
		}
		
		//색깔
		var tagColor = ["#F6FAFD", "#FFE5E5", "#FCF8E2", "#E4FBEB", "#E5EEFF"];
		var tagBorderColor = ["2px solid #D2EAF8", "2px solid #FFC6C6", "2px solid #FAF1C6", "2px solid #BBF5CE", "2px solid #DBE7FF"];
		
		$(".tag-input").on("input", function(){
			var text = $(this).val();
			if(preValue!=text){
				var regex = /^#(.*?)#/;
				var list = text.match(regex);
				
				if(list!=null && list.length!=0){
					var textVal = list[1];
					textVal = textVal.trim();
					if(!tagList.has(textVal)&&textVal){
						tagList.add(textVal);
						//set을 전송 가능한 문자열 형태로 반환
						var setList = Array.from(tagList);
						var setListString = setList.join(",");
						$("[name=tagList]").val(setListString);
		
						list.length=0;
						$(this).val("#");
						var target = $(".tag-box")
						var index = Math.floor(Math.random()*5);
						var inputTag = $("<span>").addClass("hash-tag").css("background-color", tagColor[index]).css("border", tagBorderColor[index]).text(textVal);
						var xmark = $("<i>").addClass("fa-solid fa-xmark ms-10").attr("data-tag-value", textVal).click(deleteTag)
						inputTag.append(xmark);
						target.append(inputTag);
					}
					else{
						list.length=0;
						$(this).val("#");
					}
				}
			}
			preValue = text;
		})
		$(".tag-input").change(function(){
			var text = $(this).val();
			text = text.replace("#", "");
			text = text.trim();
			if(text.length>0 && preValue!=text){
				if(!tagList.has(text)){
					tagList.add(text);
					//set을 전송 가능한 문자열 형태로 반환
					var setList = Array.from(tagList);
					var setListString = setList.join(",");
					$("[name=tagList]").val(setListString);
		
					$(this).val("#");
					var target = $(".tag-box")
					var index = Math.floor(Math.random()*5);
					var inputTag = $("<span>").addClass("hash-tag").css("background-color", tagColor[index]).css("border", tagBorderColor[index]).text(text);
					var xmark = $("<i>").addClass("fa-solid fa-xmark ms-10").attr("data-tag-value", text).click(deleteTag)
					inputTag.append(xmark);
					target.append(inputTag);
				}
			}
			preValue = text;
		})
		function deleteTag(){
			tagList.delete($(this).data("tag-value"));
			//set을 전송 가능한 문자열 형태로 반환
			var setList = Array.from(tagList);
			var setListString = setList.join(",");
			$("[name=tagList]").val(setListString);
			$(this).parent().remove();
		};
		
		//선택된 태그 창 생성
		function selectedTag(){
			$(".tag-box").empty();
			tagList.forEach(function(value){
				var selectedTag = $("<span>").addClass("form-input hash-tag").text(value).css("margin",0)
				var cancle = $("<i>").addClass("fa-solid fa-xmark").attr("data-tag-name", value)
						.click(deleteTag);
				selectedTag.append(cancle);
				$(".tag-box").append(selectedTag);
			});
		}
	});
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/summernote.js"></script>
<div class="container-900 mt-50">
<form action="edit" method="post" autocomplete="off" enctype="multipart/form-data">
	<input type="hidden" name="allboardNo" value="${combinationDto.allboardNo}">
	<input type="hidden" name="tagList">
	
	<div class="row">
		<select class="form-input neutral center" name="combinationType" style="width:100px">
			<option>일반</option>
			<option>몬스터</option>
			<option>필드</option>
			<option>체육관</option>
			<option>기타</option>
		</select>
	<!-- 태그 입력 박스 -->
		<input class="form-input w-20 tag-input" value="#" placeholder="#태그 입력">
	</div>
	<div class="row">
		<input class="form-input center neutral" readonly value="제목" style="width:100px"><input class="form-input" name="combinationTitle" value="${combinationDto.combinationTitle}" style="width:88%">
	</div>
<!-- 선택한 태그 들어가는 자리 -->
		<div class="tag-box" style="display:inline-block"></div>
	<div class="row">
		<textarea class="row form-input w-100 summernote" style="min-height:200px" name="combinationContent">${combinationDto.combinationContent}</textarea>
	</div>
	<button class="form-btn neutral submit-btn w-20"><i class="fa-solid fa-pen-to-square me-10"></i>수정</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>