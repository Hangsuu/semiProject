<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <%-- css import --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/pocketdex.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/seal.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/page.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reply.css" />
    <!-- font-awesome CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
    <!-- 링크확인창 CDN -->
    <script src="https://cdn.jsdelivr.net/gh/hangsuu/confirm-link@latest/confirm-link.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/pocketdex.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/message/messageHeader.js"></script>

<script>
</script>
<script>
$(function(){
	$.ajax({
		url:"/rest/member/getNick",
		method:"get",
		success:function(response){
			if(response.length>0){
				$(".nickname-box").text(response+"님 환영합니다!")
			}
			else{
				$(".nickname-box").text("")
			}
		},
		error:function(){
			
		}
	});
})
</script>
    <title>POCKETDO!</title>
  </head>
  <body>
    <main>

<header class="container-1200" style="min-height:70px;">
    <!-- header -->
<div class="mb-20" style="background-color:#9DACE4">
   	<div class="flex-box w-100">
   		<div class="flex-box align-center ms-40 nickname-box" style="color:white"></div>
   		<div class="align-right" style="display:inline-block">
			<c:choose>
				<c:when test="${empty sessionScope.memberId}">
				<!-- css:commons, base -->
					<div class="row me-40">
						<a href="${pageContext.request.contextPath}/member/login" class="link right"><span class="header-menu me-10">로그인</span></a>
						<a href="${pageContext.request.contextPath}/member/join" class="link right"><span class="header-menu ms-10">회원가입</span></a>
					</div>
				</c:when>
				<c:when test="${sessionScope.memberId!=null && sessionScope.memberLevel!='관리자'}">
					<div class="row me-40">
						<a href="${pageContext.request.contextPath}/member/logout" class="link right"><span class="header-menu me-10">로그아웃</span></a>
						<a href="${pageContext.request.contextPath}/seal/list" class="link right"><span class="header-menu ms-10 me-10">인장구매</span></a>
						<a href="${pageContext.request.contextPath}/message/receive" class="link right"><span class="header-menu ms-10 me-10">쪽지</span></a>
						<a href="${pageContext.request.contextPath}/member/mypage" class="link right"><span class="header-menu ms-10 me-10">마이페이지</span></a>
						<a href="${pageContext.request.contextPath}/point/list" class="link right"><span class="header-menu ms-10">P.충전💰</span></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row me-40">
						<a href="${pageContext.request.contextPath}/member/logout" class="link right"><span class="header-menu me-10">로그아웃</span></a>
						<a href="${pageContext.request.contextPath}/seal/list" class="link right"><span class="header-menu ms-10 me-10">인장구매</span></a>
						<a href="${pageContext.request.contextPath}/message/receive" class="link right"><span class="header-menu ms-10 me-10">쪽지</span></a>
						<a href="${pageContext.request.contextPath}/member/mypage" class="link right"><span class="header-menu ms-10 me-10">마이페이지</span></a>
						<a href="${pageContext.request.contextPath}/admin/adminCheck" class="link right"><span class="header-menu ms-10 me-10">관리 페이지</span></a>
						<a href="${pageContext.request.contextPath}/point/list" class="link right"><span class="header-menu ms-10">P.충전💰</span></a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
     </div>
</div>
      <%-- base.css --%>
    <div class="float-box">
      <div class="float-left w-20">
        <a href="${pageContext.request.contextPath}/">
          <img src="${pageContext.request.contextPath}/static/image/logo_final.png" style="width:300px;" class="ms-40 mt-10 mb-10" >
        </a>
      </div>
    <div class="float-right w-70">
    <!-- nav -->
     <nav class="flex-box flex-auto-width">
       <%-- base.css --%>
       <div class="nav-bar flex-box align-center">
        
         <div>
           <a href="${pageContext.request.contextPath}/pocketdex/list" ><span>포켓몬도감</span></a>
         </div>
         
          <div>
           <a href="#" style="cursor:default;"><span>커뮤니티</span></a>
           <div>
			<div>
			  <a href="${pageContext.request.contextPath}/board/list"><span>자유 게시판</span></a>
			</div>
			<div>
			  <a href="${pageContext.request.contextPath}/board/hot"><span>인기 게시판</span></a>
			</div>
			<div>
			  <a href="${pageContext.request.contextPath}/auction/list?page=1"><span>굿즈 경매</span></a>
			</div>
		</div>
         </div>
         
         <div>
           <a href="#" style="cursor:default;"><span>연구실</span></a>
           <div>
             <div>
               <a href="${pageContext.request.contextPath}/simulator"><span>개체값 시뮬레이터</span></a>
             </div>
             <div>
               <a href="${pageContext.request.contextPath}/calculator"><span>스탯 계산기</span></a>
             </div>
			 <div>
               <a href="${pageContext.request.contextPath}/combination/list?page=1&tagList=&keyword=&column="><span>공략 게시판</span></a>
             </div>
           </div>
         </div>
         <div>
           <a href="#" style="cursor:default;"><span>포켓몬게임</span></a>
           <div>
             <div>
               <a href="${pageContext.request.contextPath}/raid/list?page=1"><span>레이드 참가</span></a>
             </div>
             <div>
               <a href="${pageContext.request.contextPath}/pocketmonTrade"><span>포켓몬교환 게시판</span></a>
             </div>
           </div>
         </div>
         <div class="me-10">
           <a href="${pageContext.request.contextPath}/cardGenerator"><span>트레이너카드</span></a>
         </div>
       </div>
     </nav>
     </div>
     </div>
    </header>
    </main>

    <div class="media-css" style="border-top: 2px solid #9dace4"></div>
  </body>
</html>
