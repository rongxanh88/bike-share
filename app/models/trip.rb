require 'pry'

class Trip < ActiveRecord::Base
  default_scope { order(start_date: :desc) }

  belongs_to :stations

  validates :duration, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_station_id, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_id, presence: true

  def self.generate_list_of_names(object)
    if object.length == 1
      binding.pry
      Array.new << object.first.name
    else
      object.map{ | item | item.name }.flatten
    end
  end

  def self.avg(attribute)
    self.average(attribute).round(2)
  end

  def self.most_common_start_station
    generate_list_of_names(self.where(start_station_id: self.maximum(:start_station_id)))
  end

end
