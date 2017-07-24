/*
 https://github.com/kayahr/jquery-fullscreen-plugin
 に依存
 */

export default class Fullscreen {
  constructor(target, button) {
    this.$elem = target
    this.$button = button
    this._check()
  }

  toggle() {
    if (!this._canFullscreen()) return alert('フルスクリーンモードは使用できません。')

    if( this.nowFullscreen() ) {
      this.$elem.css('height', 'auto').fullScreen(false)
      this.$button.children('.icon').removeClass('compress').addClass('expand')
    } else {
      this.$elem.css('height', '100%').fullScreen(true)
      this.$button.children('.icon').removeClass('expand').addClass('compress')
    }
  }

  // フルスクリーン中かどうか
  nowFullscreen() {
    // return document.fullScreen ||
    //        document.mozFullScreen ||
    //        document.webkitIsFullScreen ||
    //        document.msFullScreen ||
    //        false
    return $(document).fullScreen()
  }

  /* Private */

  // フルスクリーン使用可能かチェック
  _check() {
    if (this._canFullscreen()) return
    this.$button.addClass('disabled')
  }

  // フルスクリーン可能かどうか
  _canFullscreen() {
    return document.fullscreenEnabled ||
           document.webkitFullscreenEnabled ||
           document.mozFullScreenEnabled ||
           document.msFullscreenEnabled ||
           false
  }
}
