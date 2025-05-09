require_relative 'customer_handler.rb'
require_relative 'restaurant_handler.rb'
require_relative 'delivery_executive_handler.rb'
require_relative 'order_handler.rb'
customer_handler = CustomerHandler.new()
customer_handler.load
restaurant_handler = RestaurantHandler.new()
restaurant_handler.load
delivery_executive_handler = DeliveryExecutiveHandler.new()
delivery_executive_handler.load
order_handler = OrderHandler.new()
order_handler.load
# puts "enter role: Options: restaurant_owner, customer, admin, delivery_executive"
role = ARGV[0]

if role == "restaurant_owner"
	# puts "Enter action: add_item, delete_item, check_new_order, accept_order, reject_order, close_restaurant, open_restaurant"
    action = ARGV[1]
    if action == "add_item"
    	restaurant_id = ARGV[2]
    	item_name = ARGV[3]
    	price = ARGV[4]
    	description = ARGV[5]
    	restaurant_handler.add_food_item(restaurant_id, item_name, price, description)
    end
	if action == "get_order"
		restaurant_id = ARGV[2]
		order_handler.get_open_order_by_restaurant(restaurant_id)
	end	
	if action == "confirm_order"
		restaurant_id = ARGV[2]
		order_id = ARGV[3]
		order_handler.confirm_order(restaurant_id, order_id)
	end	    
end

if role == "customer"
	# puts "Enter action: get_restaurants, get_menu, select_items_from_menu, place_order, get_order_status"
	action = ARGV[1]
	if action == "get_all_restaurants"
		restaurant_handler.get_all_restaurants
	end	
	if action == "get_restaurant_menu"
		restaurant_id = ARGV[2]
		restaurant_handler.get_menu(restaurant_id)
	end	
	if action == "order_item"
		order_id = ARGV[2]
		customer_id = ARGV[3]
		restaurant_id = ARGV[4]
		food_name = ARGV[5]
		qty = ARGV[6]
		# first get price of the food item 
		price = restaurant_handler.get_price(restaurant_id, food_name)
		# convert the price to float
		# here we need order handler 
        order_handler.place_order(order_id, restaurant_id, customer_id, food_name, qty, price)
		# restaurant_handler.get_menu(restaurant_id)
	end	
	if action == "get_order_details"
		order_id = ARGV[2]
		order_handler.get_order_details(order_id)
	end		
end

if role == "admin"
	#puts "Enter action: add_restaurant, remove_restaurant, add_customer, remove_customer, add_delivery_excutive, remove_delivery_excutive, 
	#	  get_all_customers, get_all_restuarants, get_all_delivery_executives, get_fresh_order, assign_delivery_to_order, track_order"
	action = ARGV[1]
	#puts "Action selected #{action}"
	if action == "add_customer"
		cust_id = ARGV[2]
		cust_name = ARGV[3]
		phone_number = ARGV[4]
		address = ARGV[5]
		customer_handler.add_customer(cust_id, cust_name, phone_number, address)
	end
	if action == "get_all_customers"
		customer_handler.get_all_customers
	end
	if action == "add_restaurant"
        restaurant_id = ARGV[2]
		restaurant_name = ARGV[3]
		address = ARGV[4]
		restaurant_handler.add_restaurant(restaurant_id, restaurant_name, address)
	end
	if action == "add_delivery_executive"
		delivery_executive_id = ARGV[2]
		executive_name = ARGV[3]
		phone_number = ARGV[4]
		delivery_executive_handler.add_executive(delivery_executive_id, executive_name, phone_number)
	end
	if action == "get_confirmed_orders"
		order_handler.get_confirmed_orders()
	end
	if action == "get_available_executives"
		delivery_executive_handler.get_available_executives()
	end
	if action == "assign_executive"
		order_id = ARGV[2]
		executive_id = ARGV[3]
		order_handler.assign_executive(order_id, executive_id)
		delivery_executive_handler.update_status(executive_id)
	end
end

if role == "delivery_executive"
	action = ARGV[1]
	if action == "get_assigned_orders"
		executive_id = ARGV[2]
		order_handler.get_assigned_orders(executive_id)
	end
	if action == "pick_up"
		order_id = ARGV[2]
		executive_id = ARGV[3]
		order_handler.pick_up_order(order_id, executive_id)
	end
	if action == "deliver"
		order_id = ARGV[2]
		executive_id = ARGV[3]
		order_handler.deliver_order(order_id, executive_id)
		delivery_executive_handler.update_status(executive_id)
	end	
end
