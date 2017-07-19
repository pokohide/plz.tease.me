App.progresses = App.cable.subscriptions.create('ProgressChannel', {
  connected: () => {
    this.install()
    return this.follow()
  },
  received: (data) => {
    console.log(data)
    // $('.progress-percentage').text("" + data.percent + "%");
    // return $('progress').prop('value', data.percent);
  },
  follow: () => {
    return this.perform('follow', {
      progress_id: 1
    })
  },
  install: () => {
    return $(document).on('page:change', () => {
      return App.progresses.follow()
    })
  }
})
