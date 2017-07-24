//= require jquery
//= require jquery-ui
//= require semantic-ui/progress
//= require jquery.fullscreen
//= require slider-pro

$(document).ready(() => {

  const _updateProgress = (total, current) => {
    $('.slide-counter').text(`${current} / ${total}`)
    $('.slide-progress').progress({ percent: current * 100 / total })
  }

  $('#prev').on('click', function() {
    if ($(this).hasClass('disabled')) return
    $('.slider-pro').sliderPro('previousSlide')
  })
  $('#next').on('click', function() {
    if ($(this).hasClass('disabled')) return
    $('.slider-pro').sliderPro('nextSlide')
  })
  $('#fullscreen').on('click', () => { $('.sp-full-screen-button').click() })

  let totalPages

  $('.slider-pro').sliderPro({
    width: '100%',
    responsive: true,
    imageScaleMode: 'contain',
    centerImage: true,
    autoHeight: true,
    startSlide: 0,
    slideDistance: 0,
    lideAnimationDuration: 500,
    waitForLayers: true,
    autoScaleLayers: false,
    autoplay: false,
    arrows: true,
    buttons: false,
    keyboard: false,
    fullScreen: true,
    loop: false,
    init: function(e) {
      totalPages = $(this).get(0).getTotalSlides()
      _updateProgress(totalPages, 1)
    }
  })

  $('.slider-pro').hover(() => {
    console.log('hover')
    //$('.slide-toolbar-container').show()
  }, () => {
    //$('.slide-toolbar-container').hide()
  })

  $('.slider-pro').on('gotoSlide', function(e) {
    console.log(totalPages)
    if (e.index + 1 === totalPages) {
      $('#next').addClass('disabled')
    } else {
      $('#next').removeClass('disabled')
    }

    if (e.index === 0) {
      $('#prev').addClass('disabled')
    } else {
      $('#prev').removeClass('disabled')
    }

    _updateProgress(totalPages, e.index + 1)
  })

  $(document).on('keydown', (e) => {
    switch(e.keyCode) {
      case $.ui.keyCode.LEFT:
        if ($('.slider-pro').data('sliderPro').getSelectedSlide() !== 0) {
          $('.slider-pro').data('sliderPro').previousSlide()
        }
        break
      case $.ui.keyCode.RIGHT:
        if ($('.slider-pro').data('sliderPro').getSelectedSlide() + 1 !== totalPages) {
          $('.slider-pro').data('sliderPro').nextSlide()
        }
        break
    }
  })

  $(document).bind('fullscreenchange mozfullscreenchange webkitfullscreenchange', (e) => {
    if ($(document).fullScreen()) {
      $('.slider-pro').css({ 'padding-bottom': '60px' })
    } else {
      $('.slider-pro').css({ 'padding-bottom': 0 })
      $('.sp-image').each((_, elem) => {
        $(elem).css({ 'margin-top': 0, 'margin-left': 0 })
      })
    }
  })
})
