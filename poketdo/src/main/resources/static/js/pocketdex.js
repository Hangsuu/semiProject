	$(function(){
		$(".pocket-left").mouseenter(function() {
			$(this).find("i").addClass('fa-shake');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-shake');
		});
		$(".pocket-right").mouseenter(function() {
			$(this).find("i").addClass('fa-shake');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-shake');
		});
		$(".bottom-list-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
		$(".bottom-edit-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
		$(".bottom-delete-icon").mouseenter(function() {
			$(this).find("i").addClass('fa-beat');
		}).mouseleave(function(){
			$(this).find("i").removeClass('fa-beat');
		});
        $(".confirm-delete").click(function(e){
            e.preventDefault();
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            window.location.href = $(this).attr("href");
           
        });
		
	});	