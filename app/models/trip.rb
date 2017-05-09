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
    collection.max_by { |i| collection.count(i) }
  end

  def self.least_common(of_attribute)
    collection = self.pluck(of_attribute)
    collection.min_by { |i| collection.count(i) }
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

end
