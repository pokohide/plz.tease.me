class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def account
    @user = current_user
    @slides = @user.slides.preload(:user).
              # is_public.
              published_at_desc
                   .page(params[:page]).per(5)
    @stared_slides = @user.stared_slides.
              # is_public.
              published_at_desc
                   .page(params[:page]).per(5)
  end

  def show
    @user = User.find_by(username: params[:username])
    @slides = @user.slides.preload(:user).
              # is_public.
              published_at_desc
                   .page(params[:page]).per(5)
    @stared_slides = @user.stared_slides.preload(:user).
              # is_public.
              published_at_desc
                   .page(params[:page]).per(5)
  end
end
