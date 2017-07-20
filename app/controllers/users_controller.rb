class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def account
    @user = current_user
  end

  def show
    @user = User.find_by(username: params[:username])
    @slide = @user.slides.preload(:user).
             is_public.
             published_at_desc.
             page(params[:page])
  end
end
