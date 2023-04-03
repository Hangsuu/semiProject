<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>  

<div class="container-1000">
  <div class="row center">
    <h1>회원 목록</h1>
  </div>
  <div class="row">
    <table class="table table-slit">
      <thead>
        <tr>
          <th>이미지</th>
          <th>아이디</th>
          <th>닉네임</th>
          <th>등급</th>
          <th>포인트</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody class="center">
        <c:forEach var="memberWithImageDto" items="${list}">
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
        </c:forEach>
      </tbody>
    </table>
  </div>
	
	<div class="row pagination">
		<!-- 처음 -->
		<c:choose>
			<c:when test="${vo.first}">
				<a class="disabled">&laquo;</a>
			</c:when>
			<c:otherwise>
				<a href="memberManage?${vo.parameter}&page=1">&laquo;</a>
			</c:otherwise>
		</c:choose>
		
		<!-- 이전 -->
		<c:choose>
			<c:when test="${vo.prev}">
				<a href="memberManage?${vo.parameter}&page=${vo.prevPage}">&lt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&lt;</a>
			</c:otherwise>
		</c:choose>
		
		<!-- 숫자 -->
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
		
		<!-- 다음 -->
		<c:choose>
			<c:when test="${vo.next}">
				<a href="memberManage?${vo.parameter}&page=${vo.nextPage}">&gt;</a>
			</c:when>
			<c:otherwise>
				<a class="disabled">&gt;</a>
			</c:otherwise>
		</c:choose>
		
		<!-- 마지막 -->
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>