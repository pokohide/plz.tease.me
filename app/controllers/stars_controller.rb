class StarsController < ApplicationController
  before_action :set_slide

  def create
    @star = current_user.stars.create(slide_id: @slide.id)
    @slide.reload
  end

  def destroy
    star = current_user.stars.find_by(slide_id: @slide.id)
    star.destroy
    @slide.reload
  end

  private

  def set_slide
    @slide ||= Slide.find(params[:slide_id])
  end
end
