<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${raidDto.raidWriter}";
</script>
<script type="text/javascript">
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo")
	$(function(){
		loadList();
		
		function loadList(){
			$(".reply-target").empty();
			$.ajax({
				url:"/rest/reply/"+allboardNo,
				method:"get",
				success:function(response){
					for(var i=0; i<response.length; i++){
						var template = $("#reply-template").html();
						var html = $.parseHTML(template);
						$(html).find(".reply-writer").text(response[i].replyWriter);
						$(html).find(".reply-content").text(response[i].replyContent);
						$(html).find(".reply-time").text(response[i].replyTime);
						
						if(boardWriter==response[i].replyWriter){
							var span = $("<span>").text("(글쓴이)").addClass("ms-10");
							$(html).find(".reply-writer").append(span);
						}
						if(memberId==response[i].replyWriter){
							var deletebtn = $("<i>").addClass("fa-solid fa-trash ms-10")
									.attr("data-reply-no", response[i].replyNo).click(deleteReply);
							var editbtn = $("<i>").addClass("fa-solid fa-edit ms-10")
									.attr("data-reply-no", response[i].replyNo)
									.attr("data-reply-content", response[i].replyContent).click(editReply);
							$(html).find(".reply-writer").append(editbtn).append(deletebtn);
						}
						$(".reply-target").append(html);
					}
				},
				error:function(){
					alert("리스트 통신오류");
				},
			});
			
		};
		function editReply(){
			var template = $("#reply-edit-template").html();
			var html = $.parseHTML(template);
			$(html).find(".reply-edit-content").val($(this).data("reply-content"));
			$(this).parents(".reply-box").hide().after(html);
			var replyNo = $(this).data("reply-no");
			$(".confirm-edit").click(function(){
				if(confirm("수정하시겠습니까?")){
					var newContent = $(".reply-edit-content").val();
					$.ajax({
						url:"/rest/reply/",
						method:"put",
						data:{
							replyNo:replyNo,
							replyContent:newContent,
						},
						success:function(){
							$(".reply-edit-content").val("");
							loadList();
						},
						error:function(){
							alert("통신오류")
						},
					})									
				}
			});
			$(".cancle-edit").click(function(){
				$(".reply-edit-content").val("");
				loadList();
			});
		};
		function deleteReply(){
			var isDelete = confirm("삭제하시겠습니까?")
			if(isDelete){
				var replyNo = $(this).data("reply-no");
				$.ajax({
					url:"/rest/reply/"+replyNo,
					method:"delete",
					success:function(){
						loadList();
					},
					error:function(){
						alert("통신오류")
						loadList();
					},
				})					
			}
		};
		
		$(".reply-submit").click(function(){
			var content = $(".reply-textarea").val();
			if(content.trim().length==0) return;
			$.ajax({
				url:"/rest/reply/",
				method:"post",
				data:{
					replyWriter:memberId,
					replyOrigin:allboardNo,
					replyContent:content,
					replyGroup:'0',
				},
				success:function(response){
					loadList();
					$(".reply-textarea").val("");
				},
				error:function(){
					alert("통신오류")
				},
			});
		});
	});
</script>
<script type="text/template" id="reply-template">
	<div class="row reply-box">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content form-input"></div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row">
		<textarea class="row reply-edit-content form-input w-100">수정</textarea>
	</div>
	<div class="row right">
		<button class="form-btn neutral confirm-edit">수정</button>
		<button class="form-btn neutral cancle-edit">취소</button>
	</div>
</script>
<script type="text/javascript">
	$(function(){
		var params = new URLSearchParams(location.search);
		var allboardNo = params.get("allboardNo");
		$.ajax({
			url:"/rest/like/check",
			method:"post",
			data:{
				allboardNo:allboardNo,
				memberId:memberId,
			},
			success:function(response){
				if(response==true){
					$(".fa-heart").removeClass("fa-regular").addClass("fa-solid");
				}
			},
			error:function(){
				alert("통신에러");
			}
		});			
		
		$(".fa-heart").click(function(){
			$.ajax({
				url:"/rest/like/",
				method:"post",
				data:{
					allboardNo:allboardNo,
					memberId:memberId,
				},
				success:function(response){
					if(response==true){
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					else{
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
				},
				error:function(){
					alert("통신에러");
				}
			});
		});
	});
</script>
<div class="container-800 mt-50">
	<div class="row">
	제목 : [${raidDto.raidMonster}]${raidDto.raidTitle}
	</div>
	<div class="row">
		글쓴이 : ${raidDto.raidWriter}
	</div>
	<div class="row">
		타입 : ${raidDto.raidType}
	</div>
	<div class="row">
		참가자 : ${count}/4
	</div>
	<div class="row">
		<div class="float-box">
			<div class="left">내용</div>
	<!-- 좋아요 -->
			<div class="right user-like"><i class="fa-regular fa-heart"></i></div>
		</div>
		<div class="row form-input w-100" style="min-height:150px">
		${raidDto.raidContent}
		</div>
	</div>

<!-- 레이드 참가 신청 -->
	<div class="row">
		<form action="join" method="post">
			<input type="hidden" name="raidJoinRaid" value="${raidDto.allboardNo}">
			<input type="hidden" name="raidJoinParticipant" value="${sessionScope.memberId}">
			<input type="hidden" name="raidJoinConfirm" value="${raidDto.raidType}">
			<input type="hidden" name="allboardNo" value="${raidDto.allboardNo}">
			<input class="form-input w-100" name="raidJoinContent">
			<button class="form-bnt neutral">참가</button>
		</form>
		<hr>
	</div>
<!-- 레이드 참가 신청 끝 -->
<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
	<hr>
		<textarea class="form-input w-100 reply-textarea"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<a href="list?page=${param.page}" class="form-btn neutral">목록</a>
		<a href="delete?page=${param.page}&allboardNo=${raidDto.allboardNo}" class="form-btn neutral">삭제</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>