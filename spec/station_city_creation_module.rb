
module StationCityCreator
  def create_objects
    city_1 = City.create!(name: "San Jose")
    city_2 = City.create!(name: "Redwood City")
    city_3 = City.create!(name: "Mountain View")
    city_4 = City.create!(name: "Palo Alto")
    city_5 = City.create!(name: "San Francisco")
    station_1 = Station.create!(name: "Phil", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/12/2012',city_id: city_1.id)
    station_2 = Station.create!(name: "Triss", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/11/2012',city_id: city_3.id)
    station_3 = Station.create!(name: "Dante", latitude: 33.33, longitude: 33.22, dock_count: 23, installation_date: '22/10/2012',city_id: city_5.id)
  end

  def create_weather_objects
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
end
