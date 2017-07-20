class EmbedsController < ApplicationController
  def show
    @slide = Slide.find_by(slug: params[:slug])
    render layout: false
  end
end
