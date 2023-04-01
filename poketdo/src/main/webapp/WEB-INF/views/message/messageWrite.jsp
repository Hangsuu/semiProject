<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/message/messageWrite.js"></script>
<style>
    .message-recipient-ele {
        min-height: 2.4em;
        margin: 0.25em;
        width: 22%;
    }
</style>
<script>
    const memberId = "${sessionScope.memberId}";
</script>
<script>
    $(function(){
        // checkValidRecipient();
        // 내게쓰기 처리
        $(".message-to-me-btn").change(function(){
            if($(this).prop("checked")){
                $("[name=messageRecipient]").val(memberId).attr("disabled", "true");
            } else {
                $("[name=messageRecipient]").val("").removeAttr("disabled");
            }
        })
        // 받는사람 입력 시 확인
        const recipientRow = $(".message-recipient-row");
        const recipientInput = $("#message-recipient-input");
        recipientInput.keydown(function(e){
            let code = e.keyCode;
            const messageRecipientVal = recipientInput.val();
            const messageRecipientEle = $(".message-recipient-ele");
            if((code===9 || code===13 || code===27)){
                // 미입력 시 진행 X
                if(messageRecipientVal === "") return;
                // 최대 10명 제한
                if(messageRecipientEle.length >= 11){
                    alert("쪽지 보내기는 한 번에 최대 10명까지 보낼 수 있습니다");
                    return;
                }

                

                // 메세지 수신자 템플릿 생성
                const newMessageRecipientEle = $.parseHTML($("#message-recipient-template").html());
                const messageRecipientOne = $(newMessageRecipientEle).find("[name=messageRecipient]");

                // 메세지 수신 memberId 설정
                let isExist;
                $.ajax({
                    url: "/rest/member/memberId/" + messageRecipientVal,
                    method: "get",
                    async: false,
                    success: function(response){
                        isExist = !(response==="Y"); 
                    },
                    error: function(){
                        console.log("받는 사람 체크 통신오류!!!!");
                    }
                })
                if(!isExist) {
                    $(newMessageRecipientEle).removeClass("back-sc-brighter");
                    $(newMessageRecipientEle).addClass("back-red-brighter");
                    // return;
                }

                // 메세지 받는사람 입력 비우기
                recipientInput.val("");
                // 받는사람 기입
                messageRecipientOne.val(messageRecipientVal);

                // 메세지 받는사람 버튼 2개
                // const recipientBtn = $(newMessageRecipientEle).find(".recipient-btn");
                const recipientBtn = $(newMessageRecipientEle).children();

                // 메세지 받는사람 수정 버튼
                $(newMessageRecipientEle).find(".message-recipient-modify-btn").click(function(){
                    recipientBtn.hide();
                    messageRecipientOne.removeAttr("disable");
                    const newInput = $("<input>").attr("type", "text").addClass("border-0 back-inherit w-70").css("outline", "none").val(messageRecipientOne.val());
                    const confirmBtn = $("<i>").addClass("fa-solid fa-check ps-10").css("color", "forestgreen");
                    const cancleBtn = $("<i>").addClass("fa-solid fa-xmark ps-5").css("color", "orange");
                    confirmBtn.click(function(){
                        const newInput = $(newMessageRecipientEle).children().eq(3).val();

                        let isExist;
                        $.ajax({
                            url: "/rest/member/memberId/" + newInput,
                            method: "get",
                            async: false,
                            success: function(response){
                                isExist = !(response==="Y"); 
                            },
                            error: function(){
                                console.log("받는 사람 체크 통신오류!!!!");
                            }
                        })
                        if(!isExist) {
                            $(newMessageRecipientEle).removeClass("back-sc-brighter");
                            $(newMessageRecipientEle).addClass("back-red-brighter");
                        } else {
                            $(newMessageRecipientEle).removeClass("back-red-brighter");
                            $(newMessageRecipientEle).addClass("back-sc-brighter");
                        }

                        $(this).parent().children().eq(0).val(newInput);
                        recipientBtn.show();
                        $(this).prev().remove();
                        $(this).next().remove();
                        $(this).remove();
                    })
                    cancleBtn.click(function(){
                        recipientBtn.show();
                        $(this).prev().prev().remove();
                        $(this).prev().remove();
                        $(this).remove();
                    })
                    $(newMessageRecipientEle).append(newInput);
                    $(newMessageRecipientEle).append(confirmBtn);
                    $(newMessageRecipientEle).append(cancleBtn);

                    console.log($(this).parent().children().eq(3).val());
                    $(this).parent().children().eq(3).focus();
                })
                // 메세지 받는사람 제거 버튼
                $(newMessageRecipientEle).find(".message-recipient-delete-btn").click(function(){
                    $(this).parent().remove();
                })

                // 메세지 새로운 받는 사람 추가
                $(newMessageRecipientEle).insertBefore("#message-recipient-input");
            };
        })
        // function checkValidRecipient(){
        //     let messageRecipient = $("[name=messageRecipient]").val();
        //     if(!messageRecipient==""){
        //         $.ajax({
        //             url: "/rest/member/memberId/" + messageRecipient,
        //             method: "get",
        //             success: function(response){
        //                 if(response==="Y"){
        //                     console.log("해당 유저는 존재X");
        //                 } else {
        //                     console.log("유효")
        //                 }
        //             },
        //             error: function(){
        //                 console.log("받는 사람 체크 통신오류!!!!");
        //             }
        //         })
        //     };
        // }
    })
</script>
<script type="text/template" id="message-recipient-template">
    <div class="message-recipient-ele flex-all-center inline-flex back-sc-brighter radius-1em ph-h-em">
        <input class="border-0 back-inherit w-70" name="messageRecipient" type="text" disabled/>
        <i class="recipient-btn message-recipient-modify-btn fa-solid fa-pen ps-10" style="color: gray"></i>
        <i class="recipient-btn message-recipient-delete-btn fa-solid fa-xmark ps-5" style="color: red"></i>
    </div>
</script>
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  <div class="mb-30">
        <h1>쪽지 쓰기</h1>
  </div>
  <div class="row">
    <form id="message-send-form" action="write" method="post">
        <input type="hidden" name="messageSender" value="${sessionScope.memberId}">
        <div class="row">
            <label for="message-recipient-input">
                받는사람 
            </label>
            &nbsp;
            <label style="font-size: 13px">
                <input class="message-to-me-btn" type="checkbox">
                내게쓰기
            </label>
            <div class="flex flex-wrap">
                <input id="message-recipient-input" class="form-input" type="text" name="messageRecipient" placeholder="받는 사람을 입력해주세요" value="${param.recipient}" required>
            </div>
        </div>
        <hr class="hr-sc"/>
        <div class="row">
            <label>
                제목
                <input class="form-input w-100" type="text" name="messageTitle" placeholder="제목을 입력해주세요" required>
            </label>
        </div>
        <div class="row">
            <label>
                내용
                <textarea class="form-input w-100" type="text" name="messageContent" placeholder="내용을 입력해주세요" required></textarea>
            </label>
        </div>
        <div class="row">
            <button id="message-send-btn" class="form-btn w-100 positive">보내기</button>
        </div>
    </form>

  </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


<div class="message-recipient-ele flex-all-center back-sc-brighter radius-1em ph-h-em">
    sweet little kitty
    <i class="fa-solid fa-pen ps-10" style="color: gray"></i>
    <i class="fa-solid fa-xmark ps-5" style="color: red"></i>
    <i class="fa-solid fa-check ps-10" style="color: forestgreen"></i>
    <i class="fa-solid fa-xmark ps-5" style="color: red"></i>
</div>