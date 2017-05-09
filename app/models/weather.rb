class Weather < ActiveRecord::Base
  belongs_to :city

  validates :date, presence: true
  validates :max_temp, presence: true
  validates :mean_temp, presence: true
  validates :min_temp, presence: true
  validates :mean_humidity, presence: true
  validates :mean_visibility, presence: true
  validates :mean_wind_speed, presence: true
  validates :precipitation, presence: true
  validates :city_id, presence: true
end