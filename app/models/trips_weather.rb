class TripsWeather < ActiveRecord::Base
  belongs_to :trips
  belongs_to :weathers
end
