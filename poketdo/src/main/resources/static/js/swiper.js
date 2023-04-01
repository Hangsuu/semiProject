$(function(){
	const swiper = new Swiper(".swiper", {
		// Optional parameters
		//한 화면에 포함하는 슬라이드 개수
		slidesPerView: 5,
		//좌우 버튼 누르면 움직이는 슬라이드 개수
		slidesPerGroup:1,
		//슬라이드간 간격
		spaceBetween: 0,
		
		direction: "horizontal",
		//루프할지 여부
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
});