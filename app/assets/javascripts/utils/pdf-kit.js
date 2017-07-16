PDFJS.workerSrc = '../assets/pdf.worker.js'
PDFJS.cMapUrl = './cmaps/'
PDFJS.cMapPacked = true
PDFJS.disableRange = true

export default class PdfKit {
  constructor({ container, canvas, progressCount, progressBar, loader }) {
    /* $ container */
    this.dom = {
      container    : $(container),
      progressCount: $(progressCount),
      progressBar  : $(progressBar),
      canvas       : $(canvas),
      loader       : $(loader),
    }
    this.options = {
      scale: 1.0,
      rotate: 0,
    }

    this.currentPage = 1
    this.loading = false
    this.pageNumPending = null
  }

  goNext() {
    if (this.currentPage >= this.totalPages) return
    this.currentPage += 1
    this._queueRenderPage(this.currentPage)
  }

  goPrev() {
    if (this.currentPage <= 1) return
    this.currentPage -= 1
    this._queueRenderPage(this.currentPage)
  }

  loadDocument(url) {
    this._showLoading()
    return PDFJS.getDocument({ url: url }).then((pdf) => {
      this.document = pdf
      this.totalPages = pdf.numPages
      this._renderPage(1)
    })
  }

  /* Private */

  _queueRenderPage(pageNum) {
    if (this.pdfDoc == null) return this.promiseQueue
    this.promiseQueue = this.promiseQueue.then(() => {
      return this._renderPage(pageNum)
    })
    return this.promiseQueue
  }

  _updateProgress() {
    this.dom.progressCount.text(`${this.currentPage} / ${this.totalPages}`)
    this.dom.progressBar.progress({ percent: this.currentPage * 100 / this.totalPages })
  }

  _fitInSize() {
    return new Promise((resolve) => {
      const containerRect = this.pdfContainer.getBoundingClientRect();
      this.domMapObject.canvas.width = containerRect.width;
      this.domMapObject.canvas.height = containerRect.height;
      resolve(containerRect);
    }).then(() => {
      return this._queueRenderPage(this.pageNum);
    })
  }

  _renderPage(num) {
    this.document.getPage(num).then((page) => {
      const canvas = this.dom.canvas.get(0)
      const context = canvas.getContext('2d')
      const scale = canvas.width / page.getViewport(this.options.scale, this.options.rotate).width
      const viewport = page.getViewport(scale)

      canvas.height = viewport.height
      canvas.width = viewport.width

      //this.$container
      //  .css('height', `${canvas.height}px`)
      //  .css('width',  `${canvas.width}px`)

      const canvasOffset = this.dom.canvas.offset()
      // this.$textLayer
      //   .css('height', `${viewport.height}px`)
      //   .css('width',  `${viewport.width}px`)
      //   .offset({
      //     top : canvasOffset.top,
      //     left: canvasOffset.left,
      //   })

      this._showLoading()

      page.render({ canvasContext: context, viewport: viewport }).then(() => {
        this._hideLoading()
        if (this.pageNumPending !== null) {
          this._renderPage(this.pageNumPending)
          this.pageNumPending = null
        }
        this._updateProgress()
      })

      // this._renderContent(page, context, viewport)
    })
  }

  // _renderContent(page, context, viewport) {
  //   pege.getContext().then((textContent) => {
  //     const textLayer = new TextLayerBuilder({
  //       textLayer: this.$textLayerDiv.get(0),
  //       pageIndex: 0,
  //     })

  //     textLayer.setTextContent(textContent)
  //     return page.render({
  //       canvasContext: context,
  //       viewport     : viewport,
  //       textLayer    : textLayer,
  //     })
  //   })
  // }

  _queueRenderPage(pageNum) {
    if (this.loading) {
      this.pageNumPending = pageNum
    } else {
      this._renderPage(pageNum)
    }
  }

  _showLoading() {
    this.loading = true
    this.dom.loader.show()
    // ここでローディングGIFとかをcanvasに差し込む
  }

  _hideLoading() {
    this.loading = false
    console.log('done.')
    this.dom.loader.hide()
    // ローディングGIFを消す
  }
}
