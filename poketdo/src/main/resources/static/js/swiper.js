$(function(){
	const swiper = new Swiper(".swiper", {
		// Optional parameters
		slidesPerView: 5,
		slidesPerGroup:1,
		spaceBetween: 0,
		
		direction: "horizontal",
		loop: true,
		//오른쪽에 미리 대기하는 개수
		loopAdditionalSlides: 5,
		loopedSlides: 5,
		// If we need pagination
	//	pagination: {
	//	  el: ".swiper-pagination",
	//	},
		
	// Navigation arrows
		navigation: {
		  nextEl: ".swiper-button-next",
		  prevEl: ".swiper-button-prev",
		},
		
		// And if we need scrollbar
		// scrollbar: {
		//   el: ".swiper-scrollbar",
		// },
		maxBackfaceHiddenSlides:20,
	});
	
	$(".swiper-button-prev").click(function(){
		swiper.slidePrev();
	});
	$(".swiper-button-next").click(function(){
		swiper.slideNext();
	});
});