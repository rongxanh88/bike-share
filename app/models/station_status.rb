class StationStatus < ActiveRecord::Base
  validates :station_id,
            :bikes_available,
            :docks_available,
            presence: true
end
