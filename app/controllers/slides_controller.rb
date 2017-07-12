class SlidesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @slide = current_user.slides.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def create_slide_params
    title = File.basename(params[:slide][:original_file].original_filename, '.*')
    title.encode!('UTF-8', 'UTF-8-MAC')
    params[:slide][:title] = title
    params[:slide][:published_at] = Time.current
    params.require(:slide).permit(:title, :original_filen, :published_at)
  end

  def update_slide_params
    params.require(:slide).permit(:title, :is_public, :published_at, :slug, :tag_list)
  end
end
