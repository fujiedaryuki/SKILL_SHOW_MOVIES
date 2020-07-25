// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var navigationOpenFlag = false;
var navButtonFlag = true;
var focusFlag = false;
 

    $(function(){
 
      $(document).on('click','.el_humburger',function(){
        if(navButtonFlag){
          spNavInOut.switch();
          
          setTimeout(function(){
            navButtonFlag = true;
          },200);
          navButtonFlag = false;
        }
      });
      $(document).on('click touchend', function(event) {
        if (!$(event.target).closest('.bl_header,.el_humburger').length && $('body').hasClass('js_humburgerOpen') && focusFlag) {
          focusFlag = false;
          spNavInOut.switch();
        }
      });
    });
 

function spNavIn(){
  $('body').removeClass('js_humburgerClose');
  $('body').addClass('js_humburgerOpen');
  setTimeout(function(){
    focusFlag = true;
  },200);
  setTimeout(function(){
    navigationOpenFlag = true;
  },200);
}
 

function spNavOut(){
  $('body').removeClass('js_humburgerOpen');
  $('body').addClass('js_humburgerClose');
  setTimeout(function(){
    $(".uq_spNavi").removeClass("js_appear");
    focusFlag = false;
  },200);
  navigationOpenFlag = false;
}
 

var spNavInOut = {
  switch:function(){
    if($('body.spNavFreez').length){
      return false;
    }
    if($('body').hasClass('js_humburgerOpen')){
     spNavOut();
    } else {
     spNavIn();
    }
  }
};