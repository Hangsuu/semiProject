$(function(){
		//검사 결과 저장
		var valid = {
				pocketTypeNoValid:true,
				pocketTypeNameValid:true,
				isAllValid:function(){
					return this.pocketTypeNoValid
								&& this.pocketTypeNameValid;
				}
		};
		
		//기존에 사용중이던 이름 다시 입력할 경우 체크
		var existingTypeName = $("input[name='pocketTypeName']").val();
	
		//포켓몬 이름 중복 검사
		$("[name=pocketTypeName]").blur(function(){
			var pocketTypeName = $(this).val(); 
			var check =  pocketTypeName === existingTypeName;
				if(pocketTypeName!=""){
					if(check){
					valid.pocketTypeNameValid = true;
								$("[name=pocketTypeName]")
									.removeClass("valid invalid invalid2")
									.addClass("valid");
					}
					else{
					$.ajax({
						url:"/rest/pocketmon/pocketTypeName/" + pocketTypeName,
						method:"get",
						success:function(response){//성공시 Y 실패시 N
							if(response =="Y"){ //사용 가능할 경우
								valid.pocketTypeNameValid = true;
								$("[name=pocketTypeName]")
													.removeClass("valid invalid invalid2")
													.addClass("valid");
							}
							else { //사용 불가한 경우
								valid.pocketTypeNameValid = false;
								$("[name=pocketTypeName]")
													.removeClass("valid invalid invalid2")
													.addClass("invalid2");
							}
								
						},
						error:function(){//통신 오류
							alert("오류가 발생했습니다\n잠시 후 시도하세요");
							valid.pocketTypeNameValid = false;
						}
					});
					};
					}
					else{
						valid.pocketTypeNameValid = false;
						$(this)
						.removeClass("valid invalid invalid2")
						.addClass("invalid");
					}
		});
		
		
		//폼 검사
		$(".pocket-form").submit(function(e){
			return valid.isAllValid();
		});
	});
		