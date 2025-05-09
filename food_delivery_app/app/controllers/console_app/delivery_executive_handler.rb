require_relative 'delivery_executive.rb'
require 'json'
class DeliveryExecutiveHandler
    def initialize
    	@executives = {}
    	@filename = "#{Dir.pwd}/app/controllers/data/executives.json"
    end

    def add_executive(executive_id, executive_name, phone_number)
    	executive = DeliveryExecutive.new(executive_id, executive_name, phone_number)
        @executives[executive_id] = executive
        # restaurant_id = restaurant.get_id
        # @restaurant[restaurant_id] = { 'name' => restaurant.get_name, 'address' => restaurant.get_address }       
        persist
    end

    def persist
        executives_hash = {}
        @executives.each do |key, value|
            executives_hash[key] = { 'name' => value.get_name, 'phone_number' => value.get_phone_number, 'is_available' => value.is_free }
        end
        json_string = JSON.generate(executives_hash)
        File.open(@filename, 'w') do |file|
            file.write(json_string)
        end
    end

    def load
        # de-serialize
        begin
            file_content = File.read(@filename)
            executives_details = JSON.parse(file_content)
            executives_details.each do |key, value|
                @executives[key] = DeliveryExecutive.new(key, value['name'], value['phone_number'], value['is_available'])
            end
            # get_all_executives
        rescue JSON::ParserError => e
            puts "Executives json file parse error"
        rescue StandardError => e
            puts "Failed to load data from Executives json file #{e}"
        end
    end

    def get_all_executives()
    	@executives.each do |key, value|
    		puts "executive_id: #{key}, name: #{value.get_name}, phone: #{value.get_phone_number} is_available #{value.is_free}"
    	end
    end

    def get_available_executives()
        @executives.each do |key, value|
            status = value.is_free
            if status
                puts "executive_id: #{key}"
                return key # for now we are returning the first available executive_id
            end
        end
    end

    def get_executive_details(executive_id)
        executive_details = {}
        if @executives.key?(executive_id)
            executive = @executives[executive_id]
            executive_details['executive_id'] = executive.get_id
            executive_details['name'] = executive.get_name
            executive_details['phone_number'] = executive.get_phone_number
        end
        return executive_details
    end

    def update_status(executive_id)
        executive = @executives[executive_id]
        executive.toggle_status
        persist
    end
end