require_relative 'order.rb'
require 'json'

class OrderHandler
	def initialize
		@orders = {}
		@filename = "#{Dir.pwd}/app/controllers/data/orders.json"
	end

	def place_order(order_id, restaurant_id, customer_id, items, total)
		# order_handler.place_order(order_id, restaurant_id, customer_id, items, total)
		order = Order.new(order_id, restaurant_id, customer_id, items, total, "PLACED", "")
		@orders[order_id] = order
		persist
	end

	def assign_executive()

	end

	def update_status()

	end

	def get_order_details(order_id)
		order_detail = {}
		if @orders.key?(order_id)
			order = @orders[order_id]
			puts "order_id #{order_id}"
			order_detail['order_id'] = order_id
			puts "restaurant_id #{order.get_restaurant_id}"
			order_detail['restaurant_id'] = order.get_restaurant_id
			puts "customer_id #{order.get_customer_id}"
			order_detail['customer_id'] = order.get_customer_id
			puts "status #{order.get_status}"
			order_detail['status'] = order.get_status
			puts "executive_id #{order.get_executive_id}"
			order_detail['executive_id'] = order.get_executive_id
		end
		return order_detail
	end

	def get_open_order_by_restaurant(restaurant_id)
		order_details = []
		@orders.each do |key, value|
			order_detail = {}
			status = value.get_status
			r_id = value.get_restaurant_id
			if r_id == restaurant_id and status == "PLACED"
				order_detail['order_id'] = value.get_id
				order_detail['customer_id'] = value.get_customer_id 
				order_detail['items'] = value.get_food_item
				order_details.push(order_detail)
			end
		end
		puts "Open orders for restaurant #{restaurant_id}: #{order_details}"
		return order_details
	end

	def confirm_order(restaurant_id, order_id)
		if @orders.key?(order_id)
			order = @orders[order_id]
			r_id = order.get_restaurant_id
			status = order.get_status
			if r_id == restaurant_id and status == "PLACED"
				order.set_status("CONFIRMED")
				persist
				puts "Order confirmed by restaurant"
			end 
		end
	end


	def reject_order(restaurant_id, order_id)
		if @orders.key?(order_id)
			order = @orders[order_id]
			r_id = order.get_restaurant_id
			status = order.get_status
			if r_id == restaurant_id and status == "PLACED"
				order.set_status("REJECTED")
				persist
				puts "Order confirmed by restaurant"
			end 
		end
	end

	def get_confirmed_orders()
		order_details = []
		@orders.each do |key, value|
			status = value.get_status
			if status == "CONFIRMED"
				order_details.push(key)
			end
		end
		puts "Confirmed orders list #{order_details}"
	end

	def assign_executive(order_id, executive_id)
		if @orders.key?(order_id)
			order = @orders[order_id]
			status = order.get_status
			if status == "CONFIRMED"
				order.set_executive(executive_id)
				order.set_status("ASSIGNED")
				persist
				puts "Order assigned to executive #{executive_id}"
			end 
		end
	end


    def get_assigned_orders(executive_id)
		order_details = []
		@orders.each do |key, value|
			order_detail = {}
			status = value.get_status
			e_id = value.get_executive_id
			if e_id == executive_id and (status == "ASSIGNED" or status == "PICKED")
    			order_detail['order_id'] = key
    			order_detail['customer_id'] = value.get_customer_id
    			order_detail['restaurant_id'] = value.get_restaurant_id
    			order_detail['status'] = value.get_status
    			order_details.push(order_detail)
			end
		end
		puts "Assigned orders list #{order_details}"
		return order_details
	end

	def pick_up_order(order_id, executive_id)
		if @orders.key?(order_id)
			order = @orders[order_id]
			e_id = order.get_executive_id
			status = order.get_status
			if e_id == executive_id and status == "ASSIGNED"
				order.set_status("PICKED")
				persist
				puts "Order #{order_id} assigned to executive #{executive_id} picked up"
			end 
		end
	end 

	def deliver_order(order_id, executive_id)
		if @orders.key?(order_id)
			order = @orders[order_id]
			e_id = order.get_executive_id
			status = order.get_status
			if e_id == executive_id and status == "PICKED"
				order.set_status("DELIVERED")
				persist
				puts "Order #{order_id} delivered by executive #{executive_id}"
			end 
		end
	end   	

	def get_order_by_customer(customer_id)
	end

	def get_all_orders()
		order_details = []
    	@orders.each do |key, value|
    		order_detail = {}
    		puts "ID: #{key}, status: #{value.get_status}"
    		order_detail['order_id'] = key
    		order_detail['customer_id'] = value.get_customer_id
    		order_detail['executive_id'] = value.get_executive_id
    		order_detail['restaurant_id'] = value.get_restaurant_id
    		order_detail['status'] = value.get_status
    		#food_item_arr = value.get_food_item
            #food_items = []
            #puts "Aniket Datatype of food_item_arr: #{food_item_arr.class}"
            #food_item_arr.each do |item|
            #	puts "Aniket Datatype of item: #{item.class}"
                # puts "Aniket #{item['name']}   #{item['quantity']}"
            #end
    		order_detail['items'] = value.get_food_item 
    		order_detail['price'] = value.get_price
    		order_details.push(order_detail)
    	end
    	return order_details
	end

	def load
        # de-serialize
        begin
            file_content = File.read(@filename)
            order_details = JSON.parse(file_content)
            order_details.each do |key, value|
                @orders[key] = Order.new(key, value['restaurant_id'], value['customer_id'], value['items'], value['price'], value['status'], value['executive_id'])
            end
            #get_all_orders
        rescue JSON::ParserError => e
            puts "Orders json file parse error"
        rescue StandardError => e
            puts "Failed to load data from Orders json file #{e}"
        end
	end

	def persist
        orders_hash = {}
        @orders.each do |key, value|
            orders_hash[key] = { 'restaurant_id' => value.get_restaurant_id, 'customer_id' => value.get_customer_id, 'items' => value.get_food_item, 'price' => value.get_price, 'status' => value.get_status, 'executive_id' => value.get_executive_id }
        end
        json_string = JSON.generate(orders_hash)
        File.open(@filename, 'w') do |file|
            file.write(json_string)
        end
	end
end