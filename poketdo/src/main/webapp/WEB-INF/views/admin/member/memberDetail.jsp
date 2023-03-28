<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminheader.jsp"></jsp:include>  

<div class="container-800">
	<div class="row">
		<h2>${memberWithImageDto.memberNick} ���� ���� ������</h2>
	</div>
	<div class="row flex-box">
		<div class="w-30">
			<div class="row">
				<img width="200" height="200" 
					src="/attachment/${memberWithImageDto.imageURL}">
			</div>
			<div class="row center">
				<h2><a href="memberEdit?memberId=${memberWithImageDto.memberId}" class="link">�������� ����</a></h2>
			</div>
			<div class="row center">
				<h2><a href="memberDelete?memberId=${memberWithImageDto.memberId}" class="link">ȸ�� Ż��</a></h2>
			</div>
		</div>
		<div class="w-70">
			<table class="table table-slit">
				<tr>
					<th>���̵�</th>
					<td>${memberWithImageDto.memberId}</td>
				</tr>
				<tr>
					<th>�г���</th>
					<td>${memberWithImageDto.memberNick}</td>
				</tr>
				<tr>
					<th>�̸���</th>
					<td>${memberWithImageDto.memberEmail}</td>
				</tr>
				<tr>
					<th>���</th>
					<td>${memberWithImageDto.memberLevel}</td>
				</tr>
				<tr>
					<th>����Ʈ</th>
					<td>${memberWithImageDto.memberPoint}</td>
				</tr>
				<tr>
					<th>���� ��</th>
					<td>
						<fmt:formatDate value="${memberWithImageDto.memberJoin}" pattern="y�� M�� d�� E a h�� m�� s��"/>
					</td>
				</tr>
				<tr>
					<th>�α��� �ð�</th>
					<td>
						<fmt:formatDate value="${memberWithImageDto.memberLogin}" pattern="y�� M�� d�� E a h�� m�� s��"/>
					</td>
				</tr>
				<tr>
					<th>���� ����</th>
					<td>
						${memberWithImageDto.memberBirth}
					</td>
				</tr>
			</table>
		</div>
	</div>
	<a href="memberManage" class="form-btn w-100 neutral">������� ����</a>
</div>

<jsp:include page="/WEB-INF/views/template/adminfooter.jsp"></jsp:include>