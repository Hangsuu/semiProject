$(function(){
		//검사 결과 저장
		var valid = {
				pocketNoValid:false,
				pocketNameValid:false,
				pocketBaseHpValid:false,
				pocketBaseAtkValid:false,
				pocketBaseDefValid:false,
				pocketBaseSpdValid:false,
				pocketBaseSatkValid:false,
				pocketBaseSdefValid:false,
				pocketEffortHpValid:false,
				pocketEffortAtkValid:false,
				pocketEffortDefValid:false,
				pocketEffortSpdValid:false,
				pocketEffortSatkValid:false,
				pocketEffortSdefValid:false,
				isAllValid:function(){
					return this.pocketNoValid
								&& this.pocketNameValid
								&& this.pocketBaseHpValid
								&& this.pocketBaseAtkValid
								&& this.pocketBaseDefValid
								&& this.pocketBaseSpdValid
								&& this.pocketBaseSatkValid
								&& this.pocketBaseSdefValid
								&& this.pocketEffortHpValid
								&& this.pocketEffortAtkValid
								&& this.pocketEffortDefValid
								&& this.pocketEffortSpdValid
								&& this.pocketEffortSatkValid
								&& this.pocketEffortSdefValid;
				}
		};
		
		
		//포켓몬 번호 검사 (1보다 큰 숫자)
		$("[name=pocketNo]").blur(function(){
			var pocketNo = $(this).val(); 
			var isValid = pocketNo >= 1;
			if(isValid){
				$.ajax({
					url:"/rest/pocketmon/pocketNo/" + pocketNo,
					method:"get",
					success:function(response){//성공시 Y 실패시 N
						if(response =="Y"){ //사용 가능할 경우
							valid.pocketNoValid = true;
							$("[name=pocketNo]")
												.removeClass("valid invalid invalid2")
												.addClass("valid");
						}
						else { //사용 불가한 경우
							valid.pocketNoValid = false;
							$("[name=pocketNo]")
												.removeClass("valid invalid invalid2")
												.addClass("invalid2");
						}
							
					},
					error:function(){//통신 오류
						alert("오류가 발생했습니다\n잠시 후 시도하세요");
						valid.pocketNoValid = false;
					}
				});
			}
		
			else{//형식에 맞지않는경우
				$(this)
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}	
		});
		//포켓몬 이름 중복 검사
		$("[name=pocketName]").blur(function(){
			var pocketName = $(this).val(); 
				$.ajax({
					url:"/rest/pocketmon/pocketName/" + pocketName,
					method:"get",
					success:function(response){//성공시 Y 실패시 N
						if(response =="Y"){ //사용 가능할 경우
							valid.pocketNameValid = true;
							$("[name=pocketName]")
												.removeClass("valid invalid invalid2")
												.addClass("valid");
						}
						else { //사용 불가한 경우
							valid.pocketNameValid = false;
							$("[name=pocketName]")
												.removeClass("valid invalid invalid2")
												.addClass("invalid2");
						}
							
					},
					error:function(){//통신 오류
						alert("오류가 발생했습니다\n잠시 후 시도하세요");
						valid.pocketNameValid = false;
					}
				});
		});
		
		//기본 종족치, 노력치 0 이상 숫자
		$("[name=pocketBaseHp]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseHpValid = isValid;
			if(isValid){
				$("[name=pocketBaseHp]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseHp]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketBaseAtk]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseAtkValid = isValid;
			if(isValid){
				$("[name=pocketBaseAtk]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseAtk]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketBaseDef]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseDefValid = isValid;
			if(isValid){
				$("[name=pocketBaseDef]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseDef]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketBaseSpd]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseSpdValid = isValid;
			if(isValid){
				$("[name=pocketBaseSpd]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseSpd]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketBaseSatk]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseSatkValid = isValid;
			if(isValid){
				$("[name=pocketBaseSatk]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseSatk]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}			
		});
		$("[name=pocketBaseSdef]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketBaseSdefValid = isValid;
			if(isValid){
				$("[name=pocketBaseSdef]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketBaseSdef]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortHp]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortHpValid = isValid;
			if(isValid){
				$("[name=pocketEffortHp]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortHp]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortAtk]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortAtkValid = isValid;
			if(isValid){
				$("[name=pocketEffortAtk]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortAtk]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortDef]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortDefValid = isValid;
			if(isValid){
				$("[name=pocketEffortDef]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortDef]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortSpd]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortSpdValid = isValid;
			if(isValid){
				$("[name=pocketEffortSpd]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortSpd]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortSatk]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortSatkValid = isValid;
			if(isValid){
				$("[name=pocketEffortSatk]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortSatk]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		$("[name=pocketEffortSdef]").blur(function(){
			var isValid = $(this).val() >= 0;
			valid.pocketEffortSdefValid = isValid;
			if(isValid){
				$("[name=pocketEffortSdef]")
					.removeClass("valid invalid invalid2")
					.addClass("valid");
			}else{
				$("[name=pocketEffortSdef]")
				.removeClass("valid invalid invalid2")
				.addClass("invalid");
			}
		});
		
		//폼 검사
		$(".pocket-form").submit(function(e){
			return valid.isAllValid();
		});
	});
		