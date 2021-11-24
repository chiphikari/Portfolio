// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require activestorage
//= require turbolinks

//= require jquery.jscroll.min.js
//= require jquery.raty.js

// = require_tree .

// 画像スライド
document.addEventListener("turbolinks:load", function(){
  $('.slider').slick({
    autoplay:true,
    autoplaySpeed:5000,
    dots:true,
  });
});

// 画像スライド
document.addEventListener("turbolinks:load", function(){
  $('.slider02').slick({
    autoplay:true,
    autoplaySpeed:5000,
    dots:true,
  });
});

// Kaminari＋jscroll
$(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();

    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {

          $('.jscroll').jscroll({
            contentSelector: '.skill-list',
            nextSelector: "nav ul li a[rel=next]",
            callback: function() {
               $('.slider02').not('.slick-initialized').slick({
                autoplay:true,
                autoplaySpeed:5000,
                dots:true,
              });
            }
          });
    }
});

//
$('top-page-header__header-center__surround__bottom').fadeIn(1500);

//
$(window).on("scroll", function() {
  var scroll_top = $(window).scrollTop();
  $("#scroll span").text(scroll_top);

  $(".feature__feature-item--body").each(function() {
    var elem_pos = $(this).offset().top;
    $(this).find(".feature__feature-item--body_pos span").text(Math.floor(elem_pos));

    //どのタイミングでフェードインさせるか
    if (scroll_top >= elem_pos - window_h+200) {
      $(this).addClass("fadein");
    } else {
      $(this).removeClass("fadein");
    }
  });
});