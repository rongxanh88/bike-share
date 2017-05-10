class Weather < ActiveRecord::Base
  default_scope { order(date: :desc) }

  belongs_to :city
  has_many :trips_weathers
  has_many :trips, through: :trips_weathers
  has_many :trips


  validates :date, presence: true
  validates :max_temp, presence: true
  validates :mean_temp, presence: true
  validates :min_temp, presence: true
  validates :mean_humidity, presence: true
  validates :mean_visibility, presence: true
  validates :mean_wind_speed, presence: true
  validates :precipitation, presence: true
  validates :city_id, presence: true


  def self.weather_by_date(date)
    Weather.find_by(date: date)
  end

  def self.mean_temp(date)
    weather_by_date = Weather.where(date: date)
    mean_temp = weather_by_date.average(:mean_temp).to_f
  end

  def self.max_temp(date)
    weather_by_date = Weather.where(date: date)
    max_temp = weather_by_date.maximum(:max_temp)
  end

  def self.min_temp(data)
    weather_by_date = Weather.where(date: date)
    min_temp = weather_by_date.average(:min_temp).to_f
  end

  def self.mean_humidity(data)
    weather_by_date = Weather.where(date: date)
    mean_humidity = weather_by_date.average(:mean_humidity).to_f
  end

  def self.mean_visibility(date)
    weather_by_date = Weather.where(date: date)
    mean_visibility = weather_by_date.average(:mean_visibility).to_f
  end

  def self.mean_wind_speed(date)
    weather_by_date = Weather.where(date: date)
    mean_wind_speed = weather_by_date.average(:mean_wind_speed).to_f
  end

  def self.precipitation(date)
    weather_by_date = Weather.where(date: date)
    precipitation = weather_by_date.average(:precipitation).to_f
  end

  def self.trips_on_nice_days
    nicest_days = Weather.select(:date).distinct.where(:mean_temp => 65.0..67.5)

    trips = nicest_days.map do |weather|
      year = weather.date.year
      month = weather.date.month
      day = weather.date.day

      beginning_day = Time.new(year,month,day,0,0)
      day_end = Time.new(year, month, day, 23, 59)

      trip = Trip.where(start_date: (beginning_day..day_end))
      trip if !trip.nil?
    end
    count = 0

    trips.each do |trip|
      count += trip.count
    end
    count
  end

end
