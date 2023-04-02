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
				$(".detail-like").removeClass("fa-regular fa-solid").addClass("fa-solid").css("color","#FF3040");
			}
			else{
				$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-regular").css("color","#2d3436");
			}
		},
		error:function(){
			alert("통신에러");
		}
	});			
	
	$(".like-box").click(function(){ 
		$.ajax({
			url:"/rest/like/",
			method:"post",
			data:{
				allboardNo:allboardNo,
				memberId:memberId,
			},
			success:function(response){
				if(response==true){
					$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-solid").css("color","#FF3040");
				}
				else{
					$(".detail-like").removeClass("fa-solid fa-regular").addClass("fa-regular").css("color","#2d3436");
				}
				$.ajax({
					url:"/rest/like/count?allboardNo="+allboardNo,
					method:"get",
					success:function(response){
						if(response!=0){
							$(".like-count").text(response);
						}
						else{
							$(".like-count").text("");
						}
					}
				});
			},
			error:function(){
				alert("통신에러");
			}
		});
	});
});