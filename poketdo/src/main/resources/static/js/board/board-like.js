$(function(){
	$.ajax({
		url:contextPath+"/rest/like/check",
		method:"post",
		data:{
			allboardNo:allboardNo,
			memberId:memberId,
		},
		success:function(response){
			if(response==true){
				$(".detail-like").removeClass("fa-regular fa-solid").addClass("fa-solid").css("color","#FF3040");
			}
			else{
				$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-regular").css("color","#2d3436");
			}
			$.ajax({
				url:contextPath+"/rest/like/count?allboardNo="+allboardNo,
				method:"get",
				success:function(response){
					$(".like-count").text(response);
				}
			});
		},
		error:function(){
			alert("통신에러");
		}
	});			
	
	$(".like-box").click(function(){ 
		$.ajax({
			url:contextPath+"/rest/like/",
			method:"post",
			data:{
				allboardNo:allboardNo,
				memberId:memberId,
			},
			success:function(response){
				if(response==true){
					$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-solid fa-beat").css("color","#FF3040");
					//시간 지나면 fa-beat 제거
					setTimeout(function(){
						$(".detail-like").removeClass("fa-beat")
					}, 700)
				}
				else{
					$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-regular").css("color","#2d3436");
				}
				$.ajax({
					url:contextPath+"/rest/like/count?allboardNo="+allboardNo,
					method:"get",
					success:function(response){
						$(".like-count").text(response);
					}
				});
			},
			error:function(){
				alert("통신에러");
			}
		});
	});
});