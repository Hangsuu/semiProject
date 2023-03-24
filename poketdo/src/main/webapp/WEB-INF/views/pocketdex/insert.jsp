<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포켓몬스터 등록</title>
</head>
<body>
	<h1>등록페이지 입니다~</h1>
	<form action="insertProcess" method="post">
		<label>포켓몬스터 번호</label>
		<input name="pocketNo">
		
		<br>
		
		<label>포켓몬스터 이름</label>
		<input name="pocketName">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (HP)</label>
		<input name="pocketBaseHp">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (공격)</label>
		<input name="pocketBaseAtk">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (방어)</label>
		<input name="pocketBaseDef">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (스피드)</label>
		<input name="pocketBaseSpd">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (특수공격)</label>
		<input name="pocketBaseSatk">
		
		<br>
		
		<label>포켓몬스터 기본 종족치 (특수방어)</label>
		<input name="pocketBaseSdef">
		
		<br>
		
		<label>포켓몬스터 노력치 (HP)</label>
		<input name="pocketEffortHp">
		
		<br>
		
		<label>포켓몬스터 노력치 (공격)</label>
		<input name="pocketEffortAtk">
		
		<br>
		
		<label>포켓몬스터 노력치 (방어)</label>
		<input name="pocketEffortDef">
		
		<br>
		
		<label>포켓몬스터 노력치 (스피드)</label>
		<input name="pocketEffortSpd">
		
		<br>
		
		<label>포켓몬스터 노력치 (특수공격)</label>
		<input name="pocketEffortSatk">
		
		<br>
		
		<label>포켓몬스터 노력치 (특수방어)</label>
		<input name="pocketEffortSdef">
		
		<br>
		
		<label>포켓몬스터 속성 1</label>
		<select name="typeJoinNo">
			<option value="">선택하세요</option>
			<option value="1">1. 노말</option>
			<option value="2">2. 격투</option>
			<option value="3">3. 비행</option>
			<option value="4">4. 독</option>
			<option value="5">5. 땅</option>
			<option value="6">6. 바위</option>
			<option value="7">7. 벌레</option>
			<option value="8">8. 고스트</option>
			<option value="9">9. 강철</option>
			<option value="10">10. 불꽃</option>
			<option value="11">11. 물</option>
			<option value="12">12. 풀</option>
			<option value="13">13. 전기</option>
			<option value="14">14. 에스퍼</option>
			<option value="15">15. 얼음</option>
			<option value="16">16. 드래곤</option>
			<option value="17">17. 악</option>
			<option value="18">18. 페어리</option>
		</select>
		
		<br>
			
		<label>포켓몬스터 속성 2</label>
		<select name="typeJoinNo">
			<option value="">선택하세요</option>
			<option value="1">1. 노말</option>
			<option value="2">2. 격투</option>
			<option value="3">3. 비행</option>
			<option value="4">4. 독</option>
			<option value="5">5. 땅</option>
			<option value="6">6. 바위</option>
			<option value="7">7. 벌레</option>
			<option value="8">8. 고스트</option>
			<option value="9">9. 강철</option>
			<option value="10">10. 불꽃</option>
			<option value="11">11. 물</option>
			<option value="12">12. 풀</option>
			<option value="13">13. 전기</option>
			<option value="14">14. 에스퍼</option>
			<option value="15">15. 얼음</option>
			<option value="16">16. 드래곤</option>
			<option value="17">17. 악</option>
			<option value="18">18. 페어리</option>
		</select>
		
		<br>
		
		<button>입력 완료</button>
	</form>
	
</body>
</html>