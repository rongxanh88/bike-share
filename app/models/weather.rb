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

  def self.trips_on_nice_days(low_temp, high_temp, metric)
    nicest_days = Weather.select(:date).distinct.where(:mean_temp => low_temp..high_temp)

    trips = nicest_days.map do |weather|
      year = weather.date.year
      month = weather.date.month
      day = weather.date.day

      beginning_day = Time.new(year,month,day,0,0)
      day_end = Time.new(year, month, day, 23, 59)

      trip = Trip.where(start_date: (beginning_day..day_end))
    end

    answer = 0

    case metric
    when "average"
      answer = average_number_of_rides(trips)
    when "min"
      answer = min_number_of_rides(trips)
    when "max"
      answer = max_number_of_rides(trips)
    end

    answer
  end

  private

  def self.average_number_of_rides(trips)
    number_of_days = 0
    count = 0

    trips.each do |trip|
      count += trip.count
      number_of_days += 1 if trip.count > 0
    end

    if number_of_days > 0
      return count / number_of_days
    else
      return 0
    end
  end

  def self.min_number_of_rides(trips)
    answer = trips.min_by do |trip|
      trip.count
    end
    if answer.nil?
      nilify(answer)
    else
      answer.empty? ? 0 : answer.count
    end
  end

  def self.max_number_of_rides(trips)
    answer = trips.max_by do |trip|
      trip.count
    end
    if answer.nil?
      nilify(answer)
    else
      answer.empty? ? 0 : answer.count
    end
  end

  def self.nilify(answer)
    answer = 0
    answer
  end

end
