class OrdersController < ApplicationController
  before_action :authenticate_user!
  
      def index
        @orders = current_user.orders
        render json: @orders, include: [{orders_descriptions: {include: :item}}]
      end
    
      def show
        @order = Order.find(params[:id])
        render json: @order, include: [{orders_descriptions: {include: :item}}]
      end
    
      def create
        @order = Order.new({user_id: current_user.id, amount: params[:amount]})
        
        if @order.save
          params[:items].each do |item|
            OrdersDescription.create({order_id: @order.id, item_id: item[:id], quantity: item[:quantity]})
          end
          render json: @order, include: [{orders_descriptions: {include: :item}}], status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    
      def update
      end
    
      def destroy
      end
    end