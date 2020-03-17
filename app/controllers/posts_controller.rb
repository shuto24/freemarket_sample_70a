class PostsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    @item_image = @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save

      params[:item_images]['image'].each do |img|
        @item_image = @item.item_images.create(:image => img, :item_id => @item.id)
      end

      redirect_to item_path(@item.id)
    end
  end

  
  
  def show
    @item = Item.find(params[:id])
    @user = @item.user
    @images = @item.item_images
    @image = @images.first
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ensure_correct_user
    @item = Item.find_by(id:params[:id])
    if @item.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  private
  def item_params
    params.require(:item).permit(item_images_attributes: [:id, :item_id, :item_image]).merge(user_id: current_user.id)
    # :name, :discription, :price, :condition, :shipping_charge, :shipping_date, :prefecture
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
