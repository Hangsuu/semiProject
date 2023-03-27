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