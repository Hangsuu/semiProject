// [1] 시작하자마자 이글에 좋아요를 했는지 확인.
// [2] 하트를 클릭하면 좋아요 설정 해제 페이지로 비동기 요청 (싫어요도 똑같음)
$(function(){

	//Javascript에서 파라미터 읽기
	var params = new URLSearchParams(location.search);
	var boardNo = params.get("boardNo");
	
	//[1]
	$.ajax({
		url:"/rest/board/check",
		method:"post",
		data:{
			boardNo : boardNo
		},
		success:function(response){
			//console.log(response);
			//console.log(typeof response);
			if(response) {
				$(".fa-heart").addClass("fa-solid");
			}
			else {
				$(".fa-heart").addClass("fa-regular");
			}
		},
		error:function(){
			$(".fa-heart").remove();
		}
	});
	
	//[2]
	$(".fa-heart").click(function(){
		$.ajax({
			url:"/rest/board/like",
			method:"post",
			data:{
				boardNo:boardNo
			},
			success:function(response){
				//response에는 result와 count가 들어있다
				if(response.result) {//좋아요 된것
					$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-solid fa-shake");
					//1초뒤에 .fa-shake를 제거(setTimeout 함수)
					//- setTimeout(함수, 시간); 지정한 시간 이후에 함수 실행
					//- setInterval(함수, 시간); 지정한 시간 간격으로 함수 실행
					setTimeout(function(){
						$(".fa-heart").removeClass("fa-shake");
					}, 800);
				
					$(".heart-count").text(response.count);
				}
				else {//좋아요 풀린것
					$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-regular");
					$(".heart-count").text(response.count);
				}
			},
			error:function(){}
		});
	});
	
	//[3] mouseenter/mouseleave
	$(".fa-heart").mouseenter(function(){
		$(this).addClass("fa-beat");
	})
	.mouseleave(function(){
		$(this).removeClass("fa-beat");
	});
	
});