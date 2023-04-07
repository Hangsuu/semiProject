$(function(){
		//검사 결과 저장
		var valid = {
				sealNoValid:false,
				sealNameValid:false,
				sealPriceValid:false,
				isAllValid:function(){
					return this.sealNoValid
								&& this.sealNameValid
								&& this.sealPriceValid;
				}
		};
		
		//인장 번호 검사 (1보다 큰 숫자)
		$("[name=sealNo]").blur(function(){
			var sealNo = $(this).val(); 
			var isValid = sealNo >= 0 && sealNo!="";
			
			if(isValid){
					console.log(isValid);
				$.ajax({
					url:contextPath+"/rest/seal/sealNo/" + sealNo,
					method:"get",
					success:function(response){//성공시 Y 실패시 N
						if(response =="Y"){ //사용 가능할 경우
							valid.sealNoValid = true;
							$("[name=sealNo]")
												.removeClass("valid invalid invalid2")
												.addClass("valid");
						}
						else { //사용 불가한 경우
							valid.sealNoValid = false;
							$("[name=sealNo]")
												.removeClass("valid invalid invalid2")
												.addClass("invalid2");
						}
							
					},
					error:function(){//통신 오류
						alert("오류가 발생했습니다\n잠시 후 시도하세요");
						valid.sealNoValid = false;
					}
				});
			}
		
			else{//형식에 맞지않는경우
				$(this)
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			};
		});
		//인장 이름 중복 검사
		$("[name=sealName]").blur(function(){
			var sealName = $(this).val(); 
			
			if(sealName != ""){
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
				}
			else{//형식에 맞지않는경우
				valid.sealNameValid = false;
				$(this)
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}	
		});
		//인장 가격 검사(숫자)
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
		