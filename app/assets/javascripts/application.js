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
  //$('.ui.checkbox').checkbox()
  // $('.ui.accordion').accordion()

  // $('img.lazy').lazyload({ effect : "fadeIn" })
})
