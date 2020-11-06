document.addEventListener("turbolinks:load", function() {
  var mySwiper = new Swiper('.swiper-container', {

  pagination: {
    el: '.swiper-pagination',
  },

  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  slidesPerView: 3,
  loop: true,

  scrollbar: {
    el: '.swiper-scrollbar',
  },
  
  })
});
