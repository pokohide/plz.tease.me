class ProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "progress_channel_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify_progress(data); end
end
