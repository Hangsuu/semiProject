$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo")
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