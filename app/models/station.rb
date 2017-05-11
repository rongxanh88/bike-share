require 'will_paginate'
require 'will_paginate/active_record'

class Station < ActiveRecord::Base
  include WillPaginate::Sinatra::Helpers
  default_scope { order(name: :asc) }

  belongs_to :city
  has_many :station_statuses
  has_many :trips
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

  def self.newest_stations
    generate_list_of_names(self.where(installation_date: self.maximum(:installation_date)))
  end

  def self.oldest_stations
    generate_list_of_names(self.where(installation_date: self.minimum(:installation_date)))
  end

  def self.most_docks
    generate_list_of_names(self.where(dock_count: self.maximum(:dock_count)))
  end

  def self.fewest_docks
    generate_list_of_names(self.where(dock_count: self.minimum(:dock_count)))
  end

  def self.avg(attribute)
    self.average(attribute).round(2)
  end
end
