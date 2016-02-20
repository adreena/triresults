class Event
  include Mongoid::Document

  field :o, as: :order, type: Integer
  field :n, as: :name,type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true

  validates_presence_of :name
  validates_presence_of :order

  def meters
  	if self[:units].nil?
  		nil
  	elsif self[:units].downcase == "miles"
  		self[:distance]*1609.34
  	elsif self[:units].downcase == "kilometers"
  		self[:distance]*1000
  	elsif self[:units].downcase == "yards"
  		self[:distance]*0.9144
  	elsif self[:units].downcase == "meters"
  		self[:distance]
  	end
  end

  def miles
  	if self[:units].nil?
  		nil
  	elsif self[:units].downcase == "meters"
  		self[:distance]*0.000621371
  	elsif self[:units].downcase == "kilometers"
  		self[:distance]*0.621371
  	elsif self[:units].downcase == "yards"
  		self[:distance]*0.000568182
  	elsif self[:units].downcase == "miles"
  		self[:distance]
  	end
  end
end
