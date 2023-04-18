$(function(){
		//검사 결과 저장
		var valid = {
				pocketTypeNoValid:false,
				pocketTypeNameValid:false,
				isAllValid:function(){
					return this.pocketTypeNoValid
								&& this.pocketTypeNameValid;
				}
		};
		
		
		//포켓몬 타입 번호 검사 (1보다 큰 숫자)
		$("[name=pocketTypeNo]").blur(function(){
			var pocketTypeNo = $(this).val(); 
			var isValid = pocketTypeNo >= 1;
			if(isValid){
				$.ajax({
					url:contextPath+"/rest/pocketmon/pocketTypeNo/" + pocketTypeNo,
					method:"get",
					success:function(response){//성공시 Y 실패시 N
						if(response =="Y"){ //사용 가능할 경우
							valid.pocketTypeNoValid = true;
							$("[name=pocketTypeNo]")
												.removeClass("valid invalid invalid2")
												.addClass("valid");
						}
						else { //사용 불가한 경우
							valid.pocketTypeNoValid = false;
							$("[name=pocketTypeNo]")
												.removeClass("valid invalid invalid2")
												.addClass("invalid2");
						}
							
					},
					error:function(){//통신 오류
						alert("오류가 발생했습니다\n잠시 후 시도하세요");
						valid.pocketTypeNoValid = false;
					}
				});
			}
		
			else{//형식에 맞지않는경우
				$(this)
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			};
		});
		//포켓몬 타입 이름 중복 검사
		$("[name=pocketTypeName]").blur(function(){
			var pocketTypeName = $(this).val(); 
			
			if(pocketTypeName != ""){
				$.ajax({
					url:contextPath+"/rest/pocketmon/pocketTypeName/" + pocketTypeName,
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
				}
			else{//형식에 맞지않는경우
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
		