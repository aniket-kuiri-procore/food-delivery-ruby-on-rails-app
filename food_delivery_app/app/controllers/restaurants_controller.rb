require 'securerandom'
require_relative 'console_app/restaurant_handler.rb'
require_relative 'console_app/order_handler.rb'
require_relative 'console_app/delivery_executive_handler.rb'
class RestaurantsController < ApplicationController
  def new
  end

  def create
    puts "Received POST request to /restaurants"
    puts "Parameters: #{params.inspect}"
    name = params[:name]
    address = params[:address]
    puts "Name: #{name}"
    puts "Address: #{address}"
    restaurant_id = SecureRandom.uuid
    restaurant_handler = RestaurantHandler.new()
    restaurant_handler.load
    restaurant_handler.add_restaurant(restaurant_id, name, address)
    redirect_to restaurant_path(restaurant_id: restaurant_id)
  end

  def show
    @restaurant_id = params[:restaurant_id]
    restaurant_handler = RestaurantHandler.new()
    restaurant_handler.load
    restaurant_details = restaurant_handler.get_restaurant_details(@restaurant_id)
    if restaurant_details != {}
      @name = restaurant_details['name']
      @address = restaurant_details['address']
      @menu = restaurant_details['menu']
    end
  end

  def add_food_item
    @restaurant_id = params[:restaurant_id]
    puts "Adding food item to restaurant #{@restaurant_id}"
    food_name = params[:food_name]
    price = params[:price]
    description = params[:description]
    puts "Food Name: #{food_name}"
    puts "Price: #{price}"
    puts "Description: #{description}"
    restaurant_handler = RestaurantHandler.new()
    restaurant_handler.load
    restaurant_handler.add_food_item(@restaurant_id, food_name, price, description)
    # x = true
    redirect_to restaurant_path(restaurant_id: @restaurant_id)
    # render plain: "Food item details received via GET params"
  end

  def pending_orders
    @restaurant_id = params[:restaurant_id]
    order_handler = OrderHandler.new()
    order_handler.load
    @order_details = order_handler.get_open_order_by_restaurant(@restaurant_id)
    # get pending orders
    # pass them to views where there will be button for each order to confirm or reject
    # based on the button separate http calls will be made to confirm/reject and with that will be redirected to
    # pending orders page.  
  end

  def confirm_order
    @restaurant_id = params[:restaurant_id]
    @order_id = params[:order_id]
    order_handler = OrderHandler.new()
    order_handler.load
    order_handler.confirm_order(@restaurant_id, @order_id)
    # create a standalone script to assign orders to executives
    # first get pending orders
    # assign orders to executive
    # for now you cna just assign it to someone by directly calling here
    executive_handler = DeliveryExecutiveHandler.new()
    executive_handler.load
    order_handler = OrderHandler.new()
    order_handler.load
    executive_id = executive_handler.get_available_executives()
    order_handler.assign_executive(@order_id, executive_id)
    executive_handler.update_status(executive_id)
    head :ok
  end

  def reject_order
    @restaurant_id = params[:restaurant_id]
    @order_id = params[:order_id]
    order_handler = OrderHandler.new()
    order_handler.load
    order_handler.reject_order(@restaurant_id, @order_id)
    head :ok
  end

  def index
    # view all restaurants
    restaurant_handler = RestaurantHandler.new()
    restaurant_handler.load
    @restaurants_list = restaurant_handler.get_all_restaurants()
  end

end
