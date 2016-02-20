class Point
	attr_accessor :longitude , :latitude

	def initialize(lng, lat)
		@longitude = lng
		@latitude = lat
	end

	def mongoize
		{:type=>"Point", :coordinates=>[@longitude,@latitude]}
	end

	def self.mongoize(object)
		case object
		when nil then nil
	    when Point then object.mongoize
	    when Hash then 
	      if object[:type] #in GeoJSON Point format
	          Point.new(object[:coordinates][0], object[:coordinates][1]).mongoize
	      else       #in legacy format
	          Point.new(object[:lng], object[:lat]).mongoize
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
	    when Point then object
	    when Hash then 
	      if object[:type] #in GeoJSON Point format
	          Point.new(object[:coordinates][0], object[:coordinates][1])
	      else       #in legacy format
	          Point.new(object[:lng], object[:lat])
	      end
	    else object
	    end		
	end
end