//회원 가입 페이지 유효성 검사 모듈
//- jQuery가 반드시 필요

$(function(){
	//검사 결과 저장 객체
	var valid = {
		memberIdValid:false,			//아이디	(형식+중복)
		memberPwValid:false,		//비밀번호(형식)
		memberPwReValid:false,		//비밀번호 확인(일치)
		memberNickValid:false,		//닉네임(형식+중복)
		memberBirthValid:false,		//생년월일(형식)
		isAllValid:function(){
			return this.memberIdValid
						&& this.memberPwValid
						&& this.memberPwReValid
						&& this.memberNickValid
						&& this.memberBirthValid
		}
	};
	
	//아이디 검사
	//[1] 형식 검사
	//[2] 형식 검사 통과 시 중복 검사
	$("[name=memberId]").blur(function(){
		var regex = /^[a-z][a-z0-9]{7,19}$/;
		var memberId = $(this).val();
		var isValid = regex.test(memberId);
		
		valid.memberIdValid = isValid;
		
		if(isValid) {
			$.ajax({
				url:contextPath+"/rest/member/memberId/" + memberId,
				method:"get",
				success:function(response) {//성공시 Y/N
					if(response == "Y") {//사용 가능한 아이디 -> valid
						valid.memberIdValid = true;
						$("[name=memberId]")
									.removeClass("valid invalid invalid2")
									.addClass("valid");
					}
					else {//사용중인 아이디 -> invalid2
						valid.memberIdValid = false;
						$("[name=memberId]")
									.removeClass("valid invalid invalid2")
									.addClass("invalid2");
					}
				},
				error:function(){//통신 오류 발생 시
					alert("오류가 발생했습니다\n잠시 후 시도하세요");
					valid.memberIdValid = false;
				}
			});
		}
		else {//아이디가 형식에 맞지 않는 경우 -> invalid
			$(this).removeClass("valid invalid invalid2")
						.addClass("invalid");
		}
	});
	
	//비밀번호 검사
	$("[name=memberPw]").blur(function(){
		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
		var isValid = regex.test($(this).val());
		
		valid.memberPwValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//비밀번호 확인 검사
	$("#passwordRe").blur(function(){
		var memberPw = $("[name=memberPw]").val();
		var memberPwRe = $(this).val();
		
		var isEmpty = memberPw.length == 0;
		var isValid = memberPw == memberPwRe;
		
		valid.memberPwReValid = !isEmpty && isValid;
		
		$(this).removeClass("valid invalid invalid2");
		if(isEmpty) {//비밀번호 미입력 시 invalid2 → .invalid-message2
			$(this).addClass("invalid2");
		}
		else if(isValid) {//일치할 경우 valid → .valid-message
			$(this).addClass("valid");
		}
		else {//불일치할 경우 invalid → .invalid-message
			$(this).addClass("invalid");
		}
	});
	
	//닉네임 검사
	$("[name=memberNick]").blur(function(){
		var regex = /^[가-힣0-9]{2,10}$/;
		var target = $(this);
		var memberNick = target.val();
		var isValid = regex.test(memberNick);
		
		valid.memberNickValid = isValid;
		if(!isValid) {//형식 오류 -> invalid
			target.removeClass("valid invalid invalid2")
						.addClass("invalid");
			return;
		}
		
		$.ajax({
			url:contextPath+"/rest/member/memberNick/"+memberNick,
			method:"get",
			success:function(response){//Y 또는 N
				if(response == "Y") {//사용가능 -> valid
					valid.memberNickValid = true;
					target.removeClass("valid invalid invalid2")
								.addClass("valid");
				}
				else {//사용중 -> invalid2
					valid.memberNickValid = false;
					target.removeClass("valid invalid invalid2")
								.addClass("invalid2");
				}
			},
			error:function(){
				alert("통신 오류 발생");
				valid.memberNickValid = false;
			},
		});
	});

	
	//생년월일 검사
	$("[name=memberBirth]").on("input", function(){
		var regex = /^(19[0-9]{2}|20[0-9]{2})-((02)-(0[1-9]|[12][0-9])|(0[469]|11)-(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))$/;
		var isValid = regex.test($(this).val());
		
		valid.memberBirthValid = isValid;
		
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	

	
	//폼 검사
	$(".join-form").submit(function(e){
		console.table(valid);
//		if(valid.isAllValid() == false) {//입력된 값이 마음에 안들면
//			e.preventDefault();
//		}
		return valid.isAllValid();
	});
});


