require 'securerandom'

puts "--------------------------------------------------------------------------------------------------"
# add a customer
puts "1. Add a customer by admin"
cust_id1 = SecureRandom.uuid
command_to_run = "ruby main.rb admin add_customer #{cust_id1} Subham 6190234543 Indiranagar"
if system(command_to_run)
	puts "Add customer successful"
end
puts "--------------------------------------------------------------------------------------------------"

# get customer
puts "2. get all customers by admin"
command_to_run = "ruby main.rb admin get_all_customers"
if system(command_to_run)
	puts "get customers successful"
end

puts "--------------------------------------------------------------------------------------------------"
# add a restaurant 

puts "3. add a restaurant"
restaurant_id1 = SecureRandom.uuid
command_to_run = "ruby main.rb admin add_restaurant #{restaurant_id1} ABs Kormangala"
if system(command_to_run)
	puts "Add restaurant successful"
end

puts "--------------------------------------------------------------------------------------------------"

# add 2 food items to resturant with price and description 
puts "4. Add 2 food items to the restaurant"
command_to_run = "ruby main.rb restaurant_owner add_item #{restaurant_id1} Kabab 30 chicken_starter"
if system(command_to_run)
	puts "Add item Puchka successful"
end

command_to_run = "ruby main.rb restaurant_owner add_item #{restaurant_id1} Jalebi 50 sweets"
if system(command_to_run)
	puts "Add item Jalebi successful"
end

puts "--------------------------------------------------------------------------------------------------"

puts "5. Add delivery executive"
# add a delivery executive with name and phone number 
delivery_executive_id1 = SecureRandom.uuid
command_to_run = "ruby main.rb admin add_delivery_executive #{delivery_executive_id1} Mohan 7654234543"
if system(command_to_run)
	puts "Add delivery executive successful"
end

puts "--------------------------------------------------------------------------------------------------"

# search restaurant by customer
puts "6. Search all restaurants by customer"
command_to_run = "ruby main.rb customer get_all_restaurants"
if system(command_to_run)
	puts "get all restaurants by customer successful"
end

puts "--------------------------------------------------------------------------------------------------"

# search menu by customer
puts "7. Search menu of a restaurant"
command_to_run = "ruby main.rb customer get_restaurant_menu #{restaurant_id1}"
if system(command_to_run)
	puts "get restaurant menu by customer successful"
end

puts "--------------------------------------------------------------------------------------------------"

# place order for food items
puts "8. Place order for food item"
order_id1 = SecureRandom.uuid
command_to_run = "ruby main.rb customer order_item #{order_id1} #{cust_id1} #{restaurant_id1} Kabab 2"
if system(command_to_run)
	puts "order item  by customer successful"
end

puts "--------------------------------------------------------------------------------------------------"
# confirm the order from restaurant 
# filter order by restaurant and status PLACED
puts "9. get placed orders by restaurant and confirm"
command_to_run = "ruby main.rb restaurant_owner get_order #{restaurant_id1} "
if system(command_to_run)
	puts "get order by restaurant successful"
end
# confirm order by restaurant 
command_to_run = "ruby main.rb restaurant_owner confirm_order #{restaurant_id1} #{order_id1}"
if system(command_to_run)
	puts "confirm order by restaurant successful"
end

puts "--------------------------------------------------------------------------------------------------"


# assign a delivery executive by admin 
# filter orders with status confirmed
puts "10. Get confirmed orders by  admin to assign delivery executive and assign one"
command_to_run = "ruby main.rb admin get_confirmed_orders"
if system(command_to_run)
	puts "getting confirmed orders successful"
end
# search excutives that are free
command_to_run = "ruby main.rb admin get_available_executives"
if system(command_to_run)
	puts "get executive by admin successful"
end
# assign one from them and update the state of order to assigned and state of executive to busy 
command_to_run = "ruby main.rb admin assign_executive #{order_id1} #{delivery_executive_id1} "
if system(command_to_run)
	puts "assign to executive successful"
end

puts "--------------------------------------------------------------------------------------------------"

# check assignment status by delivery executive
# check assigned status and order id
puts "11. Get orders assigned by a executive and pick-up order"
command_to_run = "ruby main.rb delivery_executive get_assigned_orders #{delivery_executive_id1}"
if system(command_to_run)
	puts "getting assigned orders to executive successful"
end 
# update status of order to PICKUP
command_to_run = "ruby main.rb delivery_executive pick_up #{order_id1} #{delivery_executive_id1}"
if system(command_to_run)
	puts "order #{order_id1} pickup successful"
end

puts "--------------------------------------------------------------------------------------------------"

# search order status by customer
puts "12. Search order details by customer"
command_to_run = "ruby main.rb customer get_order_details #{order_id1} #{cust_id1}"
if system(command_to_run)
	puts "order #{order_id1} details retrieved successfully"
end


puts "--------------------------------------------------------------------------------------------------"
# deliver order by executive 
# set status of order to DELIVERED
puts "13. Set status of order to delivered by executive"  
command_to_run = "ruby main.rb delivery_executive deliver #{order_id1} #{delivery_executive_id1}"
if system(command_to_run)
	puts "order #{order_id1} deliver successful"
end

puts "--------------------------------------------------------------------------------------------------"

# get status of order by customer 
# search order status by customer
puts "14. Search order details by customer"
command_to_run = "ruby main.rb customer get_order_details #{order_id1} #{cust_id1}"
if system(command_to_run)
	puts "order #{order_id1} details retrieved successfully"
end

puts "--------------------------------------------------------------------------------------------------"