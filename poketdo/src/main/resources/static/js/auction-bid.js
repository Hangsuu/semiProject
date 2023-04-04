$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo");
	
	getMinPrice();
	getMaxPrice();
	isFinish();
	$(".finish-btn").hide();
	if(memberId) getMyPoint();

	function isFinish(){
		$.ajax({
			url:"/rest/auction/complete/"+allboardNo,
			method:"get",
			success:function(response){
				if(response){
					$(".bid-form").hide();
					$(".ing-auction").hide();
					$(".finished-auction").show();
					if(memberId==boardWriter){
						$(".send-message").show();
					}
					else{
						$(".send-message").hide();
					}
					if(memberId!=null && memberId==$(".finish-bid-id").val()){
						$(".finish-btn").show();
					}
					return true;
				}
				else {
					$(".finished-auction").hide();
					$(".bid-form").show();
					$(".ing-auction").show();
					$(".send-message").hide();
					$(".finish-btn").hide();
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
				if(response.memberNick!=null){
					$(".bid-info").show();
					$(".min-bid-price").text(response.auctionBidPrice);
					$(".final-price").text(response.auctionBidPrice);
					$(".last-bid-nick").text(response.memberNick);
					$(".last-bid-seal").attr("src", response.urlLink);
					$(".final-last-bid").text(response.memberNick)
						.prepend($("<img>").addClass("board-seal").attr("src", response.urlLink));
					$(".send-message").attr("href", "/message/write?recipient="+response.auctionBidMember)
					$(".finish-bid-id").val(response.auctionBidMember)
				}
				else{
					$(".bid-info").hide();
					$(".min-bid-price").text("0");
					$(".final-price").text("0");
				}
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
			var myPoint = $(".my-point-input").val();
			$(".form-bid").get(0).reset();
			if(parseInt(enterPrice)<=parseInt(minPrice)){
				alert("최소 금액 이상 입찰하세요");
				return;
			}
			else if(parseInt(enterPrice)>parseInt(maxPrice)){
				alert("최대 입찰금액 이상입니다");
				return;
			}
			else if(parseInt(enterPrice)>parseInt(myPoint)){
				alert("보유 포인트 이내로 입찰하세요");
				return;
			}
			else{
				$.ajax({
					url:"/rest/auction/",
					method:"post",
					data:data,
					success:function(response){
						getMinPrice();
						isFinish();
						getMyPoint();
					},
				});
			}
		}
	});
	
	function getMyPoint(){
		$.ajax({
			url:"/rest/member/point/"+memberId,
			method:"get",
			success:function(response){
				$(".my-point").text("보유 : "+response+" 포인트");
				$(".my-point-input").val(response);
			},
			error:function(){
				alert("통신오류")
			}
		})
	}
	
	$(".finish-btn").click(function(){
		if(!confirm("정말로 거래 완료 처리 하시겠습니까?\n확정 후에는 되돌릴 수 없습니다.")){
			return;
		}
		$.ajax({
			url:"/rest/auction/finish/"+allboardNo,
			method:"get",
			success:function(){
				$(".finish-btn").remove();
			},
			error:function(){
				
			}
		})
	});
});