<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .message-send-cancle-btn:hover {
    cursor: pointer;
  }
</style>

<script>
  var memberId = "${sessionScope.memberId}";
</script>
<script>
$(function(){
  loadList();
  // 메세지 모두 선택 체크박스
  var checkAllEle = $(".message-check-all");
  // 메세지 개별 선택 체크박스
  var checkOneBtn =$(".message-check-one");
  // 메세지 check-all과 모든 버튼 동기화
  checkAllEle.change(function(){
    $("input[type=checkbox]").prop("checked",$(this).prop("checked"));
  })

  // 메세지 개별 버튼과 check-all 동기화
  checkOneBtn.change(function(){
    var checkedOneBtn = $(".message-check-one:checked");
    var checkOneCnt = checkOneBtn.length;
    var checkedCnt = checkedOneBtn.length;
    checkAllEle.prop("checked", checkOneCnt == checkedCnt);
    // 첫번 째 다 눌리면 check-all도 체크
  })
  // 메세지 비동기 load
  function loadList(){
    $.ajax({
      url: "/rest/message/send",
      method: "get",
      data: {memberId: memberId},
      success: function(response){
        var messageList = response.list;
        var sendTimeList = response.sendTimeList;
        var readTimeList = response.readTimeList;
        
        // target 비우고 다시 로드
        $(".target").empty();
        for(var i = 0; i < messageList.length; i++){
          const message = messageList[i];
          const newReceiveMsgRow = $.parseHTML($("#send-message-row").html());
          $(newReceiveMsgRow).find("input.message-check-one").val(message.messageNo);
          $(newReceiveMsgRow).find(".message-sender-col").text(message.messageRecipient).attr("href", "/message/write?recipient=" + message.messageRecipient);
          $(newReceiveMsgRow).find(".message-title-col").text(message.messageTitle).attr("href", "/message/send/detail?messageNo=" + message.messageNo);
          $(newReceiveMsgRow).find(".message-send-time-col").text(sendTimeList[i]).attr("href", "/message/send/detail?messageNo=" + message.messageNo);
          if(readTimeList[i]==null){
            $(newReceiveMsgRow).find(".message-read-time-col").text("읽지않음").attr("href", "/message/send/detail?messageNo=" + message.messageNo).css("font-weight", "bold");
          } else {
            $(newReceiveMsgRow).find(".message-read-time-col").text(readTimeList[i]).attr("href", "/message/send/detail?messageNo=" + message.messageNo);
          }
          $(newReceiveMsgRow).find(".message-send-cancle-btn").text(readTimeList[i]==null ? "발송취소" : "").css("text-decoration", "underline").click(function(){
            console.log("message.messageNo: " + message.messageNo);
            if(confirm(message.messageRecipient + "님에게 보낸 쪽지를 발송취소 하시겠습니까?\n")){
              $.ajax({
                url: "/rest/message/" + message.messageNo,
                method: "delete",
                success: function(){
                  loadList();
                },
                error: function(){
                  console.log("메세지 발송취소 통신에러!!!!");
                }
              })
            }
          });

          $(".target").append(newReceiveMsgRow);
        }

        // h1태그 옆 숫자 반영
        // 받은 메세지 전체 숫자
        $(".message-send-cnt").text(messageList.length);
      },
      error: function(){
        console.log("메세지 비동기 list 통신에러!!!!!")
      }
    })
  }

  // 메세지 삭제 버튼 클릭 event 등록
  $(".message-delete-btn").click(function(){
    var checkedOneBtn = $("input.message-check-one:checked");
    var checkedCnt = checkedOneBtn.length;
    if(checkedCnt==0){
      alert("삭제하실 쪽지를 선택하세요");
    } else {
      // 확인
      if(!confirm(checkedCnt + "개의 쪽지를 삭제하시겠습니까?")){
        return;
      }

      // 체크 된 메세지의 messageNo를 list에 저장
      var list = [];
      checkedOneBtn.each(function(){
        list.push(parseInt($(this).val()));
      });

      // for문으로 delete 실행
      for(var i = 0; i < list.length; i++){
        $.ajax({
        url: "/rest/message/send",
        method: "put",
        data: {messageNo: list[i]},
        success: function(){
          loadList();
        },
        error: function(){
        }
      })
      }
    }
  })
  // 새로고침 비동기 로드
  $(".message-refresh-btn").click(function(){
    loadList();
    $(".fa-rotate-right").addClass("custom-spin");
    setTimeout(function(){$(".fa-rotate-right").removeClass("custom-spin");},500);
  });
})
</script>
<script type="text/template" id="send-message-row">
  <hr class="mg-0"/>
  <div class="flex-row-grow message-row">
    <div class="flex-all-center message-check-column">
      <input class="message-check-one" type="checkbox"/>
    </div>
    <div>
      <a class="link message-sender-col">받은사람</a>
    </div>
    <a class="link message-title-col">메세지 제목</a>
    <a class="link message-send-time-col">보낸시간</a>
    <a class="link message-read-time-col">받은시간</a>
    <div class="message-send-cancle-btn">발송취소</div>
  </div>
</script>
<!-- section -->
<section class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row mb-40">
        <h1>보낸 쪽지함 <a class="deco-none message-send-cnt" style="color:black" href="/message/send"></a></h1>
    </div>
    <div class="row flex">
      <div class="pocketmonTrade-btn message-delete-btn"><i class="fa-solid fa-xmark" style="color:red;"></i> 삭제</div><div class="pocketmonTrade-btn ml-auto message-refresh-btn"><i class="fa-solid fa-rotate-right" style="color: gray;"></i> 새로고침</div>
    </div>
    <div class="row">
      <div class="flex-row-grow message-row message-head">
        <div class="flex-all-center message-check-column"><input class="message-check-all" type="checkbox"></div>
        <div class="flex-align-center">받은사람</div>
        <div class="flex-align-center">제목</div>
        <div class="flex-align-center">보낸시간</div>
        <div class="flex-align-center">읽은시간</div>
        <div class="flex-align-center">발송취소</div>
      </div>
      <div class="target">
      </div>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
