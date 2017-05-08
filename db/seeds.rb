require 'csv'
require 'pry'
require './app/models/station'
require './app/models/city'
require './app/models/zip_code'
require './app/models/station_status'
require './app/models/trip'
require './app/models/subscription'

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

#load trip fixtures
CSV.foreach "db/csv/trip_fixture.csv", headers: true, header_converters: :symbol do |row|
  subscription = Subscription.find_or_create_by(name: row[:subscription_type].to_i)
  zip_code = Zip_Code.find_or_create_by(zip_code: row[:zip_code].to_i)

  start_station = Station.find_by(name: row[:start_station_name])
  end_station = Station.find_by(name: row[:end_station_name])

  start_date = row[:start_date]
  end_date = row[:end_date]

  Trip.create(duration: row[:duration].to_i, start_date: start_date,
              end_date: end_date, start_station_id: start_station.id,
              end_station_id: end_station.id, bike_id: row[:bike_id].to_i,
              zip_code_id: zip_code.id, subscription_id: subscription.id)
  binding.pry
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