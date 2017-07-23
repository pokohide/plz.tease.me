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

  const fs = new Fullscreen($('.slide-viewer-container'), $('#fullscreen'))
  const slider = $('.slide-viewer').lightSlider({
    adaptiveHeight: true,
    item          : 1,
    slideMargin   : 0,
    keyPress      : true,
    freeMove      : false,
    pager         : false,
    speed         : 200,
    addClass      : 'slider',
    prevHtml      : '',
    nextHtml      : '',
    slideEndAnimation: false,
    onBeforeStart: () => {
      $('.slide-loader').addClass('active')
    },
    onSliderLoad: (el) => {
      $('.slide-loader').removeClass('active')
      _updateProgress(el)
    },
    onAfterSlide: (el) => {
      _updateProgress(el)
    }
  })

  const _updateProgress = (el) => {
    const currentPage = el.getCurrentSlideCount()
    const totalPages = el.getTotalSlideCount()
    $('.slide-counter').text(`${currentPage} / ${totalPages}`)
    $('.slide-progress').progress({ percent: currentPage * 100 / totalPages })
  }

  $('#prev').on('click', () => { slider.goToPrevSlide() })
  $('#next').on('click', () => { slider.goToNextSlide() })
  $('#fullscreen').on('click', () => {
    fs.toggle()
  })

  const imgResize = () => {
    const sliderHeight = $('.slider').height()
    const sliderWidth = $('.slider').width()
    const sliderRatio = sliderWidth / sliderHeight

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
        $(elem).css({ height: `${sliderHeight - 40}px`, width: 'auto' })
      }

      // 中央配置
      const w = Math.floor((sliderWidth - $(elem).width()) / 2)
      const h = Math.floor((sliderHeight - $(elem).height()) / 2)
      $(elem).css({ 'margin-left': w, 'margin-top': h })
    })
  }
  $(window).resize(() => {
    slider.refresh()
    imgResize()
  })

  $('.slide-page-number').on('click', function() {
    const pageNum = parseInt($(this).attr('data-num'), 10)
    slider.goToSlide(pageNum - 1)
  })
})
