class Station < ActiveRecord::Base
  belongs_to :city
  has_many :station_statuses
  validates :name,
            :latitude,
            :longitude,
            :dock_count,
            :installation_date,
            presence: true
end
