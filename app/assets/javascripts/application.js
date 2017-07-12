//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require jquery.readyselector
//= require dropzone

import 'components/base'

$(document).ready(() => {
  $('.ui.dropdown').dropdown({ on: 'hover' })
  //$('.ui.checkbox').checkbox()
  // $('.ui.accordion').accordion()

  // /* notificationの閉じるをクリックしたら閉じる */
  // $('.ui.message .close.icon').on('click', function() {
  //   $(this).parent().fadeOut()
  // })

  //  notificationは何もしなくても10秒後に消滅する
  // setTimeout(() => {
  //   $('.ui.message').each(function() {
  //     if(!$(this).attr('data-flash')) $(this).fadeOut('normal')
  //   })
  // }, 10000)

  // $('img.lazy').lazyload({ effect : "fadeIn" })
})
