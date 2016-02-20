class Placing
	attr_accessor :name, :place

	def initialize (name, place)
		@name = name
		@place = place
	end

  	def mongoize
		{:name=> @name, :place=>@place}
	end

	def self.mongoize(object)
		case object
		when nil then nil
	    when Placing then object.mongoize
	    when Hash then 
	     # if object[:name] 
	        Placing.new(object[:name], object[:place]).mongoize
	     # end
	    else object
	    end
	end

	def self.evolve(object)
		mongoize(object)
	end

	def self.demongoize(object)
		case object
		when nil then nil
	    when Placing then object
	    when Hash then 
	      #if object[:name]
	      	#puts "hi"
	        return Placing.new(object[:name], object[:place])
	      #end
	    else object
	    end		
	end
end