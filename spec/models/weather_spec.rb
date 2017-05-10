require_relative "../spec_helper"
require_relative "../station_city_creation_module"
require_relative '../../app/models/weather.rb'
require "pry"

RSpec.describe Trip do
  include StationCityCreator
  before(:each) do
    create_objects
    create_weather_objects
    create_trip_objects
  end

  describe "weather by date" do
    it "returns weather" do
      weather_by_date = Weather.where(date: "2013-12-22").count
      expect(weather_by_date).to eq(2)
    end

  end

  describe "model method" do
    it "returns max temp" do
      weather_by_date = Weather.where(date: "2013-12-22")
      max_temp = weather_by_date.maximum(:max_temp)
      expect(max_temp).to eq(81.0)
    end

    it "returns mean temp" do
      weather_by_date = Weather.where(date: "2013-12-22")
      mean_temp = weather_by_date.average(:mean_temp).to_f
      expect(mean_temp).to eq(72.0)
    end

    it "returns min temp" do
      weather_by_date = Weather.where(date: "2013-12-22")
      min_temp = weather_by_date.average(:min_temp).to_f
      expect(min_temp).to eq(63.5)
    end

    it "returns Mean Humidity" do
      weather_by_date = Weather.where(date: "2013-12-22")
      mean_humidity = weather_by_date.average(:mean_humidity).to_f
      expect(mean_humidity).to eq(70.0)
    end

    it "Mean Visibility (in Miles)" do
      weather_by_date = Weather.where(date: "2013-11-23")
      mean_visibility = weather_by_date.average(:mean_visibility).to_f
      expect(mean_visibility).to eq(11.0)
    end

    it "returns mean wind speed" do
      weather_by_date = Weather.where(date: "2013-12-22")
      mean_wind_speed = weather_by_date.average(:mean_wind_speed).to_f
      expect(mean_wind_speed).to eq(8.0)
    end

    it "returns precipitation" do
      weather_by_date = Weather.where(date: "2013-12-22")
      precipitation = weather_by_date.average(:precipitation).to_f
      expect(precipitation).to eq(0.0)
    end

    it "returns trips based on average/min/max temperature" do
      trips_on_weather_average = Weather.trips_on_days(40, 49.9, "average", :mean_temp)
      expect(trips_on_weather_average).to eq(0)
      trips_on_weather_min = Weather.trips_on_days(40, 49.9, "min", :min_temp)
      expect(trips_on_weather_min).to eq(0)
      trips_on_weather_max = Weather.trips_on_days(40, 49.9, "min", :max_temp)
      expect(trips_on_weather_max).to eq(0)
    end

    it "returns trips based on precipitation" do
      trips_on_weather_precip = Weather.trips_on_days(0.0, 0.49, "average", :precipitation)
      binding.pry
    end
  end
end
