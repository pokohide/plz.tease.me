PDFJS.workerSrc = '../assets/pdf.worker.js'
PDFJS.cMapUrl = './cmaps/'
PDFJS.cMapPacked = true
PDFJS.disableRange = true
// PDFJS.disableStream = true
// PDFJS.disableWorker = true

export default class PdfKit {
  constructor(url, id) {
    this.document = this.getDocument(url)
    this.canvas = document.getElementById(id)
    this.context = this.canvas.getContext('2d')
    this.currentPage = 1

    this.pageRendering = false
    this.pageNumPending = null

    this.options = {
      scale: 1.0,
      rotate: 0,
    }
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
      const scale = this.canvas.width / page.getViewport(this.options.scale, this.options.rotate).width
      const viewport = page.getViewport(scale)
      this.canvas.height = viewport.height

      this.pageRendering = true

      page.render({ canvasContext: this.context, viewport: viewport }).then(() => {
        this.pageRendering = false
        if (this.pageNumPending !== null) {
          this.renderPage(this.pageNumPending)
          this.pageNumPending = null
        }
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

  _renderError(err) {
    alertify.error('スライドを読み込めませんでした。リロードしてください。')
    // ここにエラー用の画像をcanvasに表示する
  }
}


//         var viewport = page.getViewport(scale);
//         var $canvas = $('#the-canvas');
//         var canvas = $canvas.get(0);
//         var context = canvas.getContext("2d");
//         canvas.height = viewport.height;
//         canvas.width = viewport.width;

//         var $pdfContainer = $("#pdfContainer");
//         $pdfContainer.css("height", canvas.height + "px").css("width", canvas.width + "px");

//         var canvasOffset = $canvas.offset();
//         var $textLayerDiv = $('.textLayer')
//             .css("height", viewport.height + "px")
//             .css("width", viewport.width + "px")
//             .offset({
//             top: canvasOffset.top,
//             left: canvasOffset.left
//         });

//         var outputScale = getOutputScale(context);
//         if (outputScale.scaled) {
//             var cssScale = 'scale(' + (1 / outputScale.sx) + ', ' + (1 / outputScale.sy) + ')';
//             CustomStyle.setProp('transform', canvas, cssScale);
//             CustomStyle.setProp('transformOrigin', canvas, '0% 0%');

//             if ($textLayerDiv.get(0)) {
//                 CustomStyle.setProp('transform', $textLayerDiv.get(0), cssScale);
//                 CustomStyle.setProp('transformOrigin', $textLayerDiv.get(0), '0% 0%');
//             }
//         }

//         context._scaleX = outputScale.sx;
//         context._scaleY = outputScale.sy;
//         if (outputScale.scaled) {
//             context.scale(outputScale.sx, outputScale.sy);
//         }

//     });
// });
