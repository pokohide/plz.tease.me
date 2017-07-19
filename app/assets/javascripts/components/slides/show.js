import Fullscreen from '../../utils/fullscreen'
import Slider from '../../utils/slider'

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

  const slider = new Slider({
    slider       : '.slide-viewer',
    progressCount: '.page-counter',
    progressBar  : '.slide-progress',
    loader       : '.slide-loader',
    totalPages   : gon.total_pages,
  })

  const fs = new Fullscreen($('.slide-viewer-container'), $('#fullscreen'))

  $('.slide-viewer').slick({
      accessibility: true,
      autoplay     : false,
      cssEase: 'liner',
      dots: false,
      draggable: false,
      arrows: false,
      initialSlide: 0,
      lazyLoad: 'ondemand',
      slidesToShow: 1,
      slidesToScroll: 1,
      swipe: true,
      vertical: false,
    　centerMode: true,
      centerPadding: '0',
  })

  $('#prev').on('click', () => { slider.goPrev() })
  $('#next').on('click', () => { slider.goNext() })
  $('#fullscreen').on('click', () => { fs.toggle() })
  $(window).resize(() => { slider.resize() })

  $(document).on('keydown', (e) => {
    const key = e.keyCode
    if (key == 39 || key == 40 || key == 13) {
      slider.goNext()
      e.preventDefault()
    } else if (key == 37 || key == 38) {
      slider.goPrev()
      e.preventDefault()
    }
  })
})
