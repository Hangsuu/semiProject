<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


	<h1>포켓몬스터 정보 수정 페이지~</h1>
	<form action="editProcess" method="post" enctype="multipart/form-data">
		<label>포켓몬스터 번호 : ${pocketmonDto.pocketNo}</label>
		<input type="hidden" name="pocketNo" value="${pocketmonDto.pocketNo}"> 
		
		<br>
		
		<label>포켓몬스터 이름</label>
		<input name="pocketName" value="${pocketmonDto.pocketName}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (HP)</label>
		<input name="pocketBaseHp" value="${pocketmonDto.pocketBaseHp}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (공격)</label>
		<input name="pocketBaseAtk" value="${pocketmonDto.pocketBaseAtk}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (방어)</label>
		<input name="pocketBaseDef" value="${pocketmonDto.pocketBaseDef}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (스피드)</label>
		<input name="pocketBaseSpd" value="${pocketmonDto.pocketBaseSpd}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (특수공격)</label>
		<input name="pocketBaseSatk" value="${pocketmonDto.pocketBaseSatk}">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (특수방어)</label>
		<input name="pocketBaseSdef" value="${pocketmonDto.pocketBaseSdef}">
		
		<br>
		
		<label>포켓몬스터 노력치 (HP)</label>
		<input name="pocketEffortHp" value="${pocketmonDto.pocketEffortHp}">
		
		<br>
		
		<label>포켓몬스터 노력치 (공격)</label>
		<input name="pocketEffortAtk" value="${pocketmonDto.pocketEffortAtk}">
		
		<br>
		
		<label>포켓몬스터 노력치 (방어)</label>
		<input name="pocketEffortDef" value="${pocketmonDto.pocketEffortDef}">
		
		<br>
		
		<label>포켓몬스터 노력치 (스피드)</label>
		<input name="pocketEffortSpd" value="${pocketmonDto.pocketEffortSpd}">
		
		<br>
		
		<label>포켓몬스터 노력치 (특수공격)</label>
		<input name="pocketEffortSatk" value="${pocketmonDto.pocketEffortSatk}">
		
		<br>
		
		<label>포켓몬스터 노력치 (특수방어)</label>
		<input name="pocketEffortSdef" value="${pocketmonDto.pocketEffortSdef}">
		
		<br>
		
		<label>포켓몬스터 속성 1</label>

		<select name="typeJoinNo">
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
		
		<br>
			
		<label>포켓몬스터 속성 2</label>
			<select name="typeJoinNo2">
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
		
		<br>
		
		<label>포켓몬스터 이미지(png, gif, jpg)</label>
		<input type="file" name="attach" accept=".png, .gif, .jpg">
		<br>
		<button>입력 완료</button>
	</form>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
