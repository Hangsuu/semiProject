$(function(){
	
	var previousNumber = null; // 이전에 선택된 숫자

	setInterval(function() {
	  var randomNumber = Math.floor(Math.random() * 1008) + 1;
	  // 1~1008 중 랜덤한 숫자 선택
	  while (randomNumber === previousNumber) {
	    randomNumber = Math.floor(Math.random() * 1008) + 1;
	    // 이전에 선택된 숫자와 중복되지 않도록 새로운 숫자 선택
	  }
	  previousNumber = randomNumber;
	  // 이전에 선택된 숫자를 업데이트하지 않음
	  location.reload();
	  
	  // 브라우저 화면 새로고침
	  console.log(randomNumber);
	}, 10000); // 10초마다 실행
	
	
	
	
	
});