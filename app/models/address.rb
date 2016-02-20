class Address
	attr_accessor :city, :state, :location

	def initialize()
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
	          address = Address.new()
	          address.city = object[:city]
	          address.state = object[:state]
	          address.location = object[:loc]
	          address.mongoize
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
	      	address = Address.new()
	      	address.city = object[:city]
	      	address.state = object[:state]
	      	address.location = location
	        return address
	      end
	    else object
	    end		
	end
end
