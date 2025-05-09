require 'securerandom'
require_relative 'console_app/delivery_executive_handler.rb'
require_relative 'console_app/order_handler.rb'
class ExecutivesController < ApplicationController
  def new
  end

  def create
    puts "Received POST request to /executives"
    puts "Parameters: #{params.inspect}"

    executive_id = SecureRandom.uuid
    name = params[:name]
    phone_number = params[:phone_number]

    puts "Name: #{name}"
    puts "Phone Number: #{phone_number}"

    #puts "#{Dir.pwd}"
    #command_to_run = "ruby #{Dir.pwd}/app/controllers/console_app/main.rb admin add_customer #{cust_id} #{name} #{phone_number} #{address}"
    # need to assign absolute paths to data directory as well
    #if system(command_to_run)
    #    puts "Add customer successful"
    #end
    executive_handler = DeliveryExecutiveHandler.new()
    executive_handler.load
    executive_handler.add_executive(executive_id, name, phone_number)
    # if it fails, the do not redirect
    redirect_to executive_path(executive_id: executive_id)
  end

  def show
    @executive_id = params[:executive_id]
    executive_handler = DeliveryExecutiveHandler.new()
    executive_handler.load
    executive_details = executive_handler.get_executive_details(@executive_id)
    if executive_details != {}
      @name = executive_details['name']
      @phone_number = executive_details['phone_number']
    end
  end

  def view_order
    @executive_id = params[:executive_id]
    order_handler = OrderHandler.new()
    order_handler.load
    @order_details = order_handler.get_assigned_orders(@executive_id)
  end

  def pick_up
    @executive_id = params[:executive_id]
    @order_id = params[:order_id]
    # update status of order to pickup
    order_handler = OrderHandler.new()
    order_handler.load
    order_handler.pick_up_order(@order_id, @executive_id)
  end

  def deliver
    @executive_id = params[:executive_id]
    @order_id = params[:order_id]
    # update status of order to deliver
    order_handler = OrderHandler.new()
    order_handler.load
    order_handler.deliver_order(@order_id, @executive_id)
  end
end
