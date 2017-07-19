App.progresses = App.cable.subscriptions.create('ProgressChannel', {
  connected: () => {
    console.log('connected')
    // this.install()
    // return this.follow()
  },
  disconnected: () => {
    console.log('disconnected')
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
  }
})
