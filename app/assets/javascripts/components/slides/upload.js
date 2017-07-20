const request = require('superagent')

$('.slides.new, .slides.create').ready(() => {
  $('#slide-tags').tagit({
    fieldName: 'slide[tag_list]',
    singleField: true,
    availableTags: gon.available_tags || []
  })

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

      $('.upload-indicator').addClass('active')

      uploadPDF(file)
      .then(({ id, title, slug, pdf_url }) => {
        $('#slide_id').val(id)
        $('#slide_title').val(title)
        $('#slide_slug').val(slug)
        $('.upload-indicator').removeClass('active')
        $('.proccess-indicator').addClass('active')
        $('.slide-preview .ui.progress').progress({
          text: { active: 'スライド変換中...' }
        })
        changeStep(2)
        return processPDF(id)
      })
      .then((res) => {
        $('.proccess-indicator').removeClass('active')
        $('.upload-button').removeClass('disabled')
      })
      .catch((err) => { alert(err) })
    }
  })

  /* PDFをアップロードする */
  const uploadPDF = file => {
    return new Promise((resolve, reject) => {
      request
        .post('/upload-pdf')
        .set('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content') )
        .attach('slide[pdf_file]', file)
        .on('progress', (evt)=> { console.log('progress', evt.percent) })
        .end((err, res) => {
          if(err) return reject(err)
          console.log('done', res)
          return resolve(res.body.slide)
        })
    })
  }

  /* PDFの処理を要求するAPIを叩く */
  const processPDF = (slideId) => {
    return new Promise((resolve, reject) => {
      request
        .post('/process-pdf')
        .set('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content') )
        .send({ slide_id: slideId })
        .end((err, res) => {
          if(err) return reject(err)
          console.log('done', res)
          return resolve(res)
        })
    })
  }

  /* stepは1, 2とする */
  const changeStep = step => {
    if (![1, 2].includes(step)) return
    const nowStep = ['one', 'two'][step - 1]

    $('.step.active').removeClass('active').addClass('completed')
    $('.step-content.active').removeClass('active')
    $(`.step.${nowStep}`).addClass('active')
    $(`.step-content.${nowStep}`).addClass('active')
  }

  /* 進捗を表示 */
  window.App.progress = window.App.cable.subscriptions.create(
    { channel: 'ProgressChannel', user_id: gon.user_id }, {
      connected: () => { console.log('connected') },

      received: (data) => {
        const { total, num } = data
        $('.slide-preview .ui.progress').progress({
          total: total, value: num,
          text: { active: `${num}/${total} スライド変換中...` }
        })
      },
    }
  )
})
