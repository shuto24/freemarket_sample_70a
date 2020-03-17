class PostsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.item_images.new
    @prefecture = Addresse.where('prefecture_id IN(?)', params[:prefecture_id])
    @categorie_parent_array = ["---"]
    Categorie.where(ancestry: nil).each do |f|
    @categorie_parent_array << f.name
    end
  end
  
  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

end

private

def item_params
  params.require(:item).permit(item_images_attributes: [:item_image])
end