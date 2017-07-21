class EmbedsController < ApplicationController
  def show
    @slide = Slide.find_by(slug: params[:slug])
    @slide.statistic.increment(:embed_views).save
    render layout: false
  end
end
