<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
$(function(){
	var index=301;
	var pocketNo=0;
	var pocketBaseHp=0;
	var pocketBaseAtk=0;
	var pocketBaseDef=0;
	var pocketBaseSatk=0;
	var pocketBaseSdef=0;
	var pocketBaseSpd=0;
	var pocketEffortHp=0;
	var pocketEffortAtk=0;
	var pocketEffortDef=0;
	var pocketEffortSatk=0;
	var pocketEffortSdef=0;
	var pocketEffortSpd=0;
	var type1="";
	var type2="";
	function autoInsert(){
		var url = "https://pokeapi.co/api/v2/pokemon/"+index+"/";
		$.ajax({
			url:url,
			method:"get",
			success:function(response){
				pocketNo = index;
				pocketBaseHp = response.stats[0].base_stat;
				pocketBaseAtk = response.stats[1].base_stat;
				pocketBaseDef = response.stats[2].base_stat;
				pocketBaseSatk = response.stats[3].base_stat;
				pocketBaseSdef = response.stats[4].base_stat;
				pocketBaseSpd = response.stats[5].base_stat;
				pocketEffortHp = response.stats[0].effort;
				pocketEffortAtk = response.stats[1].effort;
				pocketEffortDef = response.stats[2].effort;
				pocketEffortSatk = response.stats[3].effort;
				pocketEffortSdef = response.stats[4].effort;
				pocketEffortSpd = response.stats[5].effort;
				type1 = response.types[0].type.url;
				type1 = type1.replace("https://pokeapi.co/api/v2/type/","")
				type1 = type1.replace("/","");
				if(response.types[1]!=null){
					type2 = response.types[1].type.url;
					type2 = type2.replace("https://pokeapi.co/api/v2/type/","")
					type2 = type2.replace("/","");
				}
				else{
					type2="";
				}	
				setTimeout(function(){
			 		$.ajax({
						url:"/rest/pocketmon/",
						method:"post",
						data:{
							pocketNo:pocketNo,
							pocketBaseHp:pocketBaseHp,
							pocketBaseAtk:pocketBaseAtk,
							pocketBaseDef:pocketBaseDef,
							pocketBaseSatk:pocketBaseSatk,
							pocketBaseSdef:pocketBaseSdef,
							pocketBaseSpd:pocketBaseSpd,
							pocketEffortHp:pocketEffortHp,
							pocketEffortAtk:pocketEffortAtk,
							pocketEffortDef:pocketEffortDef,
							pocketEffortSatk:pocketEffortSatk,
							pocketEffortSdef:pocketEffortSdef,
							pocketEffortSpd:pocketEffortSpd,
							typeJoinNo1:type1,
							typeJoinNo2:type2,
						},
						success:function(response){
							pocketNo=0;
							pocketBaseHp=0;
							pocketBaseAtk=0;
							pocketBaseDef=0;
							pocketBaseSatk=0;
							pocketBaseSdef=0;
							pocketBaseSpd=0;
							pocketEffortHp=0;
							pocketEffortAtk=0;
							pocketEffortDef=0;
							pocketEffortSatk=0;
							pocketEffortSdef=0;
							pocketEffortSpd=0;
							type1="";
							type2="";
							console.log(index)
							index++;
						},
						error:function(){
							alert("에러");
						}
					});
				}, 1000)
			},
			error:function(){
				alert("api에러");
			},
		});
	};
	$(".auto-btn").click(function(){
		setInterval(autoInsert, 1000+Math.floor(Math.random()*500));
		if(index==1009) return;
	});
});
</script>
	<h1>등록페이지 입니다~</h1>
	<form action="insertProcess" method="post" enctype="multipart/form-data" class="form">
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
		<select name="typeJoinNo1" class="type1">
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
		<select name="typeJoinNo2" class="type2">
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
		
		<label>포켓몬스터 이미지(png, gif, jpg)</label>
		<input type="file" name="attach" accept=".png, .gif, .jpg">
		<br>
		<button>입력 완료</button>
	</form>
	<button class="auto-btn">자동입력</button>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>