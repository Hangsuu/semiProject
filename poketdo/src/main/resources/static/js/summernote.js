  $(function () {
    $(".summernote").summernote({
      placeholder: "내용 작성",
      //탭키를 누르면 띄어쓰기 몇 번 할지(통상적으로 4 씀)
      tabsize: 4,
      //최초 표시될 높이(px)
      height: 250,
      //메뉴 설정
      toolbar: [
        ["style", ["style"]],
        ["font", ["bold", "underline", "clear"]],
        ["color", ["color"]],
        ["para", ["ul", "ol", "paragraph"]],
        ["table", ["table"]],
        ["insert", ["link", "picture"]],
      ],
	  callbacks: {
  	    onImageUpload: function(files) {
  	      //[1]FormData [2]processData [3]contentType
  	      if(files.length!=1) return;
  	      var fd = new FormData();
  	      fd.append("attach", files[0]);//파일이 한개밖에 없어서 [0]
  	      console.log(files);
  	      console.log(files[0]);
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
  });