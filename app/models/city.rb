class City < ActiveRecord::Base
  has_many :stations
  belongs_to :weathers
  validates :name, presence: true, uniqueness: true

end
