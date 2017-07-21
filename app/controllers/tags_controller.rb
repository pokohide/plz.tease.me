class TagsController < ApplicationController
  def index
    @tags = Slide.tag_counts_on(:tags).order('count DESC')
  end

  def show
    @slides = Slide.tagged_with(params[:id]).
              # is_public.
              published_at_desc.
              page(params[:page])
    render 'slides/index'
  end
end
