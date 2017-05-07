require 'pry'

class Station < ActiveRecord::Base
  belongs_to :city
  validates :name,
            :latitude,
            :longitude,
            :dock_count,
            :installation_date,
            presence: true


  def self.generate_list_of_names(object)
    if object.length == 1
      Array.new << object.first.name
    else
      object.map{ | item | item.name }.flatten
    end
  end

  def self.oldest_date(attribute)
    self.minimum(attribute)
  end

  def self.newest_date(attribute)
    self.maximum(attribute)
  end

  def self.newest_stations
    generate_list_of_names(self.where(installation_date: self.newest_date(:installation_date)))
  end

  def self.oldest_stations
    generate_list_of_names(self.where(installation_date: self.oldest_date(:installation_date)))
  end
end
