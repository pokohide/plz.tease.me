class ProgressChannel < ApplicationCable::Channel
  def subscribed

  end

  def follow(data)
    stream_from("progresses:#{data['progress_id']}")
  end
end
