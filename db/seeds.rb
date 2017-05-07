require 'csv'
require 'pry'
require './app/models/station'
require './app/models/city'
require './app/models/zip_code'
require './app/models/station_status'

def format_date(date)
    dt = date.split('/')
    dt[0], dt[1] = dt[1], dt[0]
    dt.join('/')
end

def add_zip_to_cities
  cities = City.all
  cities.each do |city|
    case city.name
    when "San Francisco"
      city.update(zip_code_id: 1)
    when "Redwood City"
      city.update(zip_code_id: 2)
    when "Palo Alto"
      city.update(zip_code_id: 3)
    when "Mountain View"
      city.update(zip_code_id: 4)
    when "San Jose"
      city.update(zip_code_id: 5)
    end
  end
end

CSV.foreach "db/csv/weather.csv", headers: true, header_converters: :symbol do |row|
  Zip_Code.create(zip_code: row[:zip_code])
end

CSV.foreach "db/csv/station.csv", headers: true, header_converters: :symbol do |row|
  city = City.create(name: row[:city])
  current_city = City.find_by(name: row[:city])

  Station.create!(name: row[:name],
                 latitude: row[:latitude] || 0,
                 longitude: row[:longitude] || 0,
                 dock_count: row[:dock_count],
                 installation_date: format_date(row[:installation_date]),
                 city_id: current_city.id)

  p "Creating Station #{row[:name]}, and City #{row[:city]} "
end

add_zip_to_cities

# CSV.foreach "db/csv/status.csv", headers: true, header_converters: :symbol do |row|
#   StationStatus.create(station_id: row[:station_id],
#                        bikes_available: row[:bikes_available],
#                        docks_available: row[:docks_available],
#                        time: row[:time])
#   p "Creating Station ID #{row[:station_id]}"
# end

CSV.foreach "db/csv/status_fixture.csv", headers: true, header_converters: :symbol do |row|
  StationStatus.create!(station_id: row[:station_id],
                       bikes_available: row[:bikes_available],
                       docks_available: row[:docks_available],
                       time: row[:time])
  p "Creating Station ID #{row[:station_id]}"
end