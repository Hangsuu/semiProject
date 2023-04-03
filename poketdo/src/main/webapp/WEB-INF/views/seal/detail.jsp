<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 container-1200">
		
		
		<div class="seal-information">
			<div>
				<span>나의 인장</span>
			</div>
				<img width="96" height="96" 	src="${sealWithImageDto.imageURL}">
	
					${sealWithImageDto.sealNo}
					<td>${sealWithImageDto.sealName}</td>
					<td>${sealWithImageDto.sealPrice}</td>
					<td>
				<a href="edit?sealNo=${sealWithImageDto.sealNo}" >수정</a>
				<a href="delete?sealNo=${sealWithImageDto.sealNo}" >삭제</a>
				<a href="list">목록으로 이동</a>
		</div>		
	</article>
</section>		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>