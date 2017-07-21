class SlidesController < ApplicationController

  def index
    @slides = Slide.preload(:user).
                is_public.
                published_at_desc.
                page(params[:page])
  end

  def show
    @slide = Slide.find(params[:id])
    @comments = @slide.comments.desc
    # @slide = @user.slides.is_public.find_by(slug: params[:slug])
    gon.pdf_url = @slide.pdf_file.to_s
    @slide.increment!(:page_view)
    @recommend = Slide.limit(5)
  end

  def search
    search_param = { query: { bool: { must: [
      { multi_match: { minimum_should_match: "100%", query: params[:q], fields: %w(tags title outline) } },
    ] } } }
    @slides = Slide.search(search_param).page(params[:page]).records
    render "index"
  end
end
