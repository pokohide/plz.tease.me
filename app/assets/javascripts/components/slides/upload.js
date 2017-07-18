const request = require('superagent')

$('.slides.new, .slides.create').ready(() => {
  Dropzone.autoDiscover = false
  const dropzone = new Dropzone('.drag-and-drop-area', {
    url                  : '/upload-pdf',
    uploadMultiple       : false,
    parallelUploads      : 1,
    paramName            : 'slide[pdf_file]',
    autoProcessQueue     : false,
    createImageThumbnails: false,
    header               : { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
    params               : { 'slide[document_id]': 123 },
    acceptedFiles        : 'application/pdf',
    maxFiles             : 1,
    maxFilesize          : 10,
    dictFileTooBig       : 'ファイルが大きすぎます。 ({{filesize}}MiB). 最大サイズ: {{maxFilesize}}MiB.',
    dictDefaultMessage   : '<i class="file icon"></i><br />\n<br>\nファイルをここにドロップするか<br>\nここをクリックして下さい',
    dictFallbackMessage  : 'お使いのブラウザはドラッグ&ドロップに対応していません',
    dictInvalidFileType  : 'PDFファイルをアップロードしてください',
    dictCancelUpload     : 'アップロードできませんでした',
    addedfile: (file) => {
      console.log('addedFile', file)

      request
        .post('/upload-pdf')
        .set('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content') )
        .attach('slide[pdf_file]', file)
        .on('progress', (evt)=> {
          console.debug(evt.percent);
        })
        .end((err, res) => {
          if(err) return alert('エラー発生')
          const { slide: { id, title, pdf_url } } = res.body
        })
    }
  })



  /* stepは1, 2, 3とする */
  const changeStep = step => {
    if (![1, 2].includes(step)) return
    const nowStep = ['one', 'two'][step - 1]

    $('.step.active').removeClass('active').addClass('completed')
    $('.step-content.active').removeClass('active')

    $(`.step.${nowStep}`).addClass('active')
    $(`.step-content.${nowStep}`).addClass('active')
  }

})
