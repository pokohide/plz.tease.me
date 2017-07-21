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
    addClass      : 'padding-50',
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
  $('#fullscreen').on('click', () => { fs.toggle() })
  $(window).resize(() => { slider.refresh() })

  $('.slide-page-number').on('click', function() {
    const pageNum = parseInt($(this).attr('data-num'), 10)
    slider.goToSlide(pageNum - 1)
  })
})
