class PhotosController < ApplicationController
  def new
	@photo = Photo.new
  end

  def index
  	@photos = Photo.page(params[:page]).per(5)
    @photo = Photo.new
  end

  def show
  	@photo = Photo.find(params[:id])
    @photo_comments = @photo.photo_comments
    @photo_comment = PhotoComment.new
  end
  def edit
  	@photo = Photo.find(params[:id])
  end

  def update
  	 photo = Photo.find(params[:id])
  	 photo.update(photo_params)
  	 redirect_to photos_path(photo.id)
  end

  def create
  	@photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      flash[:success] = "投稿に成功しました。"
      redirect_to photos_path
    else
      render :new
    end
  end
  def destroy
  	photo = Photo.find(params[:id]) 
    photo.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to  photos_path
  end

  private

  def photo_params
  	params.require(:photo).permit(:title,:name,:date,:location,:comment,:image,:content)
  end
end
