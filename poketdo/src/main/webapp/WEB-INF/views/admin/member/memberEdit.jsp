<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/adminheader.jsp"></jsp:include>  

<form action="memberEdit" method="post">
	<div class="container-800">
		<div class="row">
			<h2>ȸ�� ���� ����</h2>
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
							<th>���̵�</th>
							<td>
								${memberWithImageDto.memberId}
							</td>
						</tr>
						<tr>
							<th>�г���</th>
							<td>
								<input type="text" name="memberNick" value="${memberWithImageDto.memberNick}" class="form-input w-100">
							</td>
						</tr>
						<tr>
							<th>�̸���</th>
							<td>
								<input type="text" name="memberEmail" value="${memberWithImageDto.memberEmail}" class="form-input w-100">
							</td>
						</tr>
						<tr>
							<th>���</th>
							<td>
								<c:choose>
									<c:when test="${memberWithImageDto.memberLevel == '�Ϲ�ȸ��'}">
										<select name="memberLevel" class="form-input">
											<option selected>�Ϲ�ȸ��</option>
											<option>������</option>
										</select>
									</c:when>
									<c:when test="${memberWithImageDto.memberLevel == '������'}">
										<select name="memberLevel" class="form-input">
											<option>�Ϲ�ȸ��</option>
											<option selected>������</option>
										</select>
									</c:when>
								</c:choose>
								
								(���� : ${memberWithImageDto.memberLevel})
							</td>
						</tr>
						<tr>
							<th>����Ʈ</th>
							<td>
								<input type="text" name="memberPoint" value="${memberWithImageDto.memberPoint}" class="form-input w-100">
								(���� : ${memberWithImageDto.memberPoint} point)
							</td>
						</tr>
						<tr>
							<th>���� ��</th>
							<td>
								<fmt:formatDate value="${memberWithImageDto.memberJoin}" pattern="y�� M�� d�� E a h�� m�� s��"/>
							</td>
						</tr>
						<tr>
							<th>�α���</th>
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
			<div class="row right">
				<a href="memberManage" class="form-btn neutral">���</a>
				<button type="submit" class="form-btn positive">���</button>
			</div>
		</div>
	</form>

<jsp:include page="/WEB-INF/views/template/adminfooter.jsp"></jsp:include>