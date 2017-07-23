$('.slides.edit, .slides.update').ready(() => {
  $('#tabs').on('click', '.item', function(e) {
    e.preventDefault()
    const target = $(this).attr('data-tab')
    $('#tabs .item.active').removeClass('active')
    $(this).addClass('active')

    const tabs = ['.detail-tab', '.reupload-tab']
    for(let i = 0; i < tabs.length; i++) $(tabs[i]).hide()
    $(`.${target}-tab`).fadeIn(500)
  })

  $('.ui.category-dropdown').dropdown({ on: 'click' })
  $('.ui.checkbox').checkbox()

  $('#slide-tags').tagit({
    fieldName: 'slide[tag_list]',
    singleField: true,
    availableTags: gon.available_tags || []
  })

  if (gon.slide_tags) {
    for (let i = 0; i < gon.slide_tags.length; i++) {
      $('#slide-tags').tagit('createTag', gon.slide_tags[i])
    }
  }
})
