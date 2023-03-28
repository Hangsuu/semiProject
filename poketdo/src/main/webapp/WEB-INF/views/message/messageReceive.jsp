<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
      url: "/rest/message/receive",
      method: "get",
      data: {memberId: memberId},
      success: function(response){
        var messageList = response.list;
        var sendTimeList = response.sendTimeList;
        var readTimeList = response.readTimeList;
        $(".target").empty();
        for(var i = 0; i < response.list.length; i++){
          var message = messageList[i];
          var newReceiveMsgRow = $.parseHTML($("#receive-message-row").html());
          $(newReceiveMsgRow).find("input.message-check-one").val(message.messageNo);
          $(newReceiveMsgRow).find(".message-sender-col").text(message.messageSender);
          $(newReceiveMsgRow).find(".message-title-col").text(message.messageTitle);
          $(newReceiveMsgRow).find(".message-send-time-col").text(sendTimeList[i]);

          $(".target").append(newReceiveMsgRow);
        }
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
      // 배열
      var checkedArr = [5, 5];
      // var fd = new FormData();
      // fd.append("list", '5');
      // fd.append("list", '5');
      checkedOneBtn.each(function(){
        // fd.append("list", parseInt($(this).val()));
        // fd.append("list", 5);
      });

      $.ajax({
        url: "/rest/message/test",
        method: "post",
        data:JSON.stringify({list: [5, 5]}),
        // processData: false,
        // contentType: false,
        dataType: 'json',      // 호출 했을 때 결과타입
	contentType: "application/json",
        success: function(){
          loadList();
        },
        error: function(){
        }
      })
    }
  })

  // 새로고침 비동기 로드
  $(".message-refresh-btn").click(loadList);
  


})
</script>
<script type="text/template" id="receive-message-row">
  <hr class="mg-0"/>
  <div class="flex-row-grow message-row">
    <div class="flex-all-center message-check-column"><input class="message-check-one" type="checkbox"/></div>
    <div><a class="link message-sender-col" href="/message/write?recipient=${messageDto.getMessageSender()}">${messageDto.getMessageSender()}</a></div>
     <a class="link message-title-col" href="/message/receive/detail?messageNo=${messageDto.getMessageNo()}">${messageDto.getMessageTitle()}</a>
    <a class="link message-send-time-col" href="/message/receive/detail?messageNo=${messageDto.getMessageNo()}">
      <!-- <fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/> -->
    </a>
  </div>
</script>
<!-- section -->
<section class="flex-row-justify-center">

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  
  <!-- article -->
  <article class="container-800 mg-0">
    <div class="row mb-40">
        <h1>받은 쪽지함 <a class="deco-none" href="/message/receive?mode=new" style="color:#ffd400">${notReadCnt}</a>/<a class="deco-none" style="color:black" href="/message/receive">${lists.size()}</a></h1>
    </div>
    <div class="row flex">
      <div class="pocketmonTrade-btn message-delete-btn"><i class="fa-solid fa-xmark" style="color:red;"></i> 삭제</div><div class="pocketmonTrade-btn ml-auto message-refresh-btn"><i class="fa-solid fa-rotate-right" style="color: gray;"></i> 새로고침</div>
    </div>
    <div class="row">
      <div class="flex-row-grow message-row message-head">
        <div class="flex-all-center message-check-column"><input class="message-check-all" type="checkbox"></div>
        <div class="flex-align-center">보낸사람</div>
        <div class="flex-align-center">제목</div>
        <div class="flex-align-center">날짜</div>
      </div>
      <div class="target">
        <%-- <c:forEach var="messageDto" items="${lists}">
          <hr class="mg-0"/>
          <div class="flex-row-grow message-row">
            <div class="flex-all-center message-check-column"><input class="message-check-one" type="checkbox"></div>
            <div><a class="link" href="/message/write?recipient=${messageDto.getMessageSender()}">${messageDto.getMessageSender()}</a></div>
             <a class="link" href="/message/receive/detail?messageNo=${messageDto.getMessageNo()}">${messageDto.getMessageTitle()}</a>
            <a class="link" href="/message/receive/detail?messageNo=${messageDto.getMessageNo()}"><fmt:formatDate value="${messageDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/></a>
          </div>
        </c:forEach> --%>
      </div>
    </div>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
