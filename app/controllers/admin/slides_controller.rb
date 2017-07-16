class Admin::SlidesController < ApplicationController
  before_action :authenticate_user!

  def index
    @slides = current_user.slides.preload(:user)
                          .published_at_desc
                          .page(params[:page])
    render 'slides/index'
  end

  def new; end

  def create
    # slide = current_user.slides.create!(create_slide_params)
    # Ppt2pdfJob.perform_later(slide)

    slide = current_user.slides.new(create_slide_params)
    original_filename = create_slide_params[:original_file]

    slide.with_lock do
      slide.slide_outline = pdf2outline(original_filename)
      slide.image_file = pdf2png(original_filename)
      slide.save!
    end

    redirect_to edit_admin_slide_path(slide)
  end

  def edit
    @slide = current_user.slides.find(params[:id])
  end

  def update
    # @slide = current_user.slides.lock.find(params[:id])
    @slide = current_user.slides.find(params[:id])
    if (original_filename = params[:slide][:original_file])
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

  def pdf2outline(file)
    pdf_file_path = file.path
    # pdf -> txt に xpdf を使う
    # text = `pdftotext -nopgbrk #{pdf_file_path} -`
    # SlideOutline.new(body: text)
    pdf = Poppler::Document.new(pdf_file_path)
    outline = ''
    pdf.pages.each_with_index do |page, index|
      outline += "#{index + 1}. #{page.get_text}"
      outline += "\n" if index != pdf.size - 1
    end
    SlideOutline.new(body: outline)
  end

  def pdf2png(file)
    pdf_file_path = file.path
    Dir.mktmpdir do |dir|
      png_basename = File.basename(pdf_file_path = file.path, '.*')
      # pdf の 1 ページ目のみを png に変換
      `pdftocairo -png -singlefile #{pdf_file_path} #{dir}/#{png_basename}`
      return File.open("#{dir}/#{png_basename}.png")
    end
  end

  def create_slide_params
    title = File.basename(params[:slide][:original_file].original_filename, '.*')
    title.encode!('UTF-8', 'UTF-8-MAC')
    params[:slide][:title] = title
    params[:slide][:published_at] = Time.current
    params.require(:slide).permit(:title, :original_file, :published_at)
  end

  def update_slide_params
    params.require(:slide).permit(:title, :is_public, :published_at, :slug, :tag_list)
  end
end
