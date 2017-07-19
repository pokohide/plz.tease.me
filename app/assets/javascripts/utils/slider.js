export default class Slider {
  constructor({ slider, totalPages, progressCount, progressBar, loader}) {
    this.dom = {
      slider       : $(slider),
      progressCount: $(progressCount),
      progressBar  : $(progressBar),
      loader       : $(loader),
    }

    this.currentPage = 1
    this.totalPages = totalPages
    this.loading = false
    this._updateProgress()
  }

  goNext() {
    console.log(`${this.currentPage} / ${this.totalPages}`)
    if (this.currentPage >= this.totalPages) return
    console.log('next!!')
    this.currentPage += 1
    this.dom.slider.slick('slickNext')
    this._updateProgress()
  }

  goPrev() {
    console.log(`${this.currentPage} / ${this.totalPages}`)
    if (this.currentPage <= 1) return
    console.log('prev!!')
    this.currentPage -= 1
    this.dom.slider.slick('slickPrev')
    this._updateProgress()
  }

  resize() {
    this.dom.slider.slick('setPosition')
  }

  /* Private */
  _updateProgress() {
    this.dom.progressCount.text(`${this.currentPage} / ${this.totalPages}`)
    this.dom.progressBar.progress({ percent: this.currentPage * 100 / this.totalPages })
  }
}
