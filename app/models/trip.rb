class Trip < ActiveRecord::Base
  default_scope { order(start_date: :desc) }

  belongs_to :stations
  has_many :trips_weathers
  has_many :weathers, through: :trips_weathers
  has_many :weathers


  validates :duration, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_station_id, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_id, presence: true

  def get_info
    info = {}
    info[:start_station] = Station.find_by(id: self.start_station_id)
    info[:end_station] = Station.find_by(id: self.end_station_id)
    info[:zip_code] = ZipCode.find_by(id: self.zip_code_id)
    info[:subscription] = Subscription.find_by(id: self.subscription_id)

    return info
  end

  def self.avg(attribute)
    self.average(attribute).round(2)
  end

  def self.most_common(of_attribute)
    collection = self.pluck(of_attribute)
    most_common_out_of(collection)
  end

  def self.least_common(of_attribute)
    collection = self.pluck(of_attribute)
    least_common_out_of(collection)
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

  def self.end_stations_per_start_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:end_station_id)
  end

  def self.start_stations_per_end_station(end_station_id)
    self.where(end_station_id: end_station_id).pluck(:start_station_id)
  end

  def self.start_date_per_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:start_date)
  end

  def self.rides_on_day(date)
    self.where(start_date: date).count
  end

  def self.bikes_started_per_station(start_station_id)
    self.where(start_station_id: start_station_id).pluck(:bike_id)
  end

  def self.times_ridden(bike_id)
    self.where(bike_id: bike_id).count
  end

  private

  def self.most_common_out_of(collection)
    collection.max_by { |i| collection.count(i) }
  end

  def self.least_common_out_of(collection)
    collection.min_by { |i| collection.count(i) }
  end

end
