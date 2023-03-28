<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>
<script>
    $(function(){
        var messageSendForm = $("#message-send-form");
        $("#message-send-btn").click(function(e){
            e.preventDefault();
            var isLogin = messageSendForm.find("input[name='messageSender']").val()!="";
            if(!isLogin){
                alert("로그인해야 메세지를 보낼 수 있습니다.");
                return;
            }
            $.ajax({
                url: "/rest/message/write",
                method: "post",
                data: messageSendForm.serialize(),
                success: function(){
                    alert("쪽지를 성공적으로 보냈습니다")
                messageSendForm[0].reset();
                },
                error: function(){
                    console.log("메세지 전송 통신오류");
                }
            })
        })
    })
</script>
<!-- section -->
<section class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row">
        <h1>쪽지 쓰기</h1>
    </div>
    <div class="row">
        <form id="message-send-form" action="write" method="post">
            <input type="hidden" name="messageSender" value="${sessionScope.memberId}">
            <div class="row">
                <label>
                    받는사람
                    <input class="form-input w-100" type="text" name="messageRecipient" placeholder="제목을 입력해주세요" value="${param.recipient}" required>
                </label>
            </div>
            <div class="row">
                <label>
                    제목
                    <input class="form-input w-100" type="text" name="messageTitle" placeholder="제목을 입력해주세요" required>
                </label>
            </div>
            <div class="row">
                <label>
                    내용
                    <textarea class="form-input w-100" type="text" name="messageContent" placeholder="제목을 입력해주세요" required></textarea>
                </label>
            </div>
            <div class="row">
                <button id="message-send-btn" class="form-btn w-100 positive">보내기</button>
            </div>
        </form>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
