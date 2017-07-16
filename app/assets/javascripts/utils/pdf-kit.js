PDFJS.workerSrc = '../assets/pdf.worker.js'
PDFJS.cMapUrl = './cmaps/'
PDFJS.cMapPacked = true
PDFJS.disableRange = true

export default class PdfKit {
  constructor(url, ids) {
    /* $ container */
    this.$container = $(ids.container)
    this.$canvas = $(ids.canvas)
    this.$textLayer = $(ids.textLayer)
    this.$pageCounter = $(ids.pageCounter)
    this.$progress = $(ids.progress)

    /* Init Document */
    this.getDocument(url)

    this.currentPage = 1
    this.pageRendering = false
    this.pageNumPending = null

    this.options = {
      scale: 1.0,
      rotate: 0,
    }
  }

  goNext() {
    if (this.currentPage >= this.totalPages) return
    this.currentPage += 1
    this.queueRenderPage(this.currentPage)
  }

  goPrev() {
    if (this.currentPage <= 1) return
    this.currentPage -= 1
    this.queueRenderPage(this.currentPage)
  }

  /* Private */
  updatePageCount() {
    this.$pageCounter.text(`${this.currentPage} / ${this.totalPages}`)
    this.$progress.progress({ percent: this.currentPage * 100 / this.totalPages })
  }

  getDocument(url) {
    PDFJS.getDocument({ url: url }).then((pdf) => {
      this.document = pdf
      this.totalPages = pdf.numPages
      this.renderPage(1)
    })
    .catch(err => { this._renderError(err) })
  }

  renderPage(num) {
    this.document.getPage(num).then((page) => {
      const canvas = this.$canvas.get(0)
      const context = canvas.getContext('2d')
      const scale = canvas.width / page.getViewport(this.options.scale, this.options.rotate).width
      const viewport = page.getViewport(scale)

      canvas.height = viewport.height
      canvas.width = viewport.width

      //this.$container
      //  .css('height', `${canvas.height}px`)
      //  .css('width',  `${canvas.width}px`)

      const canvasOffset = this.$canvas.offset()
      this.$textLayer
        .css('height', `${viewport.height}px`)
        .css('width',  `${viewport.width}px`)
        .offset({
          top : canvasOffset.top,
          left: canvasOffset.left,
        })

      this._showLoading()

      page.render({ canvasContext: context, viewport: viewport }).then(() => {
        this._hideLoading()
        if (this.pageNumPending !== null) {
          this.renderPage(this.pageNumPending)
          this.pageNumPending = null
        }
        this.updatePageCount()
      })

      // this.renderContent(page, context, viewport)
    })
  }

  renderContent(page, context, viewport) {
    pege.getContext().then((textContent) => {
      const textLayer = new TextLayerBuilder({
        textLayer: this.$textLayerDiv.get(0),
        pageIndex: 0,
      })

      textLayer.setTextContent(textContent)
      return page.render({
        canvasContext: context,
        viewport     : viewport,
        textLayer    : textLayer,
      })
    })
  }

  queueRenderPage(num) {
    if (this.pageRendering) {
      this.pageNumPending = num
    } else {
      this.renderPage(num)
    }
  }

  _renderError(err) {
    alertify.error('スライドを読み込めませんでした。リロードしてください。')
    // ここにエラー用の画像をcanvasに表示する
  }

  _showLoading() {
    this.pageRendering = true
    // ここでローディングGIFとかをcanvasに差し込む
  }

  _hideLoading() {
    this.pageRendering = false
    // ローディングGIFを消す
  }
}
