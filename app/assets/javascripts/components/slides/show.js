import PdfKit from '../../utils/pdf-kit'

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

  const params = {
    url: gon.pdf_url,
    httpHeaders: {
      'Access-Control-Allow-Headers': 'Range'
    }
  }

  const pdfKit = new PdfKit(gon.pdf_url, 'pdf-viewer')

  $('#prev').on('click', () => {
    pdfKit.goPrev()
  })

  $('#next').on('click', () => {
    pdfKit.goNext()
  })

})
