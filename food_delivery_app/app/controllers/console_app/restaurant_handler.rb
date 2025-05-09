# handle restaurant list

# add remove restaurant 

# add remove item from menu

# get and confirm/reject order

require_relative 'restaurant.rb'
require 'json'

class RestaurantHandler
	def initialize
		@restaurants = {}
		@restaurants_json_path = "#{Dir.pwd}/app/controllers/data/restaurants.json"
	end

	def add_restaurant(restaurant_id, name, address)
		puts "Adding restaurant #{restaurant_id} #{name} #{address}"
		restaurant = Restaurant.new(restaurant_id, name, address)
		@restaurants[restaurant_id] = restaurant
   	    # restaurant_id = restaurant.get_id
    	# @restaurant[restaurant_id] = { 'name' => restaurant.get_name, 'address' => restaurant.get_address }    	
    	persist
	end

	def add_food_item(restaurant_id, food_name, price, description)
		puts "Adding food item to Restaurant #{restaurant_id} with details #{food_name} #{price} #{description}"
		if @restaurants.key?(restaurant_id)
			restaurant = @restaurants[restaurant_id]
			restaurant.add_item(food_name, price, description)
			persist
		else
			puts "Restaurant with restaurant id #{restaurant_id} not present"
		end
	end

    def check_new_order
    end

    def get_all_restaurants
        restaurants_list = []
    	@restaurants.each do |key, value|
            restaurant_data = {}
    		puts "restaurant_id: #{key}, name: #{value.get_name}, address: #{value.get_address}"
            restaurant_data['restaurant_id'] = key
            restaurant_data['name'] = value.get_name
            restaurant_data['address'] = value.get_address
            restaurants_list.push(restaurant_data)
    	end
        return restaurants_list
    end

    def get_restaurant_details(restaurant_id)
        restaurant_details = {}
        if @restaurants.key?(restaurant_id)
            restaurant = @restaurants[restaurant_id]
            restaurant_details['restaurant_id'] = restaurant_id
            restaurant_details['name'] = restaurant.get_name
            restaurant_details['address'] = restaurant.get_address
            restaurant_details['menu'] = restaurant.get_menu
        end
        return restaurant_details
    end

    def get_menu(restaurant_id)
        if @restaurants.key?(restaurant_id)
        	restaurant = @restaurants[restaurant_id]
        	puts "Menu for restaurant: #{restaurant.get_name}, #{restaurant.get_menu}"
        end
    end

    def get_price(restaurant_id, food_name)
    	if @restaurants.key?(restaurant_id)
    		restaurant = @restaurants[restaurant_id]
    		menu = restaurant.get_menu()
    		if menu.key?(food_name)
    			food_details = menu[food_name]
    			price = food_details['price']
    			return price
    		end 
    	end 
    	return 0
    end

    def confirm_order
    end

    def load
    	# de-serialize
    	begin
    		file_content = File.read(@restaurants_json_path)
    		restaurants_details = JSON.parse(file_content)
    		restaurants_details.each do |key, value|
    			@restaurants[key] = Restaurant.new(value['restaurant_id'], value['name'], value['address'], value['menu'])
    		end
    		# get_all_restaurants
    	rescue JSON::ParserError => e
    		puts "Restaurants json file parse error"
    	rescue StandardError => e
    		puts "Failed to load data from Restaurants json file #{e}"
    	end

    end

    def persist
    	restaurants_hash = {}
    	@restaurants.each do |key, value|
    		restaurants_hash[key] = { 'name' => value.get_name, 'address' => value.get_address, 'menu' => value.get_menu }
    	end
    	json_string = JSON.generate(restaurants_hash)
    	File.open(@restaurants_json_path, 'w') do |file|
    		file.write(json_string)
    	end
    end

end