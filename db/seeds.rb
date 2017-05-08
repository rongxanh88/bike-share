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

CSV.foreach "db/csv/station.csv", headers: true, header_converters: :symbol do |row|
  city = City.find_or_create_by(name: row[:city])
  city.stations.create!(name: row[:name],
                latitude: row[:latitude] || 0,
                longitude: row[:longitude] || 0,
                dock_count: row[:dock_count],
                installation_date: format_date(row[:installation_date]),
                city: city)

  p "Creating Station #{row[:name]}, and City #{row[:city]} "
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