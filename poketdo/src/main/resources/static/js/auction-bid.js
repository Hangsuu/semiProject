$(function(){
	var params = new URLSearchParams(location.search);
	var allboardNo = params.get("allboardNo");
	
	getMinPrice();
	getMaxPrice();
	isFinish();
	if(memberId) getMyPoint();

	function isFinish(){
		$.ajax({
			url:contextPath+"/rest/auction/complete/"+allboardNo,
			method:"get",
			success:function(response){
				if(response){
					$(".bid-form").hide();
					$(".ing-auction").hide();
					$(".finished-auction").show();
					
				/* ---- 구매자, 판매자 창 ---- */
					if(memberId==boardWriter || memberId==$(".finish-bid-id").val()){
						var template = $("#auction-delivery-template").html();
						var html = $.parseHTML(template);
						$(html).find(".finish-bid-nick").text($(".final-last-bid").text());
						if(memberId==boardWriter){
							$(html).find(".send-message").attr("href", "/message/write?recipient="+$(".finish-bid-id").val())
						}
						else{
							$(html).find(".send-message").attr("href", "/message/write?recipient="+boardWriter);
						}
						if(auctionFinish==0){
							$(html).find(".delivery-btn").click(delivery);
							$(html).find(".finish-btn").click(finish);
						}
						else if(auctionFinish==1){
							$(html).find(".delivery-btn").removeClass("negative").addClass("neutral").text("배송 시작");
							$(html).find(".finish-btn").click(finish);
						}
						else{
							$(html).find(".delivery-btn").removeClass("negative").addClass("neutral").text("배송 시작");
							$(html).find(".finish-btn").removeClass("negative").addClass("neutral");
						}
						$(".finish-target").append(html);
					}
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
			url:contextPath+"/rest/auction/min/"+allboardNo,
			method:"get",
			success:function(response){
				if(response.auctionWithNickDto.memberNick!=null){
					$(".bid-info").show();
					$(".min-bid-price").text(response.auctionWithNickDto.auctionMinPrice);
					if(response.auctionBidWithNickDto!=null){
						$(".bid-info").show();
						$(".final-price").text(response.auctionBidWithNickDto.auctionBidPrice);
						$(".last-bid-nick").text(response.auctionBidWithNickDto.memberNick);
						$(".last-bid-seal").attr("src", response.auctionBidWithNickDto.urlLink);
						$(".final-last-bid").text(response.auctionBidWithNickDto.memberNick)
							.prepend($("<img>").addClass("board-seal").attr("src", response.auctionBidWithNickDto.urlLink).css("vertical-align","middle"));
						$(".send-message").attr("href", "/message/write?recipient="+response.auctionBidWithNickDto.auctionBidMember)
						$(".finish-bid-id").val(response.auctionBidWithNickDto.auctionBidMember)
					}
					else{
						$(".bid-info").hide();
					}
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
			url:contextPath+"/rest/auction/max/"+allboardNo,
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
		var regex = /^[0-9]*$/;
		if(!regex.test($("[name=auctionBidPrice]").val())){
			$("[name=auctionBidPrice]").val("")
			alert("숫자를 입력하세요")
			return;
		}
		if(!memberId){
			alert("로그인 후 이용하세요");
			return;
		}
		if(memberId==boardWriter){
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
			if($(".last-bid-nick").text().length>0){
				if(parseInt(enterPrice)<=parseInt(minPrice)){
					alert("최소 금액 이상 입찰하세요");
					return;
				}
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
					url:contextPath+"/rest/auction/",
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
			url:contextPath+"/rest/member/point/"+memberId,
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
	
	function finish(){
		if(memberId==null || memberId!=$(".finish-bid-id").val() || $(this).hasClass("neutral")){
			return;
		}
		if(!confirm("정말로 거래 완료 처리 하시겠습니까?\n확정 후에는 되돌릴 수 없습니다.")){
			return;
		}
		$.ajax({
			url:contextPath+"/rest/auction/finish/"+allboardNo,
			method:"get",
			success:function(){
				$(".finish-btn").removeClass("negative").addClass("neutral");
			},
			error:function(){
				
			}
		})
	};
	function delivery(){
		if(memberId==null || memberId!=boardWriter){
			return;
		}
		if(!confirm("배송 시작 상태로 변경하시겠습니까?")){
			return;
		}
		$.ajax({
			url:contextPath+"/rest/auction/delivery/"+allboardNo,
			method:"get",
			success:function(){
				$(".delivery-btn").removeClass("negative").addClass("neutral").text("배송 시작");
				auctionFinish=2;
			},
			error:function(){
				
			}
		})
	};
});