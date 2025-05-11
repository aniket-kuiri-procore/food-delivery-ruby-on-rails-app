require 'securerandom'
require_relative 'console_app/customer_handler'
require_relative 'console_app/restaurant_handler'
require_relative 'console_app/order_handler.rb'
class CustomersController < ApplicationController
  def new
    # This action will render the app/views/customers/new.html.erb form.
  end

  def create
    puts "Received POST request to /customers"
    puts "Parameters: #{params.inspect}"

    name = params[:name]
    phone_number = params[:phone_number]
    address = params[:address]

    puts "Name: #{name}"
    puts "Phone Number: #{phone_number}"
    puts "Address: #{address}"

    cust_id = SecureRandom.uuid
    #puts "#{Dir.pwd}"
    #command_to_run = "ruby #{Dir.pwd}/app/controllers/console_app/main.rb admin add_customer #{cust_id} #{name} #{phone_number} #{address}"
    # need to assign absolute paths to data directory as well
    #if system(command_to_run)
    #    puts "Add customer successful"
    #end
    customer_handler = CustomerHandler.new()
    customer_handler.load
    customer_handler.add_customer(cust_id, name, phone_number, address)
    # if it fails, the do not redirect
    redirect_to customer_path(id: cust_id)
  end

  def show
    @customer_id = params[:id]
    customer_handler = CustomerHandler.new()
    customer_handler.load
    customer_details = customer_handler.get_customer_details(@customer_id)
    if customer_details != {}
      @name = customer_details['name']
      @phone_number = customer_details['phone_number']
      @address = customer_details['address']
    end
    # puts "show action called for customer id #{@customer_id}"
    # get customer details from console app and then pass it 
    # to view 
  end

  def index
    # show all customers
    customer_handler = CustomerHandler.new()
    customer_handler.load
    @customers_list = customer_handler.get_all_customers()
  end

  def get_restaurants
    @customer_id = params[:customer_id]
    restaurant_handler = RestaurantHandler.new()
    restaurant_handler.load
    @restaurants_list = restaurant_handler.get_all_restaurants()
  end

  def get_restaurant_menu
    @customer_id = params[:customer_id]
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

  def place_order
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
    # redirect_to customer_order_path(customer_id: customer_id, order_id: order_id)
    render json: { message: "Order placed successfully!", order_id: order_id }, status: :created
  end

  def show_order
    customer_id = params[:customer_id]
    order_id = params[:order_id]
    puts "Aniket"
    puts "#{customer_id}"
    puts "#{order_id}"
    puts "Aniket"
    # here you have to display the following
    # order id
    # restaurant id
    # items 
    # total amount 
    # status 
    # delivery executive id
    order_handler = OrderHandler.new()
    order_handler.load
    @order_details = order_handler.get_order_details(order_id)
  end
end
