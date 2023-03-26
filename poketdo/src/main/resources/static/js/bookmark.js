$(function(){
	checkBookmark();
	function checkBookmark(){
		$(".fa-bookmark").each(function(){
			var allboardNo = $(this).data("allboard-no");
			var starBox = $(this);
			$.ajax({
				url:"/rest/bookmark/check",
				method:"post",
				data:{
					allboardNo:allboardNo,
					memberId:memberId,
				},
				success:function(response){
					if(response==true){
						starBox.removeClass("fa-regular").addClass("fa-solid");
					}
					else{
						starBox.removeClass("fa-solid").addClass("fa-regular");
					}
				},
				error:function(){
					alert("통신에러");
				}
			});					
		});		
	}
	
	$(".fa-bookmark").click(function(){ 
		var allboardNo = $(this).data("allboard-no");
		var starBox = $(this);
		var bookmarkType = $(this).data("bookmark-type");
		$.ajax({
			url:"/rest/bookmark/",
			method:"post",
			data:{
				allboardNo:allboardNo,
				memberId:memberId,
				bookmarkType:bookmarkType,
			},
			success:function(response){
				if(response==true){
					starBox.removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					starBox.removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
			},
			error:function(){
				alert("통신에러");
			}
		});
	});
	
});