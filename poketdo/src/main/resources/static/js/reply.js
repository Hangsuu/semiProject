//댓글 처리 자바스크립트 파일

/*전역변수(memberId, boardWriter) 설정 필요*/
$(function(){
	//글 번호를 가져온다
	var params = new URLSearchParams(location.search);
	var replyOrigin = params.get("boardNo");
	
	//댓글 목록 불러오기
	loadList();
	
	//.reply-insert-btn을 누르면 작성한 내용을 등록하는 처리 구현
	$(".reply-insert-btn").click(function(){
		var content = $("[name=replyContent]").val();//입력값 불러오기
		if(content.trim().length == 0) return;//의미없는 값 차단
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
					var childbtn = $("<i>").addClass("fa-solid fa-reply ms-10")
							.attr("data-reply-parent", response[i].replyNo).click(childReply);
					$(html).find(".reply-writer").append(childbtn);
					
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
		console.log(text);
		$(html).find(".reply-edit-content").val(text);
		$(this).parents(".reply-box").hide().after(html);
				summernote();
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
	function childReply(){
		var parentNo = $(this).data("reply-parent");
		console.log(parentNo)
		var template = $("#reply-child-template").html();
		var html = $.parseHTML(template);
		$(html).find("reply-submit").attr("data-reply-parent", parentNo);
		$(this).parent().parent().after(html);
	}

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
				replyOrigin: replyOrigin,
				replyContent: content,
				replyWriter:memberId,
				replyOrigin:allboardNo,
				replyContent:content,
				replyGroup:replyGroup,

			},
			success:function(response){
				loadList();//목록 불러오기
				$("[name=replyContent]").val("");//입력창 청소
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 시도하세요");
			}
		});
	});
	

	//목록을 불러오는 함수
	function loadList() {
		$(".reply-list").empty();//대상 영역을 청소
		
		$.ajax({
			url:"/rest/reply/"+replyOrigin,
			method:"get",
			success:function(response){//response == List<ReplyDto>
				//댓글 개수 변경
				$(".reply-count").text(response.length);
			
				//console.log(response);
				for(var i=0; i < response.length; i++) {
					//템플릿 불러와서 세팅하고 추가하는 코드
					var template = $("#reply-template").html();//템플릿 불러와서
					var html = $.parseHTML(template);//사용할 수 있게 변환하고
					
					$(html).find(".replyWriter").text(response[i].replyWriter);
					$(html).find(".replyContent").text(response[i].replyContent);
					$(html).find(".replyTime").text(response[i].replyTime);
					
					//작성자 본인의 댓글에는 태그를 생성해서 추가 표시
					//-> boardWriter == response[i].replyWriter
					if(boardWriter == response[i].replyWriter) {
						var author = $("<span>").addClass("author ms-10")
															.text("작성자");
						$(html).find(".replyWriter").append(author);
					}
					
					//내가 쓴 댓글에는 수정/삭제 버튼을 추가 표시
					if(memberId == response[i].replyWriter) {
						var editButton = $("<i>").addClass("fa-solid fa-edit ms-30")
																.attr("data-reply-no", response[i].replyNo)
																.attr("data-reply-content", response[i].replyContent)
																	.click(editReply);
						var deleteButton = $("<i>").addClass("fa-solid fa-trash ms-10")
																	.attr("data-reply-no", response[i].replyNo)
																	.click(deleteReply);
						
						$(html).find(".replyWriter").append(editButton)
																.append(deleteButton);
					}
					
					$(".reply-list").append(html);//목록 영역에 추가
				}
			},
			error:function(){
				alert("통신 오류 발생");
			}
		});
	}
	
	function deleteReply() {
		//this == span
		var choice = window.confirm("정말 삭제하시겠습니까?\n삭제 후 복구는 불가능합니다");
		if(choice == false) return;
		
		var replyNo = $(this).data("reply-no");
		
		$.ajax({
			url:"/rest/reply/"+replyNo,
			method:"delete",
			success:function(response){
				loadList();
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 실행하세요");
			},
		});
	}
	
	function editReply() {
		//this == 수정버튼
		//- data-reply-no라는 이름으로 댓글번호가 존재
		//- data-reply-content라는 이름으로 댓글내용이 존재
		var replyNo = $(this).data("reply-no");
		var replyContent = $(this).data("reply-content");
		
		//계획
		//- 입력창과 등록버튼, 취소버튼을 생성
		//- 등록버튼을 누르면 비동기통신으로 댓글을 수정 후 목록 갱신
		//- 취소버튼을 누르면 생성한 태그를 삭제
		var textarea = $("<textarea>").addClass("form-input w-100")
														.attr("placeholder", "변경 내용 작성")
														.val(replyContent);
		var confirmButton = $("<button>").addClass("form-btn positive ms-10")
												.text("수정")
												.click(function(){
													//번호와 내용을 비동기 전송 후 목록 갱신
													$.ajax({
														url:"/rest/reply/",
														method:"patch",
														data:{
															replyNo:replyNo,
															replyContent:textarea.val()
														},
														success:function(response){
															loadList();
														},
														error:function(){
															alert("통신 오류 발생\n잠시 후에 시도하세요");
														},
													});
												});
		var cancelButton = $("<button>").addClass("form-btn neutral")
											.text("취소")
											.click(function(){
												$(this).parents(".reply-item").prev(".reply-item").show();
												$(this).parents(".reply-item").remove();
											});	
		var div = $("<div>").addClass("reply-item right");
		
		div.append(textarea).append(cancelButton).append(confirmButton);
		
		$(this).parents(".reply-item").hide().after(div);
	}
	
var submitButton = function (context) {
  var ui = $.summernote.ui;

  // create button
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
summernote();
function summernote(){
	$(" .summernote-reply").summernote({
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
});
});
	