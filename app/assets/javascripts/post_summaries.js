window.onload = function showElementAnimation() {
  var element = document.getElementsByClassName('animation');
  if(!element) return;
  var showTiming = window.innerHeight > 768 ? 200 : 40; // 要素が出てくるタイミングはここで調整
  var scrollY = window.pageYOffset;
  var windowH = window.innerHeight;
  for(var i=0;i<element.length;i++) { var elemClientRect = element[i].getBoundingClientRect(); var elemY = scrollY + elemClientRect.top; if(scrollY + windowH - showTiming > elemY) {
      element[i].classList.add('is-show');
    } else if(scrollY + windowH < elemY) {
      element[i].classList.remove('is-show');
    }
  }
}
/* global functionshowElementAnimation */
window.onload = functionshowElementAnimation();
/* global showElementAnimation */
window.addEventListener('scroll', showElementAnimation);