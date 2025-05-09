# Order states
# PLACED 
# CONFIRMED
# ASSIGNED
# PICKED UP
# DELIVERED


class Order
	def initialize(order_id, restaurant_id, customer_id, items, total, status, executive_id)
		@order_id = order_id
		@restaurant_id = restaurant_id
		@customer_id = customer_id
		@items = items
		@price = total
		@status = status
		@executive_id = executive_id
	end

	def get_id()
		return @order_id
	end

	def get_restaurant_id
		return @restaurant_id
	end

	def get_customer_id
		return @customer_id 
	end

	def get_food_item
		return @items 
	end

	def get_price
		return @price 
	end

	def get_status
		return @status 
	end

	def set_status(status)
		@status = status
	end

	def get_executive_id
		return @executive_id
	end

	def set_executive(executive_id)
		@executive_id = executive_id
	end
end

