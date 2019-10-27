class UsersController < ApplicationController
  def index
    @users = User.all
    @blogs = Blog.all
    @photos = Photo.all
  end

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs.page(params[:page]).reverse_order
    @photos = @user.photos.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image)
  end
end

