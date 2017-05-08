class StationStatus < ActiveRecord::Base
  belongs_to :stations
  validates :station_id,
            :bikes_available,
            :docks_available,
            presence: true
end
