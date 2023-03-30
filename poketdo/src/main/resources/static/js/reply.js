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
				for(var i=0; i<response.length; i++){
					var template = $("#reply-template").html();
					var html = $.parseHTML(template);
					var text = response[i].replyContent;
					$(html).find(".reply-writer").text(response[i].replyWriter);
					$(html).find(".reply-content").html(text);
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
					//답글달기 버튼
					if(memberId){
						var childbtn = $("<i>").addClass("fa-solid fa-reply ms-10")
								.attr("data-reply-parent", response[i].replyNo).click(childReply);
						$(html).find(".reply-writer").append(childbtn);
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
		var text = $(this).data("reply-content");
		var replyNo = $(this).data("reply-no");
		$(html).find(".reply-edit-content").attr("data-reply-no", replyNo).val(text);
		$(this).parents(".reply-box").hide().after(html);
		editSummernote();
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
	//대댓글 버튼 클릭 시 들어가는 함수
	function childReply(){
		var parentNo = $(this).data("reply-parent");
		console.log(parentNo)
		var template = $("#reply-child-template").html();
		var html = $.parseHTML(template);
		$(html).find("reply-submit").attr("data-reply-parent", parentNo);
		$(this).parent().parent().after(html);
	}
	//댓글입력 버튼 누르면 실행되는 함수
	$(".reply-submit").click(function(){
		console.log("입력");
		if(!memberId){
			alert("로그인 후 이용하세요");
			return;
		}
		var content = $(this).parents(".summernote-reply").val();
		if(content.trim().length==0) return;
		var replyGroup=0;
		if($(this).data("reply-parent")!=undefined){
			replyGroup=$(this).data(reply-parent);
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
				loadList();
				$(".summernote-reply").val("");
			},
			error:function(){
				alert("통신오류")
			},
		});
	});
/*----------------------summernote-------------------------*/

//작성버튼 생성	
var submitButton = function (context) {
  var ui = $.summernote.ui;
  var button = ui.button({
    contents: $("<button>").addClass("reply-submit").text("댓글등록"),
    click: function () {
		if(!memberId){
			alert("로그인 후 이용하세요");
			return;
		}
		var content = $(this).parent().parent().parent().parent().children(".summernote-reply").val();
		if(content.trim().length==0) return;
		var replyGroup=0;
		if($(this).data("reply-parent")!=undefined){
			replyGroup=$(this).data(reply-parent);
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
				loadList();
				$(".summernote-reply").summernote("code", "");
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
    contents: $("<button>").addClass("confirm-edit").text("수정"),
    click: function () {
		if(confirm("수정하시겠습니까?")){
			var newContent = $(this).parent().parent().parent().parent().children(".summernote-reply").val();
			var replyNo=$(this).parent().parent().parent().parent().parent();
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
    contents: $("<button>").addClass("cancle-edit").text("취소"),
    click: function () {
		$(".summernote-reply").summernote("code", "");
		loadList();
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
	  height: 50,
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
	     		$(".summernote").summernote('insertNode', imgNode.get(0));
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
	  height: 50,
	  //메뉴 설정
	  toolbar: [
        ["color", ["color"]],
		["insert", ["picture"]],
	    ["mybutton", ["edit"]],
	    ["mybutton", ["cancle"]],
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
	     		$(".summernote").summernote('insertNode', imgNode.get(0));
	    	 },
	    	 error:function(){},
	      });
	    }
	  }
	});
}
/*---------------------------*/
});