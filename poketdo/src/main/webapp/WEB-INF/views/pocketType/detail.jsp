<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 pocketdex-article">
		<div class="pocket-detail-container pdc-color type-back-color${pocketmonTypeWithImageDto.pocketTypeNo}">
			<div class="detail-image-container">
				<div class="detail-image" >
					<img src="${pocketmonTypeWithImageDto.imageURL}" class="type-back-color${pocketmonTypeWithImageDto.pocketTypeNo}">
					<span class="no">No.0${pocketmonTypeWithImageDto.pocketTypeNo}</span>
					<span class="name">${pocketmonTypeWithImageDto.pocketTypeName}</span>
				</div>
				<div class="detail-data">
					<div>
						<div>
							<span class="type">설명</span>
						</div>
					</div>
				</div>
				<div class="bottom-icons pdc-color${pocketmonTypeWithImageDto.pocketTypeNo}">
					<div class="bottom-list-icon icon-color">
						<a href="list">
							<span>목록</span>
							<i class="fa-solid fa-bars "></i>
						</a>
					</div>
				<c:if test="${sessionScope.memberLevel=='관리자' }">
					<div class="bottom-edit-icon icon-color">
						<a href="insert">
							<span>신규 등록</span>
							<i class="fa-solid fa-square-plus"></i>
						</a>
					</div>
					<div class="bottom-edit-icon icon-color">
						<a href="edit?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}">
							<span>수정</span>
							<i class="fa-solid fa-pen-to-square "></i>
						</a>
					</div>
					<div class="bottom-delete-icon">
						<a href="delete?pocketTypeNo=${pocketmonTypeWithImageDto.pocketTypeNo}" class="confirm-delete">
							<span>삭제</span>
							<i class="fa-solid fa-trash-can " ></i>
						</a>
					</div>
				</c:if>
				</div>
			</div>
		</div>
	</article>
	
</section>	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>