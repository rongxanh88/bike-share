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

  def self.avg(attribute)
    self.average(attribute).round(2)
  end

  def self.most_common(of_attribute)
    collection = self.pluck(of_attribute)
    m_common_of(collection)
    #collection.max_by { |i| collection.count(i) }
  end

  def self.least_common(of_attribute)
    collection = self.pluck(of_attribute)
    l_common_of(collection)
    #collection.min_by { |i| collection.count(i) }
  end

  def self.rides_by_month(month, year)
    year_array = self.where('extract(year from start_date) = ?', year)
    year_array.where('extract(month from start_date) = ?', month).count
  end

  def self.rides_by_year(year)
    self.where('extract(year from start_date) = ?', year).count
  end

  def self.number_of_subscriptions(sub_id)
    self.where(subscription_id: sub_id).count
  end

  def self.started_at(station)
    self.where(start_station_id: station)
  end

  def self.ended_at(station)
    self.where(end_station_id: station)
  end

  def end_stations_per_start_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:end_station_id)
  end

  def start_stations_per_end_station(end_station_id)
    self.where(end_station_id: end_station_id).pluck(:start_station_id)
  end

  def start_date_per_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:start_date)
  end

  def bikes_started_per_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:bike_id)
  end

  private #???

  def m_common_of(collection) #name needs to change but waiting on tests to work in order to do so efficiently
    collection.max_by { |i| collection.count(i) }
  end

  def l_common_of(collection) #name needs to change but waiting on tests to work in order to do so efficiently
  end

end
