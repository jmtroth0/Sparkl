class Api::AlbumsController < ApplicationController
  def create
    @album = current_user.albums.new(album_params)

    if @album.save
      render json: @album
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @albums = current_user.albums
    render json: @albums
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      flash[:notice] = ["Updated"]
      redirect_to :back
    else
      render json: @album.errors.full_messages, status: :unprocessable_entity
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def destroy
    @album = current_user.albums.find(params[:id])
    @album.destroy
    render json: {}
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end
end
