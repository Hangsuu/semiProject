<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/static/js/pocket-edit.js"></script>
<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">
	
	
	<form action="editProcess" method="post" enctype="multipart/form-data" class="form pocket-form">
		<div class="pocket-input-container" >
			<div>
				<h1>포켓몬스터 정보 수정</h1>
			</div>
			<div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 번호 : ${pocketmonDto.pocketNo}</span>
					</div>
					<div class="pocket-input-box">
						<input type="hidden" name="pocketNo" value="${pocketmonDto.pocketNo}" >
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 이름</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketName" value="${pocketmonDto.pocketName}" class="form-input">
						<span class="valid-message">사용 가능한 이름입니다!</span>
						<span class="invalid-message2">이미 사용중인 이름입니다!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (HP)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseHp" value="${pocketmonDto.pocketBaseHp}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseAtk" value="${pocketmonDto.pocketBaseAtk}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseDef" value="${pocketmonDto.pocketBaseDef}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (스피드)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSpd" value="${pocketmonDto.pocketBaseSpd}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (특수공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSatk" value="${pocketmonDto.pocketBaseSatk}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (특수방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSdef" value="${pocketmonDto.pocketBaseSdef}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (HP)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortHp" value="${pocketmonDto.pocketEffortHp}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortAtk" value="${pocketmonDto.pocketEffortAtk}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortDef" value="${pocketmonDto.pocketEffortDef}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (스피드)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSpd" value="${pocketmonDto.pocketEffortSpd}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (특수공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSatk" value="${pocketmonDto.pocketEffortSatk}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (특수방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSdef" value="${pocketmonDto.pocketEffortSdef}" class="form-input">
						<span class="valid-message">사용 가능한 번호입니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 속성 1</span>
					</div>
						<div class="pocket-input-box">
							<select name="typeJoinNo" class="form-input neutral">
								<c:forEach items="${typeList}" var="type">
									<c:choose>
										<c:when test="${type.pocketTypeName eq typeJoinName}">
											<option value="${type.pocketTypeNo}" selected>${type.pocketTypeName}</option>
										</c:when>
										<c:otherwise>
											<option value="${type.pocketTypeNo}">${type.pocketTypeName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
					</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 속성 2</span>
					</div>
						<div class="pocket-input-box">
							<select name="typeJoinNo2" class="form-input neutral">
								<c:forEach items="${typeList}" var="type">
									<c:choose>
										<c:when test="${type.pocketTypeName eq typeJoinName2}">
											<option value="${type.pocketTypeNo}" selected>${type.pocketTypeName}</option>
										</c:when>
										<c:otherwise>
											<option value="${type.pocketTypeNo}">${type.pocketTypeName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
					</div>
					<div>
						<div class="pocket-input-box">
							<span>포켓몬스터 이미지(png, gif, jpg)</span>
						</div>
						<div class="pocket-input-box">
							<input type="file" name="attach" accept=".png, .gif, .jpg" class="form-input">
						</div>
					</div>
					<div>
						<button class="form-btn positive">입력 완료</button>
					</div>
				</div>
			</div>
		
	</form>
		</article>
	
</section>	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
