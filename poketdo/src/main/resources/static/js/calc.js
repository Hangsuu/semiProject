$(function () {
   $(".pocketmon-img").hide();

$(".monster-search").click(function(){
	$.ajax({
		url:"https://pokeapi.co/api/v2/pokemon-species/" + $("[name=pocketmonNumber]").val() + "/",
		method:"get",
		success:function(response){
			$(".korean-name").text(response.names[2].name);
		},
	});
	$.ajax({
		url:"https://pokeapi.co/api/v2/pokemon/" + $("[name=pocketmonNumber]").val() + "/",
		method:"get",
		success:function(response){
			$("[name=baseHp]").val(response.stats[0].base_stat);
			$("[name=baseAtk]").val(response.stats[1].base_stat);
			$("[name=baseDef]").val(response.stats[2].base_stat);
			$("[name=baseSpAtk]").val(response.stats[3].base_stat);
			$("[name=baseSpDef]").val(response.stats[4].base_stat);
			$("[name=baseSpd]").val(response.stats[5].base_stat);
			$("[name=effortHp]").val(response.stats[0].effort);
			$("[name=effortAtk]").val(response.stats[1].effort);
			$("[name=effortDef]").val(response.stats[2].effort);
			$("[name=effortSpAtk]").val(response.stats[3].effort);
			$("[name=effortSpDef]").val(response.stats[4].effort);
			$("[name=effortSpd]").val(response.stats[5].effort);

               $(".pocketmon-img").attr("src", response["sprites"]["other"]["official-artwork"]["front_default"]).show();
		},
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