// [1] 시작하자마자 이글에 싫어요를 했는지 확인.
// [2] 따봉 반대를 클릭하면 싫어요 설정 해제 페이지로 비동기 요청 (싫어요도 똑같음)
$(function(){
	
	//Javascript에서 파라미터 읽기
	var params = new URLSearchParams(location.search);
	var boardNo = params.get("boardNo");

	//[1]
	$.ajax({
  		url:contextPath+"/rest/board/check2",
  		method:"post",
  		data:{
    		boardNo : boardNo
  		},
  		success:function(response){
    		if(response) {
      			$(".fa-thumbs-down").addClass("fa-solid");
    		}
    		else {
      			$(".fa-thumbs-down").addClass("fa-regular");
    		}
  		},
  		error:function(){
    		$(".fa-thumbs-down").remove();
  		}
	});

	//[2]
	$(".fa-thumbs-down").click(function(){
  		$.ajax({
    		url:contextPath+"/rest/board/dislike",
    		method:"post",
    		data:{
      			boardNo:boardNo
    	},
    	success:function(response){
      		if(response.result) {//싫어요 된것
        		$(".fa-thumbs-down").removeClass("fa-solid fa-regular")
                          			.addClass("fa-solid fa-shake");
        		setTimeout(function(){
          			$(".fa-thumbs-down").removeClass("fa-shake");
        		}, 800);
      
        		$(".bad-count").text(response.count);
      		}
      		else {//싫어요 풀린것
        		$(".fa-thumbs-down").removeClass("fa-solid fa-regular")
                          			.addClass("fa-regular");
        		$(".bad-count").text(response.count);
      			}
    		},
    		error:function(){}
  		});
	});

	//[3] mouseenter/mouseleave
	$(".fa-thumbs-down").mouseenter(function(){
  		$(this).addClass("fa-beat");
	})
	.mouseleave(function(){
  		$(this).removeClass("fa-beat");
	});
});