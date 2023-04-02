/*전역변수(memberId, boardWriter) 설정 필요*/
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
				for(var i=0; i<response.replyDto.length; i++){
					var template = $("#reply-template").html();
					var html = $.parseHTML(template);
					var text = response.replyDto[i].replyContent;
					$(html).find(".reply-writer").text(response.replyDto[i].replyWriter);
					$(html).find(".reply-content").html(text);
					$(html).find(".reply-time").text(response.replyDto[i].replyTime);
					
					if(boardWriter==response.replyDto[i].replyWriter){
						var span = $("<span>").text("(글쓴이)").addClass("ms-10");
						$(html).find(".reply-writer").append(span);
					}
					if(memberId==response.replyDto[i].replyWriter){
						var deletebtn = $("<i>").addClass("fa-solid fa-trash ms-10")
								.attr("data-reply-no", response.replyDto[i].replyNo).click(deleteReply);
						var editbtn = $("<i>").addClass("fa-solid fa-edit ms-10")
								.attr("data-reply-no", response.replyDto[i].replyNo)
								.attr("data-reply-content", response.replyDto[i].replyContent).click(editReply);
						$(html).find(".reply-writer").append(editbtn).append(deletebtn);
					}
					//답글달기 버튼
					if(memberId!=null && response.replyDto[i].replyGroup==0){
						$(html).find(".remove-box").remove();
						$(html).find(".remain-box").removeClass("float-right").css("width","100%")
						var childbtn = $("<i>").addClass("fa-solid fa-reply ms-10")
								.attr("data-reply-parent", response.replyDto[i].replyNo).click(childReply);
						$(html).find(".reply-writer").append(childbtn);
					}
					//좋아요 버튼
					if(response.likeCount[i]==0){
						$(html).find(".reply-like").attr("data-reply-no", response.replyDto[i].replyNo).addClass("fa-regular").css("color","#2d3436");
						$(html).find(".reply-like-box").click(replyLike);
					}
					else{
						$(html).find(".reply-like").attr("data-reply-no", response.replyDto[i].replyNo).addClass("fa-solid").css("color","#FF3040");
						$(html).find(".reply-like-box").click(replyLike);
					}
					//좋아요 개수 카운트
					if(response.replyDto[i].replyLike!=0){
						$(html).find(".reply-like-count").text(response.replyDto[i].replyLike);
					}
					$(".reply-target").append(html);
				}
			},
			error:function(){
				alert("리스트 통신오류");
			},
		});
		
	};
	//댓글에 수정 버튼 누르면 들어가는 함수
	function editReply(){
		$(" .reply-box").show();
		$(" .reply-edit").remove();
		$(" .reply-child").remove();
		var template = $("#reply-edit-template").html();
		var html = $.parseHTML(template);
		var text = $(this).data("reply-content");
		var replyNo = $(this).data("reply-no");
		$(html).find(".reply-edit-content").val(text);
		var span = $("<span>").addClass("data-target").attr("data-reply-no", replyNo);
		$(html).append(span);
		$(this).parents(".reply-box").hide().after(html);
		editSummernote();
	};
	//댓글에 삭제 버튼 누르면 들어가는 함수
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
	//댓글에 대댓글 버튼 클릭 시 들어가는 함수
	function childReply(){
		$(" .reply-box").show();
		$(" .reply-edit").remove();
		$(" .reply-child").remove();
		var parentNo = $(this).data("reply-parent");
		var template = $("#reply-child-template").html();
		var html = $.parseHTML(template);
		var span = $("<span>").addClass("data-target").attr("data-reply-parent", parentNo);
		$(html).append(span);
		$(this).parents(".reply-box").after(html);
		childSummernote();
	}
	
/*-------------------------댓글에 좋아요---------------------------------*/
	function replyLike(){
		if(!memberId.length>0){
			alert("로그인 후 이용하세요");
			return;
		}
		var thisLike = $(this).children(".reply-like");
		var replyNo = $(this).children(".reply-like").data("reply-no");
		$.ajax({
			url:"/rest/reply/like/",
			method:"post",
			data:{
				replyNo:replyNo,
				memberId:memberId,
			},
			success:function(response){
				if(response==true){
					thisLike.removeClass("fa-solid fa-regular").addClass("fa-solid").css("color","#FF3040");
				}
				else{
					thisLike.removeClass("fa-solid fa-regular").addClass("fa-regular").css("color","#2d3436");
				}
				$.ajax({
					url:"/rest/reply/like/count?replyNo="+replyNo,
					method:"get",
					success:function(response){
						if(response==0){
							thisLike.next(".reply-like-count").text("");
						}
						else{
							thisLike.next(".reply-like-count").text(response);
						}
					},
				});
			},
			error:function(){
				alert("통신에러");
			}
		});
	}
/*---------------------------댓글에 좋아요 끝------------------------------*/

/*----------------------summernote-------------------------*/
//작성버튼 생성	
var submitButton = function (context) {
  var ui = $.summernote.ui;
  var button = ui.button({
    contents: $("<button>").addClass("reply-btn").text("댓글등록"),
    click: function () {
		if(!memberId){
			alert("로그인 후 이용하세요");
			return;
		}
		var content = $(this).parent().parent().parent().parent().children(".reply-textarea").val();
		if(content.trim().length==0) return;
		var replyGroup=0;
		if($(this).parent().parent().parent().parent().children(".data-target").data("reply-parent")!=undefined){
			replyGroup=$(this).parent().parent().parent().parent().children(".data-target").data("reply-parent");
		}
		$.ajax({
			url:"/rest/reply/",
			method:"post",
			data:{
				replyWriter:memberId,
				replyOrigin:allboardNo,
				replyContent:content,
				replyGroup:replyGroup,
			},
			success:function(response){
				$(".summernote-reply").summernote("code", "");
				loadList();
			},
			error:function(){
				alert("통신오류")
			},
		});
    }
  });
  return button.render();   // return button as jquery object
}
//수정버튼 생성	
var editButton = function (context) {
  var ui = $.summernote.ui;
  var button = ui.button({
    contents: $("<button>").addClass("reply-btn").text("수정"),
    click: function () {
		var newContent = $(this).parent().parent().parent().parent().children(".summernote-reply-edit").val();
		var replyNo=$(this).parent().parent().parent().parent().children(".data-target").data("reply-no");
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				url:"/rest/reply/",
				method:"put",
				data:{
					replyNo:replyNo,
					replyContent:newContent,
				},
				success:function(){
					$(".summernote-reply").summernote("code", "");
					loadList();
				},
				error:function(){
					alert("통신오류")
				},
			})									
		}
    }
  });
  return button.render();   // return button as jquery object
}
//취소버튼 생성	
var cancleButton = function (context) {
  var ui = $.summernote.ui;
  var button = ui.button({
    contents: $("<button>").addClass("reply-btn").text("취소"),
    click: function () {
		$(this).parent().parent().parent().parent().children(".summernote-reply-edit").summernote("code", "");
		$(this).parent().parent().parent().parent().prev().show();
		$(this).parent().parent().parent().parent().remove();
    }
  });
  return button.render();   // return button as jquery object
}
/*----------------------summernote 호출 함수-------------------------*/

summernote();
//댓글 작성 summernote
function summernote(){	
	$(".summernote-reply").summernote({
	  disableResizeEditor: true,
	  toolbarPosition:'bottom',
	  placeholder: "댓글 작성",
	  //탭키를 누르면 띄어쓰기 몇 번 할지(통상적으로 4 씀)
	  tabsize: 4,
	  //최초 표시될 높이(px)
	  height: 100,
	  //메뉴 설정
	  toolbar: [
        ["color", ["color"]],
		["insert", ["picture"]],
	    ['mybutton', ['submit']],
	  ],
	
	  buttons: {
	    submit: submitButton
	  },
	  callbacks: {
	    onImageUpload: function(files) {
	      //[1]FormData [2]processData [3]contentType
	      if(files.length!=1) return;
	      var fd = new FormData();
	      fd.append("attach", files[0]);//파일이 한개밖에 없어서 [0]
	      $.ajax({
	    	 url:"/rest/attachment/upload",
	    	 method:"post",
	    	 data:fd,
	    	 processData:false,
	    	 contentType:false,
	    	 success:function(response){
	    		//서버로 전송할 이미지 번호 정보 생성
	    		var input = $("<input>").attr("type","hidden").attr("name","attachmentNo").val(response.attachmentNo);
	    		$("form").prepend(input);
	    		//에디터에 추가할 이미지 생성
	     		var imgNode=$("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
	     		$(".summernote-reply").summernote('insertNode', imgNode.get(0));
	    	 },
	    	 error:function(){},
	      });
	    }
	  }
	});
}
//댓글 수정 summernote
function editSummernote(){	
	$(" .summernote-reply-edit").summernote({
	  disableResizeEditor: true,
	  toolbarPosition:'bottom',
	  placeholder: "수정내용 입력",
	  //탭키를 누르면 띄어쓰기 몇 번 할지(통상적으로 4 씀)
	  tabsize: 4,
	  //최초 표시될 높이(px)
	  height: 100,
	  //메뉴 설정
	  toolbar: [
        ["color", ["color"]],
		["insert", ["picture"]],
	    ["mybutton", ["edit", "cancle"]],
	  ],
	
	  buttons: {
		submit: submitButton,
	    edit: editButton,
	    cancle: cancleButton,
	  },
	  callbacks: {
  	    onImageUpload: function(files) {
  	      //[1]FormData [2]processData [3]contentType
  	      if(files.length!=1) return;
  	      var fd = new FormData();
  	      fd.append("attach", files[0]);//파일이 한개밖에 없어서 [0]
  	      $.ajax({
  	    	 url:"/rest/attachment/upload",
  	    	 method:"post",
  	    	 data:fd,
  	    	 processData:false,
  	    	 contentType:false,
  	    	 success:function(response){
  	    		//서버로 전송할 이미지 번호 정보 생성
  	    		var input = $("<input>").attr("type","hidden").attr("name","attachmentNo").val(response.attachmentNo);
  	    		$("form").prepend(input);
  	    		//에디터에 추가할 이미지 생성
	     		var imgNode=$("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
	     		$(".summernote-reply-edit").summernote('insertNode', imgNode.get(0));
  	    	 },
  	    	 error:function(){},
  	      });
  	    }
  	  }
	});
}

//답글작성 summernote
function childSummernote(){	
	$(" .summernote-reply-child").summernote({
	  disableResizeEditor: true,
	  toolbarPosition:'bottom',
	  placeholder: "대댓글 입력",
	  //탭키를 누르면 띄어쓰기 몇 번 할지(통상적으로 4 씀)
	  tabsize: 4,
	  //최초 표시될 높이(px)
	  height: 100,
	  //메뉴 설정
	  toolbar: [
        ["color", ["color"]],
		["insert", ["picture"]],
	    ["mybutton", ["submit", "cancle"]],
	  ],
	
	  buttons: {
		submit: submitButton,
	    edit: editButton,
	    cancle: cancleButton,
	  },
	  callbacks: {
	    onImageUpload: function(files) {
	      //[1]FormData [2]processData [3]contentType
	      if(files.length!=1) return;
	      var fd = new FormData();
	      fd.append("attach", files[0]);//파일이 한개밖에 없어서 [0]
	      $.ajax({
	    	 url:"/rest/attachment/upload",
	    	 method:"post",
	    	 data:fd,
	    	 processData:false,
	    	 contentType:false,
	    	 success:function(response){
	    		//서버로 전송할 이미지 번호 정보 생성
	    		var input = $("<input>").attr("type","hidden").attr("name","attachmentNo").val(response.attachmentNo);
	    		$("form").prepend(input);
	    		//에디터에 추가할 이미지 생성
	     		var imgNode=$("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
	     		$(".summernote-reply-child").summernote('insertNode', imgNode.get(0));
	    	 },
	    	 error:function(){},
	      });
	    }
	  }
	});
}
/*---------------------------*/
});