require 'securerandom'
require_relative 'console_app/order_handler.rb'
class OrdersController < ApplicationController
  def create
    # here first print the data that is coming
    puts "Received parameters in create action: #{params.inspect}"
    # the values are items, total, customer_id, restaurant_id
    # then using order handler add the order details that will persist it. 
    # you may have to change the backend implementations here. Work accordingly.
    order_id = SecureRandom.uuid
    items = params[:items]
    total = params[:total]
    customer_id = params[:customer_id]
    restaurant_id = params[:restaurant_id]
    order_handler = OrderHandler.new()
    order_handler.load
    order_handler.place_order(order_id, restaurant_id, customer_id, items, total)
    redirect_to customer_order_path(customer_id: customer_id, order_id: order_id)
    # render json: { message: "Order placed successfully!", order_id: order_id }, status: :created
  end

  def show
  end


  def index
    order_handler = OrderHandler.new()
    order_handler.load
    @order_details = order_handler.get_all_orders()
    puts "Aniket #{@order_details}"
  end
end