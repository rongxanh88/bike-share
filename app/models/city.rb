class City < ActiveRecord::Base
  has_one :zip_code
  has_many :stations
  validates :name, presence: true, uniqueness: true
  belongs_to :weathers
  validates :name, presence: true, uniqueness: true
end
