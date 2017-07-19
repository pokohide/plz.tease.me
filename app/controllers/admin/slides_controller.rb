class Admin::SlidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slide_tags_to_gon, only: [:edit]
  before_action :set_available_tags_to_gon, only: [:new, :edit]

  def index
    @slides = current_user.slides.preload(:user).
                published_at_desc.
                page(params[:page])
    render 'slides/index'
  end

  def new; end

  def create
    @slide = current_user.slides.lock.find(params[:slide][:id])

    # 非同期でPDF -> Outlineを実行
    Pdf2outlineJob.perform_later(@slide.id)
    # 非同期でサムネイル画像作成
    Pdf2pngJob.perform_later(@slide.id)

    if @slide.update(update_slide_params)
      redirect_to slide_path(@slide), notice: 'スライドを投稿しました。'
    else
      render :edit
    end
  end

  def upload_pdf
    @slide = current_user.slides.new(create_pdf_params)
    pdf_file = create_pdf_params[:pdf_file]

    @slide.with_lock do
      # @slide.image_file = pdf2png(pdf_file)
      @slide.save!
    end
  end

  def process_pdf
    #binding.pry
    @slide = Slide.find(params[:slide_id])
    pdf = Magick::ImageList.new.from_blob(open(@slide.pdf_file.to_s).read)

    # num = pdf.size
    pdf.each_with_index do |page_img, index|
      page = @slide.pages.new(num: index)

      temp_file = Tempfile.new([ 'temp', '.png' ])
      page_img.write(temp_file.path)

      page.image = temp_file
      page.save!
      temp_file.close!
      temp_file.unlink

      # ActionCable.server.broadcast('progresses:1', percent: num * 100 / (index + 1))
    end
  end

  def edit
    @slide = current_user.slides.find(params[:id])
  end

  def update
    @slide = current_user.slides.lock.find(params[:id])
    if (original_filename = params[:slide][:pdf_file])
      @slide.reupload(pdf_file)
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
    @slide = current_user.slides.lock.find(params[:id])
    @slide.destroy
    redirect_to admin_slides_path
  end

  private

  def set_slide_tags_to_gon
    gon.slide_tags = @slide.tag_list
  end

  def set_available_tags_to_gon
    gon.available_tags = Slide.tags_on(:tags).pluck(:name)
  end

  def pdf2png file
    pdf_file_path = file.path
    Dir.mktmpdir do |dir|
      png_basename = File.basename(pdf_file_path = file.path, '.*')
      # pdf の 1 ページ目のみを png に変換
      `pdftocairo -png -singlefile #{pdf_file_path} #{dir}/#{png_basename}`
      return File.open("#{dir}/#{png_basename}.png")
    end
  end

  def create_pdf_params
    title = File.basename(params[:slide][:pdf_file].original_filename, '.*')
    title.encode!('UTF-8', 'UTF-8-MAC')
    params[:slide][:title] = title
    params[:slide][:published_at] = Time.current
    params.require(:slide).permit(:title, :pdf_file, :published_at)
  end

  def update_slide_params
    params.require(:slide).permit(:title, :slug, :is_public, :tag_list, :published_at, :uploaded)
  end
end
