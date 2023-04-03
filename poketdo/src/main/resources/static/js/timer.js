$(function(){
	function timer(){
		$(".rest-time").each(function(){
			var now = new Date();
			var nowTime = now.getTime();
			var time = $(this).data("finish-time");
			var timeDif = time-nowTime;
			var days = Math.floor(timeDif/1000/60/60/24)%10;
			var hour = Math.floor(timeDif/1000/60/60)%24;
			var min = Math.floor(timeDif/1000/60)%60;
			var sec = Math.floor(timeDif/1000)%60;
			if(timeDif/1000/60/60/24>=1) {
				$(this).text("남은시간 : "+days+"일");
			}
			else if(timeDif/1000/60/60>=1) {
				$(this).text("남은시간 : "+hour+"시간");
			}
			else if(timeDif>0) {
				$(this).text("남은시간 : "+min+":"+String(sec).padStart(2, '0'));
			}
			else {
				$(this).text("종료된 상품");
			}
		});
	}
	setInterval(timer, 1000);
});