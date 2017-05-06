require 'csv'

CSV.foreach "db/csv/station.csv", headers: true, header_converters: :symbol do |row|
  Station.create(name: row[:name],
                 latitude: row[:latitude],
                 longitude: row[:longitude],
                 dock_count: row[:dock_count],
                 installation_date: row[:installation_date]))
  p "Creating Station #{row[:name]} "
end

# CSV.foreach "db/csv/status.csv", headers: true, header_converters: :symbol do |row|
#   StationStatus.create(station_id: row[:station_id],
#                        bikes_available: row[:bikes_available],
#                        docks_available: row[:docks_available],
#                        time: row[:time])
#   p "Creating Station ID #{row[:station_id]}"
# end
#
# CSV.foreach "db/csv/trip.csv", headers: true, header_converters: :symbol do |row|
#
# end
