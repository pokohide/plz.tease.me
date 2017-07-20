//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require semantic-ui
//= require jquery.readyselector
//= require jquery.fullscreen
//= require tag-it
//= require dropzone
//= require slick
//= require alertify
//= require action_cable

window.App || (window.App = {});
window.App.cable = ActionCable.createConsumer()

import 'components/base'

$(document).ready(() => {
  $('.ui.dropdown').dropdown({ on: 'hover' })
  $('.ui.checkbox').checkbox()

  $('.flash-message .close.icon').on('click', function(e) {
    $(this).parent('.flash-message').fadeOut(500)
  })

  // $('img.lazy').lazyload({ effect : "fadeIn" })
})
