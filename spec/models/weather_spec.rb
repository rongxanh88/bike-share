require_relative "../spec_helper"
require_relative "../station_city_creation_module"
require "pry"

RSpec.describe Trip do
  include StationCityCreator
  before(:each) do
    create_cities
#Weather id: 737, date: "2013-08-29", max_temp: 81.0, mean_temp: 72.0, min_temp: 63.0, mean_humidity: 69.0, mean_visibility: 10.0, mean_wind_speed: 7.0, precipitation: 0.0, city_id: 1
    Weather.create!(date: "2013-12-22",
                    max_temp: 80.0,
                    mean_temp: 72.0,
                    min_temp: 63.0,
                    mean_humidity: 70.0,
                    mean_visibility: 10.0,
                    mean_wind_speed: 8.0,
                    precipitation: 0.0,
                    city_id: 1)
    Weather.create!(date: "2013-12-22",
                    max_temp: 81.0,
                    mean_temp: 72.0,
                    min_temp: 64.0,
                    mean_humidity: 70.0,
                    mean_visibility: 10.0,
                    mean_wind_speed: 8.0,
                    precipitation: 0.0,
                    city_id: 1)
    Weather.create!(date: "2013-11-23",
                    max_temp: 70.0,
                    mean_temp: 74.0,
                    min_temp: 60.0,
                    mean_humidity: 71.0,
                    mean_visibility: 11.0,
                    mean_wind_speed: 4.0,
                    precipitation: 0.0,
                    city_id: 1)
    Weather.create!(date: "2014-10-25",
                    max_temp: 60.0,
                    mean_temp: 73.0,
                    min_temp: 63.0,
                    mean_humidity: 72.0,
                    mean_visibility: 10.0,
                    mean_wind_speed: 9.0,
                    precipitation: 0.0,
                    city_id: 2)
  end

  describe "weather by date" do
    it "returns weather" do
      weather_by_date = Weather.where(date: "2013-12-22").count
      expect(weather_by_date).to eq(2)
    end
  end

  describe "model method" do
    it "returns max temp" do
      max_temp = Weather.maximum(:max_temp)
      max_temp_city = Weather.maximum(:max_temp).name
      binding.pry
    end
  end
end
