class Admin::SlidesController < ApplicationController
  before_action :authenticate_user!

  def index
    @slides = current_user.slides.preload(:user)
                published_at_desc.
                paginate(page: params[:page])
    render 'slides/index'
  end

  def new
  end

  def create
    slide = current_user.slides.create!(create_slide_params)
    Ppt2pdfJob.perform_later(slide)
    redirect_to edit_admin_slide_path(slide)
  end

  def edit
    @slide = current_user.slides.find(params[:id])
  end

  def update
    # @slide = current_user.slides.lock.find(params[:id])
    @slide = current_user.slides.find(params[:id])
    if (original_filename = params[:slide][:original_filen])
      @slide.reupload(original_file)
      redirect_to edit_admin_slide_path(@slide)
    else
      if @slide.update(update_slide_params)
        redirect_to admin_slides_path
      else
        render :edit
      end
    end
  rescue ActiveRecord::RecordNotUnique
    @slide.errors.add(:slug, I18n.t('errors.messages.taken'))
    render :edit
  end

  def destroy
    # @slide = current_user.slides.lock.find(params[:id])
    @slide = current_user.slides.find(params[:id])
    @slide.destroy
    redirect_to admin_slides_path
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
