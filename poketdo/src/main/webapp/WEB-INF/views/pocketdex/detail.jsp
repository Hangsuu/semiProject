<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".left").mouseenter(function() {
			$(this).find("i").addClass('fa-shake');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-shake');
		});
		$(".right").mouseenter(function() {
			$(this).find("i").addClass('fa-shake');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-shake');
		});
		$(".bottom-list-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
		$(".bottom-edit-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
		$(".bottom-delete-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
        $(".confirm-delete").click(function(e){
            e.preventDefault();
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            window.location.href = $(this).attr("href");
           
        });
		
	});	
	
</script>

<section class="container-1200 flex-box">

	<aside></aside>
	
	<article class="mt-50 pocket-detail-article">
		<div class="pocket-detail-container pdc-color${list.get(0).getPocketTypeNoes().get(0)}">
			<div class="detail-image-container">
				<div class="left-text">
					
					<c:choose>
						<c:when test="${prev.isEmpty()}">
							<span>No.0${list3.get(list3.size()-1).pocketNo}</span>
							<span>${list3.get(list3.size()-1).pocketName}</span>
						</c:when>
						<c:otherwise>
							<span>No.0${prev.get(0).pocketNo}</span>
							<span>${prev.get(0).pocketName}</span>
						</c:otherwise>
					</c:choose>

				</div>
				<div class="right-text">
				
					<c:choose>
						<c:when test="${next.isEmpty()}">
							<span>No.0${list3.get(0).pocketNo}</span>
							<span>${list3.get(0).pocketName}</span>
						</c:when>
						<c:otherwise>
							<span>No.0${next.get(0).pocketNo}</span>
							<span>${next.get(0).pocketName}</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="left icon-color">
					<i class="fa-solid fa-circle-chevron-left"></i>
				</div>
				<div class="right icon-color">
					<i class="fa-solid fa-circle-chevron-right"></i>
				</div>
				<div class="detail-image">
					<img src="${pocketmonWithImageDto.imageURL}">
					<span class="no">No.0${pocketmonWithImageDto.pocketNo}</span>
					<span class="name">${pocketmonWithImageDto.pocketName}</span>
				</div>
				<div class="detail-data">
					<div>
						<div>
							<span class="type">타입</span>
						</div>
					</div>
					<div>
						<div class="type-image-container">
							<div>
								<c:forEach var="i" begin="0" end="${list.get(0).getPocketTypes().size()-1}">
									<c:choose>
										<c:when test="${list.get(0).getPocketTypes().get(i).equals('없음')}">
										</c:when>
										<c:otherwise>
											<div class="type-back-color${list.get(0).getPocketTypeNoes().get(i)} ">
												<img src="${list2.get(i)}" >
												<span>
													${list.get(0).getPocketTypes().get(i)}
												</span>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>
						</div>
					</div>
					<div>
						<div class="basic-container">
							<div class="basic">
								<span>종족값</span>
							</div>
							<div class="basic-data">
								<div>
									<span>체력</span>
									<span>공격</span>
									<span>방어</span>
									<span>특수공격</span>
									<span>특수방어</span>
									<span>스피드</span>
								</div>
								<div>
									<span>${pocketmonWithImageDto.pocketBaseHp}</span>
									<span>${pocketmonWithImageDto.pocketBaseAtk}</span>
									<span>${pocketmonWithImageDto.pocketBaseDef}</span>
									<span>${pocketmonWithImageDto.pocketBaseSpd}</span>
									<span>${pocketmonWithImageDto.pocketBaseSatk}</span>
									<span>${pocketmonWithImageDto.pocketBaseSdef}</span>
								</div>
							</div>
						</div>
					</div>
					<div>
						<div class="effort-container">
							<div class="effort">
								<span>기본 노력치</span>
							</div>
							<div class="effort-data">
								<div>
									<span>체력</span>
									<span>공격</span>
									<span>방어</span>
									<span>특수공격</span>
									<span>특수방어</span>
									<span>스피드</span>
								</div>
								<div>
									<span>${pocketmonWithImageDto.pocketEffortHp}</span>
									<span>${pocketmonWithImageDto.pocketEffortAtk}</span>
									<span>${pocketmonWithImageDto.pocketEffortDef}</span>
									<span>${pocketmonWithImageDto.pocketEffortSpd}</span>
									<span>${pocketmonWithImageDto.pocketEffortSatk}</span>
									<span>${pocketmonWithImageDto.pocketEffortSdef}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom-icons">
					<div class="bottom-list-icon icon-color">
						<a href="list">
							<span>목록</span>
							<i class="fa-solid fa-bars "></i>
						</a>
					</div>
				<c:if test="${sessionScope.memberLevel=='관리자' }">
					<div class="bottom-edit-icon icon-color">
						<a href="edit?pocketNo=${pocketmonWithImageDto.pocketNo}">
							<span>수정</span>
							<i class="fa-solid fa-pen-to-square "></i>
						</a>
					</div>
					<div class="bottom-delete-icon">
						<a href="delete?pocketNo=${pocketmonWithImageDto.pocketNo}" class="confirm-delete">
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