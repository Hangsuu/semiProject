$(function(){
		//검사 결과 저장
		var valid = {
				sealNoValid:true,
				sealNameValid:true,
				sealPriceValid:true,
				isAllValid:function(){
					return this.sealNoValid
								&& this.sealNameValid
								&& this.sealPriceValid;
				}
		};
		
		//기존에 사용중이던 이름 다시 입력할 경우 체크
		var existingTypeName = $("input[name='sealName']").val();
	
		//인장 이름 중복 검사
		$("[name=sealName]").blur(function(){
			var sealName = $(this).val(); 
			var check =  sealName === existingTypeName;
				if(sealName!=""){
					if(check){
					valid.sealNameValid = true;
								$("[name=sealName]")
									.removeClass("valid invalid invalid2")
									.addClass("valid");
					}
					else{
					$.ajax({
						url:contextPath+"/rest/seal/sealName/"+sealName,
						method:"get",
						success:function(response){//성공시 Y 실패시 N
							if(response =="Y"){ //사용 가능할 경우
								valid.sealNameValid = true;
								$("[name=sealName]")
													.removeClass("valid invalid invalid2")
													.addClass("valid");
							}
							else { //사용 불가한 경우
								valid.sealNameValid = false;
								$("[name=sealName]")
													.removeClass("valid invalid invalid2")
													.addClass("invalid2");
							}
								
						},
						error:function(){//통신 오류
							alert("오류가 발생했습니다\n잠시 후 시도하세요");
							valid.sealNameValid = false;
						}
					});
					};
					}
					else{
						valid.sealNameValid = false;
						$(this)
						.removeClass("valid invalid invalid2")
						.addClass("invalid");
					}
		});
			//인장 가격 입력 검사 (숫자)		
			$("[name=sealPrice]").blur(function(){
			var sealPrice = $(this).val();
			var regex = /^[0-9]+$/;
			var isValid = regex.test(sealPrice);
			valid.sealPriceValid = isValid;
				if(isValid){
					$("[name=sealPrice]")
						.removeClass("valid invalid invalid2")
						.addClass("valid");
				}else{
					$("[name=sealPrice]")
					.removeClass("valid invalid invalid2")
					.addClass("invalid");
				};
		});
		
		//폼 검사
		$(".seal-form").submit(function(e){
			return valid.isAllValid();
		});
	});
		