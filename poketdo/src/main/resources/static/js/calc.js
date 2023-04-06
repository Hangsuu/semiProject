$(function () {
  var shakeLeft = {
    // 이미지를 왼쪽으로 10픽셀 이동합니다.
    left: '-=20',
    // 애니메이션 속도를 0.5초로 설정합니다.
    duration: 20,
    // 애니메이션을 2번 반복합니다.
    // (한 번 왼쪽으로 흔들리고, 다시 오른쪽으로 흔들립니다.)
  };

$(".monster-search").click(function(){
	var name =$("[name=pocketmonNumber]").val().trim(); 
	if(name.length==0) {
		alert("이름을 입력하세요")
		return;
	}
	$(".pocketmon-img").animate(shakeLeft);
	$.ajax({
		url:"/rest/pocketmon/stats/"+name,
		method:"get",
		success:function(response){
			if(response.pocketBaseHp>0){
				$("[name=baseHp]").val(response.pocketBaseHp);
				$("[name=baseAtk]").val(response.pocketBaseAtk);
				$("[name=baseDef]").val(response.pocketBaseDef);
				$("[name=baseSpAtk]").val(response.pocketBaseSatk);
				$("[name=baseSpDef]").val(response.pocketBaseSdef);
				$("[name=baseSpd]").val(response.pocketBaseSpd);
				$("[name=effortHp]").val(response.pocketEffortHp);
				$("[name=effortAtk]").val(response.pocketEffortAtk);
				$("[name=effortDef]").val(response.pocketEffortDef);
				$("[name=effortSpAtk]").val(response.pocketEffortSatk);
				$("[name=effortSpDef]").val(response.pocketEffortSdef);
				$("[name=effortSpd]").val(response.pocketEffortSpd);
				var index = response.pocketNo;
			    $(".pocketmon-img").attr("src", "/attachment/download?attachmentNo="+index).show();
			}
			else{
				alert("정확한 포켓몬 이름을 입력하세요.")
			}
		},
		error:function(){
			alert("정확한 포켓몬 이름을 입력하세요.")
		}
	});
	
});

   $(".calc-btn").click(function(){
       var personalityJson = $("[name=personality]").val();
       var personality = JSON.parse(personalityJson);
       $(".get-hp").val(hpStatResult($("[name=baseHp]").val(), ($("[name=indiHp]").val()?$("[name=indiHp]").val():0), 
               $("[name=effortHp]").val(), ($("[name=addEffortHp]").val()?$("[name=addEffortHp]").val():0), $("[name=level]").val(), personality.hp));
       $(".get-atk").val(statResult($("[name=baseAtk]").val(), ($("[name=indiAtk]").val()?$("[name=indiAtk]").val():0), 
               $("[name=effortAtk]").val(), ($("[name=addEffortAtk]").val()?$("[name=addEffortAtk]").val():0), $("[name=level]").val(), personality.atk));
       $(".get-def").val(statResult($("[name=baseDef]").val(), ($("[name=indiDef]").val()?$("[name=indiDef]").val():0), 
               $("[name=effortDef]").val(), ($("[name=addEffortDef]").val()?$("[name=addEffortDef]").val():0), $("[name=level]").val(), personality.def));
       $(".get-spatk").val(statResult($("[name=baseSpAtk]").val(), ($("[name=indiSpAtk]").val()?$("[name=indiSpAtk]").val():0), 
               $("[name=effortSpAtk]").val(), ($("[name=addEffortSpAtk]").val()?$("[name=addEffortSpAtk]").val():0), $("[name=level]").val(), personality.spatk));
       $(".get-spdef").val(statResult($("[name=baseSpDef]").val(), ($("[name=indiSpDef]").val()?$("[name=indiSpDef]").val():0), 
               $("[name=effortSpDef]").val(), ($("[name=addEffortSpDef]").val()?$("[name=addEffortSpDef]").val():0), $("[name=level]").val(), personality.spdef));
       $(".get-spd").val(statResult($("[name=baseSpd]").val(), ($("[name=indiSpd]").val()?$("[name=indiSpd]").val():0), 
               $("[name=effortSpd]").val(), ($("[name=addEffortSpd]").val()?$("[name=addEffortSpd]").val():0), $("[name=level]").val(), personality.spd));
   });
   $(".need-write").blur(function(){
       var isValid = $(this).val()>=0 && $(this).val()<=31;
       if(!isValid){
           $(this).val("");
           $(this).attr("placeholder", "0~31 입력");
       }
   });
   $("[name=level]").blur(function(){
       var isValid = $(this).val()>=1 && $(this).val()<=99;
       if(!isValid){
           $(this).val("");
           $(this).attr("placeholder", "1~99 입력");
       }
   });
   $("[name=personality]").change(function(){
       var personalityJson = $("[name=personality]").val();
       var personality = JSON.parse(personalityJson);
       var personAtk = personality.atk;
       var personDef = personality.def;
       var personSpAtk = personality.spatk;
       var personSpDef = personality.spdef;
       var personSpd = personality.spd;
       $(".personal-atk").text(personAtk!="1"? " (X"+personAtk+")":"");
       $(".personal-def").text(personDef!="1"? " (X"+personDef+")":"");
       $(".personal-spatk").text(personSpAtk!="1"? " (X"+personSpAtk+")":"");
       $(".personal-spdef").text(personSpDef!="1"? " (X"+personSpDef+")":"");
       $(".personal-spd").text(personSpd!="1"? " (X"+personSpd+")":"");
   });
   function hpStatResult(base, indi, effort, addEffort, level, personality){
       base = parseInt(base);
       indi = parseInt(indi);
       effort = parseInt(effort);
       addEffort = parseInt(addEffort);
       level = parseInt(level);
       personality = parseFloat(personality);
       return Math.floor((Math.floor((base*2+indi+(effort+addEffort)/4+100)*level/100+10))*personality);
   }
   function statResult(base, indi, effort, addEffort, level, personality){
       base = parseInt(base);
       indi = parseInt(indi);
       effort = parseInt(effort);
       addEffort = parseInt(addEffort);
       level = parseInt(level);
       personality = parseFloat(personality);
       return Math.floor((Math.floor((base*2+indi+(effort+addEffort)/4)*level/100+5))*personality);
   }
 });