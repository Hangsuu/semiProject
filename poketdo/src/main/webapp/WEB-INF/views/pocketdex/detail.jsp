<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 pocket-detail-article">
		<div class="pocket-detail-container">
			<div class="detail-image-container">
				<div class="left">
					<i class="fa-solid fa-circle-chevron-left fa-2xl" ></i>
				</div>
				<div class="right">
					<i class="fa-solid fa-circle-chevron-right fa-2xl" ></i>
				</div>
				<div class="detail-image">
					<img src="${pocketmonWithImageDto.imageURL}">
					<span class="no">No.0${pocketmonWithImageDto.pocketNo}</span>
					<span class="name">${pocketmonWithImageDto.pocketName}</span>
				</div>
				<div class="detail-data">
				</div>
				<div class="detail-list-icon">
					<i class="fa-solid fa-bars fa-2xs" style="color: #0077c2; font-size:4em;"></i>
				</div>
			</div>
		</div>
	</article>
	
</section>	
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>