class EmbedsController < ApplicationController
  def show
    @slide = Slide.find_by(slug: params[:slug])
    @slide.tatistic.increment!(:embed_views)
    render layout: false
  end
end
