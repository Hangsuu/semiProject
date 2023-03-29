<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${raidDto.raidWriter}";
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="row reply-box">
		<div class="row reply-writer"></div>
		<div class="row reply-time"></div>
		<div class="row reply-content form-input"></div>
	</div>
</script>
<script>
$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo");
	var participantCount = $(".participant-count");
	//작성자일 경우 참가신청 숨기고 관리창 노출
	if(memberId==boardWriter) {
		$(".raid-join").hide();
		$(".raid-join-control").show();
		joinerList();
	}
	else {
		$(".raid-join").show();
		$(".raid-join-control").hide();
	}
	
	//참가 신청자는 취소버튼, 미신청자는 참가 버튼 노출
	isJoiner();
	finishedRaid();
	
	//참가버튼 누를 시
	$(".raid-join-btn").click(function(){
		if(memberId==boardWriter){
			alert("작성자는 참가신청을 할 수 없습니다.");
			return;
		}
		if(!memberId){
			alert("로그인 후 이용하세요.");
			return;
		}
		var data = $(".raid-join-form").serialize();
		$.ajax({
			url:"/rest/raid/join",
			method:"post",
			data:data,
			success:function(response){
				isJoiner();
				$(".participant-count").text(response[0]);
				finishedRaid();
			},
			error:function(){
				alert("통신오류");
			}
		});			
	});
	//참가 취소 버튼 누를 시
	$(".raid-join-cancle-btn").click(function(){
		if(confirm("신청 취소하시겠습니까?")){
			$.ajax({
				url:"/rest/raid/"+allboardNo,
				method:"delete",
				success:function(response){
					isJoiner();
					$("[name=raidJoinContent]").val("");
					$(".participant-count").text(response[0]);
					finishedRaid();
				},
				error:function(){
					alert("삭제 안됨")
				},
			});
		}
		else return;
	});
	//수정 버튼 누를 시
	$(".raid-join-edit-btn").click(function(){
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				url:"/rest/raid/",
				method:"put",
				data:{
					raidJoinOrigin:allboardNo,
					raidJoinContent:$("[name=raidJoinContent]").val(),
					raidJoinMember:memberId,
				},
				success:function(){
					alert("참가신청 내용이 수정됐습니다.")
				},
				error:function(){
					alert("수정오류")
				}
			});			
		}
		else{
			return;
		}
	});
	//참가신청 상태인지 판단
	function isJoiner(){
		if(memberId){
			$.ajax({
				url:"/rest/raid/isjoiner/"+allboardNo,
				method:"get",
				success:function(response){
					if(response.joiner){
						$("[name=raidJoinContent]").val(response.raidJoinContent);
						if(response.confirmed){
							$(".raid-join-status").text("수락됨 친구코드 : ");
						}
						else{
							$(".raid-join-status").text("신청 완료! 수락 대기중");
						}
						joiner();
					}
					else{
						nonJoiner();
						$(".raid-join-status").text("");
					}
				},
				error:function(){
					alert("판단오류");
				},
			});
		}
		else{
			nonJoiner();
		}
	};
	//참가신청자일 경우 노출될 것들을 판단
	function joiner(){
		$(".raid-join-btn").hide();
		$(".raid-join-cancle-btn").show();
		$(".raid-join-edit-btn").show();
		$(".raid-join-status").show();
	}
	//참가신청자가 아닐 경우 노출될 것들을 판단
	function nonJoiner(){
		$(".raid-join-btn").show().val("");
		$(".raid-join-cancle-btn").hide();
		$(".raid-join-edit-btn").hide();
		$(".raid-join-status").hide();
	}
	//작성자가 참가자 정보를 보기 위한 함수
	function joinerList(){
		$(".raid-join-control").empty();
		$(".raid-join-control-confirmed").empty();
		//참가신청 신청자 창
		$.ajax({
			url:"/rest/raid/"+allboardNo,
			method:"get",
			success:function(response){
				for(var i=0; i<response.length; i++){					
					var template = $("#raid-control-template").html();
					var html = $.parseHTML(template);
					$(html).find(".raid-control-member").text(response[i].raidJoinMember);
					$(html).find(".raid-control-content").text(response[i].raidJoinContent);
					$(html).find(".fa-check-control").attr("data-join-member", response[i].raidJoinMember).click(controlConfirm);
					$(html).find(".fa-xmark-control").attr("data-join-member", response[i].raidJoinMember).click(controlRefuse);
					$(".raid-join-control").append(html);
				}
			},
			error:function(){
				alert("불러오기 오류");
			},
		});
		//신청 확정된 유저 창
		$.ajax({
			url:"/rest/raid/confirmed/"+allboardNo,
			method:"get",
			success:function(response){
				for(var i=0; i<response.length; i++){					
					var template = $("#raid-control-confirmed-template").html();
					var html = $.parseHTML(template);
					$(html).find(".raid-control-confirmed-member").text(response[i].raidJoinMember);
					$(html).find(".fa-xmark-ban").attr("data-join-member", response[i].raidJoinMember).click(controlBan);
					$(".raid-join-control-confirmed").append(html);
				}
			},
			error:function(){
				alert("불러오기 오류");
			},
		});
	}
	//신청 수락 했을 때의 함수
	function controlConfirm(){
		var count = $(".participant-count").text()
		if(count>=4){
			alert("최대 인원을 초과했습니다");
			return;
		}
		var raidJoinMember = $(this).data("join-member");
		$.ajax({
			url:"/rest/raid/confirm",
			method:"post",
			data:{
				raidJoinMember:raidJoinMember,
				raidJoinOrigin:allboardNo,
			},
			success:function(response){
				joinerList();
				$(".participant-count").text(response[0]);
				finishedRaid();
			},
			error:function(){
				alert("확정 실패")
			}
		});
	}
	//신청 거절 했을 때의 함수
	function controlRefuse(){
		var raidJoinMember = $(this).data("join-member");
		$.ajax({
			url:"/rest/raid/refuse",
			method:"post",
			data:{
				raidJoinMember:raidJoinMember,
				raidJoinOrigin:allboardNo,
			},
			success:function(response){
				joinerList();
				$(".participant-count").text(response[0]);
				finishedRaid();
			},
			error:function(){
				alert("거절 실패")
			}
		});
	}
	//확정된 참가자를 밴 했을 때의 함수
	function controlBan(){
		var raidJoinMember = $(this).data("join-member");
		$.ajax({
			url:"/rest/raid/ban",
			method:"post",
			data:{
				raidJoinMember:raidJoinMember,
				raidJoinOrigin:allboardNo,
			},
			success:function(response){
				joinerList();
				$(".participant-count").text(response[0]);
				finishedRaid();
			},
			error:function(){
				alert("추방 실패")
			}
		});
	}
	//확정 참가자가 4명이 됐을 때의 함수
	function finishedRaid(){
		var participant = $(".participant-count").text();
		if(participant>=4){
			$(".ing-raid").hide();
			$(".finished-raid").show();
		}
		else{
			$(".ing-raid").show();
			$(".finished-raid").hide();
		}
	}
});
</script>
<!-- 댓글창 템플릿 -->
<script type="text/template" id="reply-edit-template">
	<div class="row">
		<textarea class="row reply-edit-content form-input w-100">수정</textarea>
	</div>
	<div class="row right">
		<button class="form-btn neutral confirm-edit">수정</button>
		<button class="form-btn neutral cancle-edit">취소</button>
	</div>
</script>
<!-- 레이드 신청 컨트롤 템플릿 -->
<script type="text/template" id="raid-control-template">
	<div class="row">
		<span class="raid-control-member w-20" style="display:inline-block"></span>
		<span class="raid-control-content w-50" style="display:inline-block"></span>
		<i class="fa-solid fa-check ms-10 fa-check-control" style="color:green"></i>
		<i class="fa-solid fa-xmark ms-10 fa-xmark-control" style="color:red"></i>
	</div>
</script>
<!-- 레이드 확정창 템플릿 -->
<script type="text/template" id="raid-control-confirmed-template">
	<div class="row">
		<span class="raid-control-confirmed-member w-20" style="display:inline-block"></span>
		<i class="fa-solid fa-xmark ms-10 fa-xmark-ban" style="color:red"></i>
	</div>
</script>
<script src="/static/js/like.js"></script>
<div class="container-1200 mt-50">
	<div class="row">
	제목 : [${raidDto.raidMonster}]${raidDto.raidTitle}
	</div>
	<div class="row">
		타입 : 
		<c:choose>
			<c:when test="${raidDto.raidType==0}">
				모집
			</c:when>
			<c:otherwise>
				선착순
			</c:otherwise>
		</c:choose>
	</div>
	<div class="row ing-raid">
		참가자 : <span class="participant-count">${raidDto.raidCount}</span>/4
	</div>
	<div class="row finished-raid">
		모집 종료
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
	<div class="row raid-join">
		<div class="row">
			<span class="raid-join-status"></span>
		</div>
		<form class="raid-join-form">
			<input type="hidden" name="raidJoinOrigin" value="${raidDto.allboardNo}">
			<input type="hidden" name="raidJoinMember" value="${sessionScope.memberId}">
			<input type="hidden" name="raidJoinConfirm" value="${raidDto.raidType}">
			<input class="form-input w-100" name="raidJoinContent">
			<button type="button" class="form-bnt neutral raid-join-btn">참가</button>
			<button type="button" class="form-bnt neutral raid-join-cancle-btn">취소</button>
			<button type="button" class="form-bnt neutral raid-join-edit-btn">수정</button>
		</form>
		<hr>
	</div>
<!-- 레이드 참가 신청 끝 -->
<!-- 레이드 수락창(글쓴이) -->
	<div class="row raid-join-control">
	</div>
	<div class="row raid-join-control-confirmed">
		<hr>
	</div>
<!-- 레이드 수락창 끝 -->
<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row">
	<hr>
		<textarea class="form-input w-100 summernote-reply"></textarea>
		<div class="row right">
			<button class="form-btn neutral reply-submit">댓글달기</button>
		</div>
	</div>
<!-- 댓글 끝 -->
	<div class="row">
		<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="form-btn neutral">목록</a>
		<c:if test="${sessionScope.memberId==raidDto.raidWriter}">
			<a href="delete?page=${param.page}&allboardNo=${combinationDto.allboardNo}" class="form-btn neutral">삭제</a>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>