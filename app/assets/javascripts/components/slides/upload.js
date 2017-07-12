$('.slides.new, .slides.create').ready(() => {
  Dropzone.autoDiscover = false
  new Dropzone('#upload-dropzone', {
    uploadMultiple: false,
    paramName: 'slide[original_file]',
    params: {
      'slide[document_id]': 123
    },
    init: function() {
      return this.on('success', (file, json) => {
        console.log(file, json)
      })
    },
    dictDefaultMessage: '<i class="fa fa-file-o fa-2x"></i><br>\n<br>\nファイルをここにドロップするか<br>\nここをクリックして下さい'
  })
})
