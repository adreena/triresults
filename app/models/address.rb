class Address
	attr_accessor :city, :state, :location

	def initialize(city,state,location)
		@city= city
		@state = state
		@location = location
	end

  	def mongoize
		{:city=> @city, :state=>@state, :loc => location.mongoize}
	end

	def self.mongoize(object)
		case object
		when nil then nil
	    when Address then object.mongoize
	    when Hash then 
	      if object[:city] 
	          Address.new(object[:city], object[:state], object[:loc]).mongoize
	      end
	    else object
	    end
	end

	def self.evolve(object)
		mongoize(object)
	end

	def self.demongoize(object)
		case object
		when nil then nil
	    when Address then object
	    when Hash then 
	      if object[:city]
	      	#puts "hi"
	      	location = Point.demongoize(object[:loc])
	        return Address.new(object[:city], object[:state], location)
	      end
	    else object
	    end		
	end
end
