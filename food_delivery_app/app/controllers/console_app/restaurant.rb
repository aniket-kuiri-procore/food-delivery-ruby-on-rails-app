class Restaurant
	def initialize(restaurant_id, name, address, menu=nil)
		@restaurant_id = restaurant_id
		@name = name
		@address = address
		@menu = {}
		if menu != nil
			@menu = menu
		end
	end

	def get_id
		return @restaurant_id
	end

	def get_name
		return @name 
	end

	def get_address
		return @address 
	end

	def get_menu
		return @menu 
	end

	def add_item(food_name,  price, description)
		# food_id = SecureRandom.uuid
		@menu[food_name] = { 'name' => food_name, 'description' => description, 'price' => price, 'available' => true }
	end

end