//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require semantic-ui
//= require jquery.readyselector
//= require jquery.fullscreen
//= require tag-it
//= require dropzone
//= require alertify
//= require action_cable
//= require lightslider

window.App || (window.App = {});
window.App.cable = ActionCable.createConsumer()

import 'components/base'

$(document).ready(() => {
  $('.ui.dropdown').dropdown({ on: 'hover' })
  $('.ui.checkbox').checkbox()

  $('.flash-message .close.icon').on('click', function(e) {
    $(this).parent('.flash-message').fadeOut(500)
  })

  /* data-load指定のボタンはクリックしたらローディングにする */
  $('[data-loading="true"]').on('click', function() {
    $(this).addClass('loading')
  })
  $('a, input[type=submit]').on('click', () => {
    $(window).off('beforeunload')
  })
  // $('img.lazy').lazyload({ effect : "fadeIn" })
})
