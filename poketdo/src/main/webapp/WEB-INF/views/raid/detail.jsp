<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.writer-control-box{
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	padding:1em;
}
.raid-join-control,
.raid-join-control-confirmed{
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	padding:0.5em;
	overflow:auto;
}
.id-box{
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	padding:0.5em;
}
.id-box:hover{
transform: scale(1.01);

}
.raid-control-content,
.raid-control-confirmed-content,
.raid-control-member,
.raid-control-confirmed-member,
.fa-xmark,
.fa-check
{
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
}
.raid-join{
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	padding:1em;
}
</style>
<script>
	/* 전역변수 설정 */
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${raidDto.raidWriter}";
</script>
<!-- 댓글창 summernote 사용을 위한 import -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/reply.js"></script>
<script>
$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo");
	//작성자일 경우 참가신청 숨기고 관리창 노출
	if(memberId==boardWriter) {
		$(".raid-join").hide();
		$(".writer-control-box").show();
		joinerList();
	}
	else {
		$(".raid-join").show();
		$(".writer-control-box").hide();
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
		if(isFinished()){
			alert("모집 종료된 레이드입니다");
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
		if(isFinished()){
			alert("모집 종료된 레이드입니다");
			return;
		}
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
							$(".raid-join-status").text("수락됨 친구코드 : "+response.raidCode);
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
					$(html).find(".raid-control-member").text(response[i].memberNick)
						.prepend($("<img>").addClass("board-seal").attr("src", response[i].urlLink));
					$(html).find(".raid-control-content").text(response[i].raidJoinContent).attr("title", response[i].raidJoinContent);
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
					$(html).find(".raid-control-confirmed-member").text(response[i].memberNick)
						.prepend($("<img>").addClass("board-seal").attr("src", response[i].urlLink));
					$(html).find(".raid-control-confirmed-content").text(response[i].raidJoinContent).attr("title", response[i].raidJoinContent);
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
		if(parseInt(count)>=4){
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
		if(isFinished()){
			$(".ing-raid").hide();
			$(".finished-raid").show();
		}
		else{
			$(".ing-raid").show();
			$(".finished-raid").hide();
		}
	}
	function isFinished(){
		var time = $(".raid-start-time").text();
		console.log(time);
		var participant = $(".participant-count").text();
		return time.trim()=="종료" || parseInt(participant)>=4;
	}
	//삭제버튼 누를 시 확인창
	
	$(".delete-btn").click(function(event){
		if(!confirm("정말 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
			event.preventDefault();
			return;
		}
		else{
			window.location.href=$(this).attr("href");
		}
	})	
});
</script>
<!-- 댓글창 템플릿 -->
<script type="text/template" id="reply-template">
	<div class="row reply-box flex-box">
		<div class="remove-box" style="width:5%">
			<div class="align-center center" style="padding-top:1em">
				<i class="fa-solid fa-reply fa-flip-both" style="font-size:16px"></i>
			</div>
		</div>
		<div class="align-right remain-box" style="width:95%">
			<div class="row flex-box" style="align-items:center">
				<div class="reply-writer"></div>
				<div class="reply-time ms-20" style="font-size:14px"></div>
				<div class="align-right reply-option me-20"></div>
				<div class="left reply-like-box">
					<i class="fa-heart reply-like"></i>
					<span class="reply-like-count"></span>
				</div>
			</div>
			<div class="row reply-content" style="padding-left:1em"></div>
		</div>
	</div>
</script>
<script type="text/template" id="reply-edit-template">
	<div class="row reply-edit">
		<textarea class="row reply-edit-content form-input w-100 summernote-reply-edit"></textarea>
	</div>
</script>
<script type="text/template" id="reply-child-template">
	<div class="row reply-child">
		<textarea class="form-input w-100 summernote-reply-child reply-textarea"></textarea>
	</div>
</script>
<!-- 레이드 신청 컨트롤 템플릿 -->
<script type="text/template" id="raid-control-template">
	<div class="row id-box">
		<span class="raid-control-member w-30" style="display:inline-block"></span>
		<span class="raid-control-content" style="display:inline-block; height:24px; width:57%"></span>
		<i class="fa-solid fa-check fa-check-control" style="color:green"></i>
		<i class="fa-solid fa-xmark fa-xmark-control ms-10" style="color:red"></i>
	</div>
</script>
<!-- 레이드 확정창 템플릿 -->
<script type="text/template" id="raid-control-confirmed-template">
	<div class="row id-box">
		<span class="raid-control-confirmed-member w-30" style="display:inline-block"></span>
		<span class="raid-control-confirmed-content" style="display:inline-block; height:24px; width:60%"></span>
		<i class="fa-solid fa-xmark ms-10 fa-xmark-ban ms-10" style="color:red"></i>
	</div>
</script>
<script src="/static/js/like.js"></script>
<div class="container-1000 mt-50">
	<div class="row flex-box">
		<span class="board-detail-origin">공략 게시판</span>
		<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="board-detail-btn align-right">목록</a>
	</div>
	<div class="row board-detail-title">
		[${raidDto.raidMonster}] ${raidDto.raidTitle}
			<c:choose>
				<c:when test="${raidDto.raidType==0}">
					(모집)
				</c:when>
				<c:otherwise>
					(선착순)
				</c:otherwise>
			</c:choose>
	</div>
	<div class="row flex-box">
		<div class="row">
			<span class="raid-writer">
			<!-- 작성자 검색 링크 -->
				<a href="list?page=1&column=member_nick&keyword=${raidDto.memberNick}" class="link" style="vertical-align:middle">
					<img class="board-seal" src="${raidDto.urlLink}" style="vertical-align:middle"><span style="vertical-align:middle">${raidDto.memberNick}</span>
				</a>
			</span>
			<span class="board-detail-time" style="vertical-align:middle">${raidDto.boardTime}</span>
			<!-- 작성자와 memberId가 같으면 수정, 삭제 버튼 생김 -->
			<c:if test="${sessionScope.memberId==raidDto.raidWriter}">
				<a href="edit?page=${param.page}&allboardNo=${raidDto.allboardNo}" class="board-detail-btn" style="vertical-align:middle">수정</a>
				<a href="delete?page=${param.page}&allboardNo=${raidDto.allboardNo}" class="board-detail-btn" style="vertical-align:middle">삭제</a>
			</c:if>
		</div>
		<div class="row align-right">
			조회수 : ${raidDto.raidRead}
		</div>
	</div>
<!-- 본문 시작 -->
	<div class="row" style="border-top:3px solid #f2f4fb; border-bottom: 3px solid #f2f4fb">
	<!-- 진행/모집 종료된 레이드 -->
		<div class="row ing-raid flex-box">
			<div class="row reply-number-box" style="display:inline-block; padding:0.3em">
				참가자 : <span class="participant-count">${raidDto.raidCount}</span>/4
			</div>
			<div class="row reply-number-box" style="display:inline-block; padding:0.3em">
				시작시간 : <span class="raid-start-time">${raidDto.time}</span>
			</div>
		</div>
		<div class="row finished-raid reply-number-box" style="display:inline-block;padding:0.3em">
			모집 종료
		</div>
		<!-- 본문 -->
		<div class="row w-100 do-not-over" style="min-height:400px; padding-left:1em; padding-right:1em">${raidDto.raidContent}</div>
		<div class="row">
			<a href="list?page=1&column=member_nick&keyword=${raidDto.memberNick}" class="link">${raidDto.memberNick}님의 게시글 더 보기</a>
		</div>
		<div class="row">
		<!-- 좋아요 -->
			<div class="left like-box" style="display:inline-block">
				<i class="fa-heart detail-like"></i>
				좋아요 :<span class="like-count" style="margin-left:0.5em">${raidDto.raidLike}</span>
			</div>
		<!-- 댓글 개수 댓글 span(class=reply-count)에 카운트 처리되도록 함-->
			<div class="reply-number-box" style="display:inline-block">
				댓글 :<span class="reply-count" style="margin-left:0.5em">${raidDto.raidReply}</span>
			</div>
		</div>
	</div>
<!-- 본문 끝 -->
<!-- 레이드 참가 신청 -->
	<div class="row raid-join mt-30 w-50">
		<span class="raid-join-status" style="margin-bottom:10px" ></span>
		<form class="raid-join-form">
			<input type="hidden" name="raidJoinOrigin" value="${raidDto.allboardNo}">
			<input type="hidden" name="raidJoinMember" value="${sessionScope.memberId}">
			<input type="hidden" name="raidJoinConfirm" value="${raidDto.raidType}">
			<input class="form-input w-100" name="raidJoinContent" placeholder="소개메세지(포켓몬, lv)">
			<button type="button" class="form-btn neutral raid-join-btn w-100 mt-10">참가신청</button>
			<div class="flex-box">
				<button type="button" class="form-btn neutral raid-join-cancle-btn mt-10" style="width:48%">신청취소</button>
				<button type="button" class="form-btn neutral raid-join-edit-btn mt-10 align-right" style="width:48%">수정</button>
			</div>
		</form>
	</div>
<!-- 레이드 참가 신청 끝 -->
<!-- 레이드 수락창(글쓴이) -->
	<div class="row flex-box writer-control-box mt-30">
		<div style="width:47%">
			<div class="mb-10 center">대기 인원</div>
			<div class="row raid-join-control" style="height:250px"></div>
		</div>
		<div class="flex-box align-center" style="width:6%">
			<i class="fa-solid fa-arrow-right" style="font-size:20px"></i>
		</div>
		<div style="width:47%">
			<div class="mb-10 center">확정 인원</div>
			<div class="row raid-join-control-confirmed align-right" style="min-height:250px"></div>
		</div>
	</div>
<!-- 레이드 수락창 끝 -->
<!-- 댓글 -->
	<!-- 표시 -->
	<div class="row reply-best-target">
	</div>
	<div class="row reply-target">
	</div>
	<!-- 신청 -->
	<div class="row mt-30">
		<textarea class="form-input w-100 summernote-reply reply-textarea"></textarea>
	</div>
<!-- 댓글 끝 -->
<!-- 마지막 줄 -->
	<div class="row flex-box">
		<div class="row">
			<a href="write" class="board-detail-btn">글쓰기</a>
		</div>
		<div class="row align-right">
			<a href="list?page=${param.page}&${vo.parameter}&${vo.addParameter}" class="board-detail-btn align-right">목록</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>