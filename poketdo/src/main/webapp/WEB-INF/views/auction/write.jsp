<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script type="text/javascript">
  $(function () {
    $("[name=auctionContent]").summernote({
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
  	      // upload image to server and create imgNode...
  	      console.log(files);//업로드되는 파일 정보를 배열형태로 집어넣음
  	      //if(files.length!=1) return;
  	      //console.log("비동기 파일 업로드 시작");
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
  	    		console.log(response);
  	    		//서버로 전송할 이미지 번호 정보 생성
  	    		var input = $("<input>").attr("type","hidden").attr("name","attachmentNo").val(response.attachmentNo);
  	    		$("form").prepend(input);
  	    		//에디터에 추가할 이미지 생성
	     		//var imgNode=$("<img>").attr("src", "/rest/attachment/download?attachmentNo="+response.attachmentNo);
	     		var imgNode=$("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
	     		//$summernote.summernote('insertNode', imgNode);//summernote의 객체를 나타내므로 고쳐야됨
	     		$("[name=boardContent]").summernote('insertNode', imgNode.get(0));
  	    	 },
  	    	 error:function(){},
  	      });
  	    }
  	  }
    });
  });
</script>
<div class="container-800 mt-50">
<form action="write" method="post">
<input type="hidden" name="auctionWriter" value="${sessionScope.memberId}">
	<div class="row">
		제목<input class="form-input w-100" name="auctionTitle">
	</div>
	<div class="row">
		기간선택 : 
		<select name="lastDay" class="form-input">
			<option value="1">1일</option>
			<option value="3">3일</option>
		</select>
	</div>
	<div class="row">
	최소금액 : <input class="form-input w-40" name="auctionMinPrice">
	</div>
	<div class="row">
	최대금액 : <input class="form-input w-40" name="auctionMaxPrice">
	</div>
	<div class="row w-100">
		<textarea name="auctionContent" rows="10" class="form-input w-100"></textarea>
	</div>
	<button class="form-btn neutral">작성</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>