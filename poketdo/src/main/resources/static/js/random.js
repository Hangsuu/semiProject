$(function(){
	
var randomNum = Math.floor(Math.random() * 1008) + 1; // 1~1008 중 랜덤한 숫자 선택

	$.ajax({
		url:"/rest/pocketmon/pocketmonWithdImage/" + randomNum,
		method:"get",
		success:function(response){
$('.home-board-list').children().eq(0).html('<span style="font-size: 18px; color: gray;">' + 'No.0'+response.pocketNo + '</span>');

    // 2번째 자식 div에 span 태그와 response.pocketName 값 추가
    $('.home-board-list').children().eq(1).html('<span style="font-size: 20px; color: #555555; font-weight:600;">' + response.pocketName + '</span>');
    
    // 3번째 자식 div에 img 태그와 response.getImageURL 값 추가
    $('.home-board-list').children().eq(2).html('<img style="width:300px; height:300px; margin:0 auto;" src=' + response.imageURL + '>');
		},
		error:function(){//통신 오류
			alert("오류가 발생했습니다\n잠시 후 시도하세요");
			valid.pocketNoValid = false;
		}
	});


function refreshPage() {
  var newNum = Math.floor(Math.random() * 1008) + 1; // 1~1008 중 랜덤한 숫자 선택
  while (newNum === randomNum) {
    newNum = Math.floor(Math.random() * 1008) + 1; // 중복되지 않는 새로운 숫자 선택
  }
  randomNum = newNum; // 새로운 숫자 저장
  
	$.ajax({
		url:"/rest/pocketmon/pocketmonWithdImage/" + randomNum,
		method:"get",
		success:function(response){
			$('.home-board-list').children().eq(0).html('<span>' + response.pocketNo + '</span>');
    
    // 2번째 자식 div에 span 태그와 response.pocketName 값 추가
    $('.home-board-list').children().eq(1).html('<span>' + response.pocketName + '</span>');
    
    // 3번째 자식 div에 img 태그와 response.getImageURL 값 추가
    $('.home-board-list').children().eq(2).html('<img src=' + response.imageURL + '>');
		},
		error:function(){//통신 오류
			alert("오류가 발생했습니다\n잠시 후 시도하세요");
			valid.pocketNoValid = false;
		}
	});
	
}


setInterval(refreshPage, 50000); // 10초마다 갱신
	
});