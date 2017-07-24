import Fullscreen from '../../utils/fullscreen'

$('.slides.show').ready(() => {
  $('.comments').on('click', '.reply', function(e) {
    e.preventDefault()
    const username = $(this).attr('data-user')
    let value = $('#comment_body').val()
    value = `@${username}　` + value
    $('#comment_body').val(value)
    $('#comment_body').focus()
  })

  $('#tabs').on('click', '.item', function(e) {
    e.preventDefault()
    const target = $(this).attr('data-tab')
    $('#tabs .item.active').removeClass('active')
    $(this).addClass('active')

    const tabs = ['.comment-tab', '.likes-tab' ,'.statistics-tab', '.note-tab']
    for(let i = 0; i < tabs.length; i++) $(tabs[i]).hide()
    $(`.${target}-tab`).fadeIn(500)
  })

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
  $('#fullscreen').on('click', () => {
    $('.sp-full-screen-button').click()
  })

  const initial = {
    slider: {
      width: $('.slide-viewer-container').width(),
      height: $('.slide-viewer-container').height()
    },
    sliderImg: {
      width: $('.slider img').width(),
      height: $('.slider img').height()
    }
  }

  const imgResize = () => {
    const sliderHeight = $('.slide-viewer-container').height()
    const sliderWidth = $('.slide-viewer-container').width()
    const sliderRatio = sliderWidth / sliderHeight
    console.log('imgResize', sliderWidth, sliderHeight)

    $('.slider img').each((_index, elem) => {
      const height = $(elem).height()
      const width = $(elem).width()
      const ratio = width / height

      // 横長の場合
      if (ratio >= 1) {

        if (ratio >= sliderRatio) {
          $(elem).css({ width: `${sliderWidth}px`, height: 'auto' })
        } else {
          $(elem).css({ height: `${sliderHeight - 40}px`, width: 'auto' })
        }

      // 縦長の場合
      } else {
        if (ratio >= sliderRatio) {
          $(elem).css({ height: `${sliderHeight - 40}px`, width: 'auto' })
        } else {
          $(elem).css({ width: `${sliderWidth}px`, height: 'auto' })
        }
      }

      // 中央配置
      let w = Math.floor((sliderWidth - width) / 2)
      let h = Math.floor((sliderHeight - height) / 2)
      if (w < 0) w = 0
      if (h < 0) h = 0
      $(elem).css({ 'margin-left': w, 'margin-top': h })
    })
  }

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

    } else {
      $('.sp-image').each((_, elem) => {
        $(elem).css('margin-top', 0)
      })
    }
  })

  $('.slide-page-number').on('click', function() {
    const pageNum = parseInt($(this).attr('data-num'), 10)
    $('.slider-pro').sliderPro('gotoSlide', pageNum - 1)
  })
})
