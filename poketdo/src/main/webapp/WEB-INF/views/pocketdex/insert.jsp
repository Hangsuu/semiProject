<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/static/js/pocket-insert.js"></script>

<section class="container-1200 flex-box flex-vertical">

	<aside></aside>
	
	<article class="mt-50 container-1200 ">
	
	<form action="insertProcess" method="post" enctype="multipart/form-data" class="form pocket-form">
		<div class="pocket-input-container" >
			<div>
				<h1>포켓몬스터  신규 등록</h1>
			</div>
			<div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 번호</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketNo"  class="form-input" >
						<span class="valid-message">사용 가능 번호입니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>
						<span class="invalid-message2">이미 사용중인 번호입니다!</span>
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 이름</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketName"  class="form-input">
						<span class="valid-message">사용 가능한 이름입니다!</span>
						<span class="invalid-message">필수 입력 항목입니다!</span>
						<span class="invalid-message2">이미 사용중인 이름입니다!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (HP)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseHp" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseAtk" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseDef"  class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">0 이상의 숫자를 입력하세요!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (스피드)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSpd" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>						
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (특수공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSatk" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 기본 종족치 (특수방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketBaseSdef"  class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (HP)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortHp" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortAtk"  class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortDef" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (스피드)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSpd" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (특수공격)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSatk" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 노력치 (특수방어)</span>
					</div>
					<div class="pocket-input-box">
						<input name="pocketEffortSdef" class="form-input">
						<span class="valid-message">사용 가능합니다!</span>
						<span class="invalid-message">1 이상의 숫자를 입력하세요!</span>	
					</div>
				</div>
				<div>
					<div class="pocket-input-box">
						<span>포켓몬스터 속성 1</span>
					</div>
						<div class="pocket-input-box">
							<select name="typeJoinNo" class="form-input neutral">
								<c:forEach var="i" begin="0" end="${typeList.size()-1}">
									<option value="${typeList.get(i).pocketTypeNo}">${typeList.get(i).pocketTypeNo}.${typeList.get(i).pocketTypeName}</option>
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
								<c:forEach var="i" begin="0" end="${typeList.size()-1}">
									<option value="${typeList.get(i).pocketTypeNo}">${typeList.get(i).pocketTypeNo}.${typeList.get(i).pocketTypeName}</option>
								</c:forEach>
							</select>
							<span class="invalid-message">타입1, 타입2을 같은 타입으로 설정할 수 없습니다 </span>
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