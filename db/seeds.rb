require 'csv'
require 'pry'
require './app/models/station'
require './app/models/city'
require './app/models/zip_code'
require './app/models/station_status'
require './app/models/trip'
require './app/models/subscription'
require './app/models/weather'

def validate_rows(input)
  input.nil? ? input = 0 : input
end

def format_date(date)
    dt = date.split('/')
    dt[0], dt[1] = dt[1], dt[0]
    dt.join('/')
end

def format_datetime(date)
  split_date = date.split(" ")[0].split("/")
  split_time = date.split(" ")[1].split(":")

  month = split_date[0].to_i
  day = split_date[1].to_i
  year = split_date[2].to_i
  hour = split_time[0].to_i
  min = split_time[1].to_i
  sec = 0

  DateTime.new(year, month, day, hour, min, sec)
end

def validate_station(station_name)
  case station_name
  when "Broadway at Main"
    station = "Stanford in Redwood City"
  when "San Jose Government Center"
    station = "Santa Clara County Civic Center"
  when "Post at Kearny"
    station = "Post at Kearney"
  when "Washington at Kearny"
    station = "Washington at Kearney"
  else
    station = station_name
  end
  station
end

CSV.foreach "db/csv/station.csv", headers: true, header_converters: :symbol do |row|
  city = City.find_or_create_by(name: row[:city])
  city.stations.create!(name: row[:name],
                latitude: row[:lat].to_f,
                longitude: row[:long].to_f,
                dock_count: row[:dock_count],
                installation_date: format_date(row[:installation_date]),
                city: city)

  puts "Creating Station #{row[:name]}, and City #{row[:city]} "
end

#load trip fixtures
CSV.foreach "db/csv/trip_fixture2.csv", headers: true, header_converters: :symbol do |row|
  subscription = Subscription.find_or_create_by(name: row[:subscription_type])
  zip_code = ZipCode.find_or_create_by(zip_code: row[:zip_code].to_i)

  start_station_name = validate_station(row[:start_station_name])
  end_station_name = validate_station(row[:end_station_name])

  start_station = Station.find_by(name: start_station_name)
  end_station = Station.find_by(name: end_station_name)

  start_date = format_datetime(row[:start_date])
  end_date = format_datetime(row[:end_date])

  Trip.create!(duration: row[:duration].to_i, start_date: start_date,
              end_date: end_date, start_station_id: start_station.id,
              end_station_id: end_station.id, bike_id: row[:bike_id].to_i,
              zip_code_id: zip_code.id, subscription_id: subscription.id)

  puts "creating Trip: #{start_station.name} to #{end_station.name}."
end


CSV.foreach "db/csv/weather.csv", headers: true, header_converters: :symbol do |row|
  zip_codes = {"94107" => "San Francisco",
               "94063" => "Redwood City",
               "94301" => "Palo Alto",
               "95113" => "San Jose",
               "94041" => "Mountain View"}

  city = zip_codes[row[:zip_code]]
  city_id = ((City.find_by(name: city).id))
  city_name = ((City.find_by(name: city).name))

  Weather.create!(date: format_date(row[:date]),
                  max_temp: validate_rows(row[:max_temperature_f]),
                  mean_temp: validate_rows(row[:mean_temperature_f]),
                  min_temp: validate_rows(row[:min_temperature_f]),
                  mean_humidity: validate_rows(row[:mean_humidity]),
                  mean_visibility: validate_rows(row[:mean_visibility_miles]),
                  mean_wind_speed: validate_rows(row[:mean_wind_speed_mph]),
                  precipitation: validate_rows(row[:precipitation_inches]),
                  city_id: city_id)

  puts "Adding weather for #{city_name}."
end


# CSV.foreach "db/csv/status.csv", headers: true, header_converters: :symbol do |row|
#   StationStatus.create(station_id: row[:station_id],
#                        bikes_available: row[:bikes_available],
#                        docks_available: row[:docks_available],
#                        time: row[:time])
#   p "Creating Station ID #{row[:station_id]}"
# end

# CSV.foreach "db/csv/status_fixture.csv", headers: true, header_converters: :symbol do |row|
#   StationStatus.create!(station_id: row[:station_id],
#                        bikes_available: row[:bikes_available],
#                        docks_available: row[:docks_available],
#                        time: row[:time])
#   p "Creating Station ID #{row[:station_id]}"
# end
