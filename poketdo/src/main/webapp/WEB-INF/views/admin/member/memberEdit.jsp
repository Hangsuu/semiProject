<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminheader.jsp"></jsp:include>  

<form action="memberEdit" method="post">
	<div class="container-800">
		<div class="row">
			<h2>회원 정보 변경</h2>
		</div>
		<div class="row flex-box">
			<div class="w-30">
				<div class="row">
					<img width="200" height="200" 
						src="/attachment/${memberWithImageDto.imageURL}">
				</div>
			</div>
				<div class="w-70">
					<table class="table table-slit">
						<tr>
							<th>아이디</th>
							<td>
								${memberWithImageDto.memberId}
							</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>
								<input type="text" name="memberNick" value="${memberWithImageDto.memberNick}" class="form-input w-100">
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="memberEmail" value="${memberWithImageDto.memberEmail}" class="form-input w-100">
							</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<c:choose>
									<c:when test="${memberWithImageDto.memberLevel == '일반회원'}">
										<select name="memberLevel" class="form-input">
											<option selected>일반회원</option>
											<option>마스터</option>
										</select>
									</c:when>
									<c:when test="${memberWithImageDto.memberLevel == '마스터'}">
										<select name="memberLevel" class="form-input">
											<option>일반회원</option>
											<option selected>마스터</option>
										</select>
									</c:when>
								</c:choose>
								
								(기존 : ${memberWithImageDto.memberLevel})
							</td>
						</tr>
						<tr>
							<th>포인트</th>
							<td>
								<input type="text" name="memberPoint" value="${memberWithImageDto.memberPoint}" class="form-input w-100">
								(기존 : ${memberWithImageDto.memberPoint} point)
							</td>
						</tr>
						<tr>
							<th>가입 일</th>
							<td>
								<fmt:formatDate value="${memberWithImageDto.memberJoin}" pattern="y년 M월 d일 E a h시 m분 s초"/>
							</td>
						</tr>
						<tr>
							<th>로그인</th>
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
			<div class="row right">
				<a href="memberManage" class="form-btn neutral">목록</a>
				<button type="submit" class="form-btn positive">등록</button>
			</div>
		</div>
	</form>

<jsp:include page="/WEB-INF/views/template/adminfooter.jsp"></jsp:include>