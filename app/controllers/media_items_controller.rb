class MediaItemsController < ApplicationController
  before_action :require_user

  before_action :set_item, only: [:show, :destroy, :edit, :update]

  def index
    @media_items = MediaItem.where(user: current_user)
  end

  def new
    @media_item = MediaItem.new
  end

  def create
    @media_item = MediaItem.new(media_item_params)
    @media_item.user = current_user
    if @media_item.save
      redirect_to root_path
    else
      render new_media_item_path
    end
  end

  def show
    @url = URI.extract(@media_item.description)
    @object = LinkThumbnailer.generate("http://stackoverflow.com") 
  end

  def edit
  end

  def update
    if @media_item.update(media_item_params)
      flash[:notice] = "This media item has been updated."
      redirect_to media_item_path(@media_item)
    else
      render 'edit'
    end
  end

  def destroy
    @media_item.destroy if current_user.media_items.include?(@media_item)
    redirect_to media_items_path
  end

  def search
    @results = MediaItem.search_by_title(params[:search_term])
  end

  def set_item
    @media_item = MediaItem.find(params[:id])
  end

  private

  def media_item_params
    params.require(:media_item).permit!
  end
end