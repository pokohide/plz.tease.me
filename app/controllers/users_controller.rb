class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def show
    # @user = User.find_by(username: params[:username])
    @user = User.find(params[:id])
    @slide = @user.slides.preload(:user).
             # is_public.
             published_at_desc
                  .page(params[:page])
  end
end
