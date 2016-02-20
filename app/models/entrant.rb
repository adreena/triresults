class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :the_race

  store_in collection: "results"
  field :bib, type: Integer
  field :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, type: Placing
  field :group, type: Placing

  embeds_many :results, class_name: 'LegResult', order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: 'RaceRef'

  def update_total(result)
  	if results
	  	self.secs = 0
	  	self.results.each do |doc|
	  		self.secs = self.secs + doc.secs
	  	end
		return self.secs
	else
		nil
	end
  end

  def the_race
  	return self.race.race
  end

end
