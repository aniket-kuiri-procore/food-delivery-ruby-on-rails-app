

class Customer
	def initialize(cust_id, cust_name, phone_number, address)
		@cust_id = cust_id
		@name = cust_name
		@phone_numer = phone_number
		@address = address
	end

	def get_id()
		return @cust_id
	end

	def get_name
		return @name
	end

	def get_address
		return @address 
	end

	def get_phone_number
		return @phone_numer
	end
end