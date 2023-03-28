<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminheader.jsp"></jsp:include>  

<div class="container-800">
	<div class="row">
		<h2>${memberWithImageDto.memberNick} 님의 개인 프로필</h2>
	</div>
	<div class="row flex-box">
		<div class="w-30">
			<div class="row">
				<img width="200" height="200" 
					src="/attachment/${memberWithImageDto.imageURL}">
			</div>
			<div class="row center">
				<h2><a href="memberEdit?memberId=${memberWithImageDto.memberId}" class="link">개인정보 변경</a></h2>
			</div>
			<div class="row center">
				<h2><a href="memberDelete?memberId=${memberWithImageDto.memberId}" class="link">회원 탈퇴</a></h2>
			</div>
		</div>
		<div class="w-70">
			<table class="table table-slit">
				<tr>
					<th>아이디</th>
					<td>${memberWithImageDto.memberId}</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${memberWithImageDto.memberNick}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${memberWithImageDto.memberEmail}</td>
				</tr>
				<tr>
					<th>등급</th>
					<td>${memberWithImageDto.memberLevel}</td>
				</tr>
				<tr>
					<th>포인트</th>
					<td>${memberWithImageDto.memberPoint}</td>
				</tr>
				<tr>
					<th>가입 일</th>
					<td>
						<fmt:formatDate value="${memberWithImageDto.memberJoin}" pattern="y년 M월 d일 E a h시 m분 s초"/>
					</td>
				</tr>
				<tr>
					<th>로그인 시간</th>
					<td>
						<fmt:formatDate value="${memberWithImageDto.memberLogin}" pattern="y년 M월 d일 E a h시 m분 s초"/>
					</td>
				</tr>
				<tr>
					<th>생년 월일</th>
					<td>
						${memberWithImageDto.memberBirth}
					</td>
				</tr>
			</table>
		</div>
	</div>
	<a href="memberManage" class="form-btn w-100 neutral">목록으로 가기</a>
</div>

<jsp:include page="/WEB-INF/views/template/adminfooter.jsp"></jsp:include>