class Admin::SlidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slide, only: %i[edit update destroy]
  before_action :set_slide_tags_to_gon, only: %i[edit]
  before_action :set_available_tags_to_gon, only: %i[new edit]

  def index
    @slides = current_user.slides.preload(:user)
                          .not_public
                          .published_at_desc
                          .page(params[:page])
    render 'slides/index'
  end

  def new
    @slide = current_user.slides.new
    @slide.build_slide_outline
    gon.user_id = current_user.id
  end

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
    @slide.build_statistics
    @slide.save
  end

  def process_pdf
    @slide = Slide.find(params[:slide_id])
    pdf = Magick::ImageList.new.from_blob(open(@slide.pdf_file.to_s).read)
    total = pdf.size

    pdf.each_with_index do |page_img, index|
      page = @slide.pages.new(num: index)

      page_to_img(page_img) do |img|
        page.image = img
        page.save
      end

      ActionCable.server.broadcast "progress_channel_#{current_user.id}", total: total, num: index + 1
    end
  end

  def edit; end

  def update
    # リアップロード機能は後日
    # if params[:slide][:pdf_file].present?
    # @slide.reupload(pdf_file)
    # redirect_to edit_admin_slide_path(@slide)

    if @slide.update(update_slide_params)
      redirect_to edit_admin_slide_path(@slide), notice: 'スライドを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @slide.destroy
    redirect_to admin_slides_path
  end

  private

  def set_slide
    @slide = current_user.slides.lock.find(params[:id])
  end

  def set_slide_tags_to_gon
    gon.slide_tags = @slide.tag_list
  end

  def set_available_tags_to_gon
    gon.available_tags = Slide.tags_on(:tags).pluck(:name)
  end

  def page_to_img(page_img)
    file = Tempfile.new(['temp', '.png'])
    page_img.write(file.path)
    begin
      yield(file)
    ensure
      file.close
      file.unlink
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
    params.require(:slide).permit(:title, :slug, :is_public, :tag_list, :category,
                                  :published_at, :uploaded, slide_outline_attributes: [:note])
  end
end
