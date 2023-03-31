$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo");
	
	getMinPrice();
	getMaxPrice();
	isFinish();
	function isFinish(){
		$.ajax({
			url:"/rest/auction/complete/"+allboardNo,
			method:"get",
			success:function(response){
				if(response){
					$(".bid-form").hide();
					$(".ing-auction").hide();
					$(".finished-auction").show();
					return true;
				}
				else {
					$(".finished-auction").hide();
					$(".bid-form").show();
					$(".ing-auction").show();
					return false;
				}
			}
		});
	}
	function getMinPrice(){
		$.ajax({
			url:"/rest/auction/min/"+allboardNo,
			method:"get",
			success:function(response){
				$(".min-bid-price").text(response);
				$(".final-price").text(response);
			}
		});			
	};
	function getMaxPrice() {
		$.ajax({
			url:"/rest/auction/max/"+allboardNo,
			method:"get",
			success:function(response){
				if(response==0){
					$(".max-bid-price").text("무제한");
				}
				else{
					$(".max-bid-price").text(response);
				}
			}
		});			
	};
	
	$(".bid-btn").click(function(){
		if(!memberId){
			alert("로그인 후 이용하세요");
			return;
		}
		if(memberId==$(".auction-writer").text()){
			$(".form-bid").get(0).reset();
			alert("작성자는 입찰을 할 수 없습니다");
			return;
		}
		if(isFinish()){
			$(".form-bid").get(0).reset();
			alert("이미 종료된 경매입니다");
			return;
		}

		if(confirm("입찰하시겠습니까? 선택 후에는 되돌릴 수 없습니다.")){
			var data = $(".form-bid").serialize();
			var enterPrice = $("[name=auctionBidPrice]").val();
			var minPrice = $(".min-bid-price").text();
			var maxPrice = $(".max-bid-price").text();
			$(".form-bid").get(0).reset();
			if(parseInt(enterPrice)<=parseInt(minPrice)){
				alert("최소 금액 이상 입찰하세요");
			}
			else if(parseInt(enterPrice)>parseInt(maxPrice)){
				alert("최대 입찰금액 이상입니다");
			}
			else{
				$.ajax({
					url:"/rest/auction/",
					method:"post",
					data:data,
					success:function(){
						getMinPrice();
						isFinish();
					},
				});
			}
		}
	});
});