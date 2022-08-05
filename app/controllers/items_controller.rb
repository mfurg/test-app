class ItemsController < ApplicationController
  #before_action :authenticate_user!

  def index
    @items = searched_items(params[:search])
    @count = Item.count
    render json: { items: @items, count: @count }
  end

  def show
    @item = Item.find(params[:id])
    render json: @item
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    head :no_content
  end

  private
  def searched_items(query)
    res = if query.present?
      Item.search(query).limit(params[:limit].to_i).offset(params[:offset].to_i)
    else
      Item.limit(params[:limit].to_i).offset(params[:offset].to_i)
    end
  end

  def item_params
    params.permit(:name, :description, :price)
  end
end