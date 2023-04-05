 <%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8"%> 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
 <jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>   

<div class="container-1000 mt-50">
  <div class="row ps-30">
    <h1>회원 목록</h1>
  </div>
  <div class="row flex-box ps-30">
		<div class="flex-box">
			<form action="memberManage" method="get" autocomplete="off">
				<select name="column" class="form-input neutral">
					<option value="auction_title">아이디</option>
					<option value="auction_content">닉네임</option>
					<option value="member_nick">등급</option>
				</select>
				<input name="keyword" class="form-input" placeholder="검색">
				<input name="page" type="hidden" value="${param.page}">
				<button class="form-btn neutral">검색</button>
			</form>
		</div>
	</div>
  <div class="row">
    <table class="table table-slit">
      <thead>
        <tr class="ps-10">
          <th>이미지</th>
          <th>아이디</th>
          <th>닉네임</th>
          <th>등급</th>
          <th>포인트</th>
          <th style="width:200px;">관리</th>
        </tr>
      </thead>
      <tbody class="center">
        <c:if test="${list.size()>0}">
          <c:forEach var="i" begin="0" end="${list.size()-1}">
            <tr class="center ps-10">
              <td>
                <c:choose>
                  <c:when test="${list.get(0).attachmentNo == null}">
                    <img width="100" height="100" src="${urlList.get(i)}">
                  </c:when>
                  <c:otherwise>
                    <img width="100" height="100" src="/attachment/${list.get(i).imageURL}">
                  </c:otherwise>
                </c:choose>
              </td>
              <td>${list.get(i).memberId}</td>
              <td>${list.get(i).memberNick}</td>
              <td>${list.get(i).memberLevel}</td>
              <td class="right">${list.get(i).memberPoint}</td>
              <td>
                <a href="memberDetail?memberId=${list.get(i).memberId}" class="link">상세</a>
                <a href="memberEdit?memberId=${list.get(i).memberId}" class="link">수정</a>
                <form action="memberDelete" method="post">
                <a href="memberDelete?memberId=${list.get(i).memberId}" class="link">삭제</a>
                </form>
              </td>
            </tr>
          </c:forEach>
        </c:if>
        <!-- <c:forEach var="memberWithImageDto" items="${list}">
          <tr class="center">
            <td>
              <c:choose>
                <c:when test="${memberWithImageDto.attachmentNo == null}">
                  <img width="100" height="100" src="/static/image/user.jpg">
                </c:when>
                <c:otherwise>
                  <img width="100" height="100" src="/attachment/${memberWithImageDto.imageURL}">
                </c:otherwise>
              </c:choose>
            </td>
            <td>${memberWithImageDto.memberId}</td>
            <td>${memberWithImageDto.memberNick}</td>
            <td>${memberWithImageDto.memberLevel}</td>
            <td class="right">${memberWithImageDto.memberPoint}</td>
            <td>
              <a href="memberDetail?memberId=${memberWithImageDto.memberId}" class="link">상세</a>
              <a href="memberEdit?memberId=${memberWithImageDto.memberId}" class="link">수정</a>
              <form action="memberDelete" method="post">
              <a href="memberDelete?memberId=${memberWithImageDto.memberId}" class="link">삭제</a>
              </form>
            </td>
          </tr>
        </c:forEach> -->
      </tbody>
    </table>
  </div>

 	<div class="row pagination"> 
 		 처음  
 		<c:choose> 
 			<c:when test="${vo.first}"> 
 				<a class="disabled">&laquo;</a> 
 			</c:when> 
 			<c:otherwise> 
 				<a href="memberManage?${vo.parameter}&page=1">&laquo;</a> 
 			</c:otherwise> 
 		</c:choose> 
		
 		 이전  
 		<c:choose> 
 			<c:when test="${vo.prev}"> 
 				<a href="memberManage?${vo.parameter}&page=${vo.prevPage}">&lt;</a> 
 			</c:when> 
 			<c:otherwise> 
 				<a class="disabled">&lt;</a> 
 			</c:otherwise> 
 		</c:choose> 
		
 		 숫자  
 		<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}"> 
 			<c:choose> 
 				<c:when test="${vo.page == i}"> 
 					<a class="on">${i}</a> 
 				</c:when> 
 				<c:otherwise> 
 					<a href="memberManage?${vo.parameter}&page=${i}">${i}</a> 
 				</c:otherwise> 
 			</c:choose> 
 		</c:forEach> 
		
 		 다음  
 		<c:choose> 
 			<c:when test="${vo.next}"> 
 				<a href="memberManage?${vo.parameter}&page=${vo.nextPage}">&gt;</a> 
 			</c:when> 
 			<c:otherwise> 
 				<a class="disabled">&gt;</a> 
 			</c:otherwise> 
 		</c:choose> 
		
 		 마지막  
 		<c:choose> 
 			<c:when test="${vo.last}"> 
 				<a class="disabled">&raquo;</a> 
 			</c:when> 
 			<c:otherwise> 
 				<a href="memberManage?${vo.parameter}&page=${vo.totalPage}">&raquo;</a> 
 			</c:otherwise> 
 		</c:choose> 
 		</div> 
	</div>
</div>

	</article>
            </section>
    			</header>
    			</main>

 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 