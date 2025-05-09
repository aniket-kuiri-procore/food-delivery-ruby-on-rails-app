class DeliveryExecutive
	def initialize(executive_id, executive_name, phone_number, is_available=nil)
		@executive_id = executive_id
		@name = executive_name
		@phone_numer = phone_number
		@is_available = true
		if is_available != nil
			@is_available = is_available
		end
	end

	def get_id()
		return @executive_id
	end

	def get_name
		return @name
	end

	def get_phone_number
		return @phone_numer
	end

	def is_free
		return @is_available
	end

	def toggle_status
		if @is_available
			@is_available = false
		else
			@is_available = true
		end
	end
end