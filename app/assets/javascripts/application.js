//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require jquery.readyselector
//= require jquery.fullscreen
//= require pdf
//= require pdf.worker
//= require dropzone
//= require alertify

//import 'externals/base'
import 'components/base'

$(document).ready(() => {
  $('.ui.dropdown').dropdown({ on: 'hover' })
  $('.ui.checkbox').checkbox()

  $('.flash-message .close.icon').on('click', function(e) {
    $(this).parent('.flash-message').fadeOut(500)
  })

  // $('img.lazy').lazyload({ effect : "fadeIn" })
})
