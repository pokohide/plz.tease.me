class TagsController < ApplicationController
  def index
    @tags = Slide.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @slides = Slide.tagged_with(params[:tag]).
              # is_public.
              order(published_at: :desc).
              page(params[:page])
    render 'slides/index'
  end
end
