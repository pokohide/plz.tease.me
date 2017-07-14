class RootController < ApplicationController
  def index
    @slides = Slide.preload(:user).
                # is_public.
                published_at_desc.
                page(params[:page])
  end

  def about
  end

  def contact
  end
end
