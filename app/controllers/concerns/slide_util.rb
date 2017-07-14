module SlideUtil
  extend ActiveSupport::Concern

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def download_slide
    #url = CloudConfig::SERVICE.get_slide_download_url(@slide.object_key)
    # @TODO: handle response code
    #require 'open-uri'
    #data = open(url).read
    #send_data data, disposition: 'attachment', filename: "#{@slide.object_key}#{@slide.extension}"
  end

  def slide_position
    position = 1
    position = params[:page].to_i if params.key?(:page) && params[:page].to_i > 0
    position
  end
end