require_relative 'customer.rb'
require 'json'
class CustomerHandler
    def initialize
    	@customers = {}
    	@filename = "#{Dir.pwd}/app/controllers/data/customers.json"
    end

    def add_customer(cust_id, cust_name, phone_number, address)
    	customer = Customer.new(cust_id, cust_name, phone_number, address)
    	@customers[cust_id] = { 'name' => customer.get_name, 'phone_number' => customer.get_phone_number, 'address' => customer.get_address }    	
    	persist
    end

    def remove_customer(cust_id)
    	if validate_customer(cust_id)
    		# remove here
    		@customers.delete(cust_id)
    		persist
    	end
    end

    def validate_customer(cust_id)
    	if @customers.key?(cust_id)
    		return true    	
    	end
    	return false
    end

    def persist
    	# serialize
    	json_string = JSON.generate(@customers)
    	File.open(@filename, 'w') do |file|
    		file.write(json_string)
    	end
    end

    def load
    	# de-serialize
    	begin
    		file_content = File.read(@filename)
    		customer_details = JSON.parse(file_content)
    		@customers = customer_details
    		# get_all_customers
    	rescue JSON::ParserError => e
    		puts "Customers json file parse error"
    	rescue StandardError => e
    		puts "Failed to load data from Customers json file #{e}"
    	end

    end

    def get_all_customers()
        customers_list = []
    	@customers.each do |key, value|
            customer_data = {}
    		puts "cust_id: #{key}, name: #{value['name']}, phone: #{value['phone_number']}, address: #{value['address']}"
            customer_data['customer_id'] = key
            customer_data['name'] = value['name']
            customer_data['phone_number'] = value['phone_number']
            customer_data['address'] = value['address']
            customers_list.push(customer_data)
    	end
        return customers_list
    end

    def get_customer_details(cust_id)
        customer_details = {}
        if @customers.key?(cust_id)
            customer = @customers[cust_id]
            customer_details['cust_id'] = cust_id
            customer_details['name'] = customer['name']
            customer_details['address'] = customer['address']
            customer_details['phone_number'] = customer['phone_number']
        end
        return customer_details
    end

end